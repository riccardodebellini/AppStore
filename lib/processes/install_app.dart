import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

FirebaseFirestore fs = FirebaseFirestore.instance;

class InstallApp {
  showSheet(BuildContext context, String appName) {
    showModalBottomSheet(
        showDragHandle: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ChooseInstallation(
              appName: appName,
            ),
          );
        });
  }

  Future<void> downloadAndInstallWindowsApplication(
      BuildContext context, String repo, String name) async {
    double progress = 0.0;
    final folder = await getApplicationSupportDirectory();
    final destination = File("${folder.path}\\$name\\installer.exe");

    final progressStream = StreamController<double>.broadcast();

    showDialog(
      context: context,
      builder: (context) =>
          DownloadProgressDialog(progressStream: progressStream.stream),
    );

    await Dio().download(repo, destination.path,
        onReceiveProgress: (received, total) {
      progress = received / total;
      progressStream.add(progress); // Update progress stream
    });

    progressStream.close(); // Close the stream after download

    await OpenFilex.open(destination.path);
    await FirebaseFirestore.instance
        .collection("apps")
        .doc(name)
        .update({"downloads": FieldValue.increment(1)});
  }

  Future<void> downloadWindowsApplication(String repo, String name) async {
    final folder = await getApplicationSupportDirectory();
    final destination = File("${folder.path}\\$name\\installer.exe");

    await Dio().download(repo, destination.path);
    await OpenFilex.open(destination.path);
    await FirebaseFirestore.instance
        .collection("apps")
        .doc(name)
        .update({"downloads": FieldValue.increment(1)});
  }
}

class DownloadProgressDialog extends StatelessWidget {
  final Stream<double> progressStream;

  const DownloadProgressDialog({super.key, required this.progressStream});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: StreamBuilder<double>(
        stream: progressStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return CircularProgressIndicator(
              value: snapshot.data!,
            );
          } else {
            return const CircularProgressIndicator(); // Show indeterminate indicator initially
          }
        },
      ),
    );
  }
}

class ChooseInstallation extends StatelessWidget {
  final String appName;

  const ChooseInstallation({super.key, required this.appName});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Scegli l'installazione di $appName che fa per te"),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: fs
              .collection("apps")
              .doc(appName)
              .collection("deploys")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const ListTile(
                  leading: Icon(Icons.error_rounded),
                  title: Text('Errore nel caricamento'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ListTile(
                leading: Icon(Icons.downloading_rounded),
                title: Text("Caricamento..."),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final deploy =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;

                return InstallationDetails(details: deploy, name: appName);
              },
            );
          },
        )
      ],
    );
  }
}

class InstallationDetails extends StatelessWidget {
  final String name;
  final Map<String, dynamic> details;

  const InstallationDetails(
      {super.key, required this.details, required this.name});

  @override
  Widget build(BuildContext context) {
    if (details['type'] == "android") {
      return ListTile(
        title: Text("Android"),
        subtitle: Text(
            "Verrà installato semi manualmente l'APK (il file dell'applicazione) \nAttenzione: nel corso della procedura sarà richiesto l'intervento dell'utente più volte. seguire le istruzioni a schermo"),
        isThreeLine: true,
        trailing: FilledButton(
            child: Text(
              "Usa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: !kIsWeb
                ? Platform.isAndroid
                    ? () {
                        print("helloworld");
                      }
                    : null
                : null),
      );
    } else if (details['type'] == "web") {
      return ListTile(
        title: Text("Web"),
        subtitle: Text("Apri pagina web"),
        isThreeLine: true,
        trailing: FilledButton(
            child: Text(
              "Vai",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              launchUrl(Uri.parse(details['open_id'].toString()));
            }),
      );
    } else if (details['type'] == "windows-installer") {
      return ListTile(
        title: Text("Windows"),
        subtitle: Text(
            "Verrà installato semi manualmente l'APK (il file dell'applicazione) \nAttenzione: nel corso della procedura sarà richiesto l'intervento dell'utente più volte. seguire le istruzioni a schermo"),
        isThreeLine: true,
        trailing: FilledButton(
            child: Text(
              "Usa",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: !kIsWeb
                ? Platform.isWindows
                    ? () {
                        InstallApp().downloadAndInstallWindowsApplication(
                            context, details['open_id'], name);
                      }
                    : null
                : null),
      );
    } else {
      return ListTile();
    }
  }
}

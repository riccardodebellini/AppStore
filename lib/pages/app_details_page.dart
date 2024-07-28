import 'package:app_store/processes/install_app.dart';
import 'package:app_store/utils/app_icon.dart';
import 'package:flutter/material.dart';

class AppDetailsPage extends StatelessWidget {
  final Map<String, dynamic> app;

  AppDetailsPage({super.key, required this.app});

  List _deviceChips() {
    final List _list = app['devices'];
    return List.generate(_list.length, (index) {
      return app['devices'][index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(app['name'].toString()),
      ),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Card(
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.primary
                  ],
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  runAlignment: WrapAlignment.spaceEvenly,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      height: 125,
                      child: AppIcon(
                        details: app,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          app['name'].toString(),
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'da "' + app['developer'] + '"',
                          style: Theme.of(context).textTheme.labelLarge,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        ListTile(
          title: FilledButton.tonal(
            onPressed: () {
              InstallApp().showSheet(context, app['name'].toString());
            },
            child: Text(
              "Scegli la versione che fa per te",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ListTile(
          title: Text("Device compatibili"),
          subtitle: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_deviceChips().length, (index) {
              return InputChip(
                label: Text(_deviceChips()[index].toString()),
                selected: true,
                onPressed: () {},
              );
            }),
          ),
          leading: Icon(Icons.devices_rounded),
        ),
        ListTile(title: Divider()),

        ListTile(
          title: Text("Nome app"),
          subtitle: Text(app['name']),
          leading: Icon(Icons.title_rounded),
        ),

        ListTile(
          title: Text("Sviluppatore"),
          subtitle: Text(app['developer'] ?? "--"),
          trailing: Icon(Icons.arrow_forward_rounded),
          leading: Icon(Icons.verified_user_rounded),
        ),

        ListTile(
          title: Text("Downloads"),
          subtitle: Text(app['downloads'].toString() + " +"),
          leading: Icon(Icons.download_rounded),
        ),

        //TODO: informazioni
        ListTile(
          title: Text("Altre informazioni"),
          subtitle: Text(app['info'] ?? "--"),
          leading: Icon(Icons.info_rounded),
        ),
        //TODO: Aggiornamenti
        ListTile(
          title: Text("Ultimo aggiornamento"),
          subtitle: Text(app['last_update'] ?? "--"),
          leading: Icon(Icons.update_rounded),
        ),
      ]),
    );
  }
}

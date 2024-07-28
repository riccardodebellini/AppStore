import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final Map<String, dynamic> details;

  const AppIcon({super.key, required this.details});

  Future<String> getImageUrl(String productName, imageName) async {
    final reference =
        FirebaseStorage.instance.ref().child(productName).child(imageName);
    final url = await reference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Card.filled(
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: details["icon"] != null
            ? FutureBuilder<String>(
                future: getImageUrl(
                    details["name"].toString(), details['icon'].toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Icon(Icons.error);
                  }
                  if (snapshot.hasData) {
                    return Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover,
                    );
                  }
                  return const Center(
                    child: Icon(Icons.downloading_rounded),
                  );
                },
              )
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image_not_supported_rounded),
                  Text("nessun immagine"),
                ],
              ),
      ),
    );
  }
}

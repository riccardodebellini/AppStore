import 'package:app_store/utils/app_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppList extends StatelessWidget {
  final Stream<QuerySnapshot<Object>> snapshot;

  const AppList({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: StreamBuilder<QuerySnapshot>(
          stream: snapshot,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Errore nel caricamento'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Icon(Icons.downloading_rounded),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                final app =
                    snapshot.data?.docs[index].data() as Map<String, dynamic>;

                return AppCard(
                  app: app,
                );
              },
            );
          },
        ));
  }
}

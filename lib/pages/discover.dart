import 'package:app_store/utils/app_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        // Banner placeholder
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 300,
            child: Card.filled(
              child: Center(
                child: Text('Banner goes here'),
              ),
            ),
          ),
        ),

        // Trending Apps section
        const ListTile(
          title: Text("App di tendenza"),
        ),
        AppList(
          snapshot: FirebaseFirestore.instance
              .collection("apps")
              .orderBy('downloads', descending: true)
              .limit(6)
              .snapshots(),
        ),

        // Recently Added Services section
        const ListTile(
          title: Text("Servizi aggiunti di recente"),
        ),
        SizedBox(
          height: 250,
          child: ListView.separated(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 16,
            ),
            itemCount: 10,
            // Adjust for desired number of service cards
            itemBuilder: (context, index) => SizedBox(
              width: 150,
              child: Card.filled(
                child: Center(
                  child: Text('Service $index'), // Replace with service details
                ),
              ),
            ),
          ),
        ),

        // Footer
        const ListTile(
          title: Divider(),
          subtitle: Text("Tutti i diritti riservati © 2024 Riccardo Debellini"),
        ),
      ],
    );
  }
}

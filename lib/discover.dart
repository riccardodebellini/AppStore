import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SizedBox(
            height: 300,
            child: Card.filled(),
          ),
        ),
        ListTile(
          title: Text("App di tendenza"),
        ),
        SizedBox(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 200, child: Card.filled(

                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [Container(color: Colors.green, height: 176, ), FilledButton(onPressed: () {}, child: Text("Test"))], mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              )),
              VerticalDivider(),
              SizedBox(width: 200, child: Card.filled()),
              VerticalDivider(),
              SizedBox(width: 200, child: Card.filled()),
              VerticalDivider(),
              SizedBox(width: 200, child: Card.filled()),
              VerticalDivider(),
            ],
          ),
        ),
        ListTile(
          title: Text("Servizi aggiunti di recente"),
        ),
        SizedBox(
          height: 300,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 200, child: Card.filled()),
              VerticalDivider(),
              SizedBox(width: 200, child: Card.filled()),
              VerticalDivider(),
              SizedBox(width: 200, child: Card.filled()),
              VerticalDivider(),
              SizedBox(width: 200, child: Card.filled()),
              VerticalDivider(),
            ],
          ),
        ),
        ListTile(
          title: Divider(),
          subtitle: Text("Tutti i diritti riservati © 2024 Riccardo Debellini"),
        ),
      ],
    );
  }
}

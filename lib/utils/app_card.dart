import 'package:app_store/pages/app_details_page.dart';
import 'package:app_store/utils/app_icon.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Map<String, dynamic> app;

  const AppCard({super.key, required this.app});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AppDetailsPage(
              app: app,
            );
          }));
        },
        child: SizedBox(
          width: 150,
          child: Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(details: app),
                  Flexible(
                    child: Text(
                      app['name'].toString(),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

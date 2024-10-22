// IMPORT

import 'package:flutter/material.dart';

class MainNavigationDest {
  final String text;
  final Icon icon;
  final Widget destination;
  final String appBarTitle;
  final List<Widget>? appBarActions;
  final bool? centerTitle;

  const MainNavigationDest({
    required this.appBarTitle,
    this.appBarActions,
    this.centerTitle,
    required this.text,
    required this.icon,
    required this.destination,
  });
}

class MainNavigationFAB {
  final Function onPressed;
  final Icon icon;
  final String label;

  const MainNavigationFAB(
      {required this.onPressed, required this.icon, required this.label});
}

class MainNavigation extends StatefulWidget {
  final List<MainNavigationDest> pageData;
  final bool? useFAB;
  final MainNavigationFAB? dataFAB;

  const MainNavigation({
    super.key,
    required this.pageData,
    this.useFAB,
    this.dataFAB,
  });

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? Scaffold(
            appBar: AppBar(
              title: Text(widget.pageData[currentIndex].appBarTitle),
              centerTitle: widget.pageData[currentIndex].centerTitle,
              actions: widget.pageData[currentIndex].appBarActions,
            ),
            body: Row(children: [
              NavigationRail(
                leading: widget.useFAB == true
                    ? FloatingActionButton(
                        heroTag: null,
                        onPressed: widget.dataFAB?.onPressed(),
                        child: widget.dataFAB?.icon,
                      )
                    : null,
                selectedIndex: currentIndex,
                labelType: NavigationRailLabelType.all,
                onDestinationSelected: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                destinations: List.generate(widget.pageData.length, (index) {
                  return NavigationRailDestination(
                      icon: widget.pageData[index].icon,
                      label: Text(widget.pageData[index].text));
                }),
              ),
              Expanded(child: widget.pageData[currentIndex].destination),
            ]))
        : Scaffold(
            appBar: AppBar(
              title: Text(widget.pageData[currentIndex].appBarTitle),
              centerTitle: widget.pageData[currentIndex].centerTitle,
              actions: widget.pageData[currentIndex].appBarActions,
            ),
            floatingActionButton: widget.useFAB == true
                ? FloatingActionButton.extended(
                    heroTag: null,
                    label: Text(widget.dataFAB!.label),
                    onPressed: widget.dataFAB?.onPressed(),
                    icon: widget.dataFAB!.icon,
                  )
                : null,
            body: widget.pageData[currentIndex].destination,
            bottomNavigationBar: NavigationBar(
              destinations: List.generate(widget.pageData.length, (index) {
                return NavigationDestination(
                    icon: widget.pageData[index].icon,
                    label: widget.pageData[index].text);
              }),
              selectedIndex: currentIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
          );
  }
}

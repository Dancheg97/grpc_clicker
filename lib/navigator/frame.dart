import 'package:flutter/material.dart';

class NavigatorFrame extends StatelessWidget {
  const NavigatorFrame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(42),
          child: AppBar(
            toolbarHeight: 0,
            bottom: const TabBar(
              tabs: [
                CustomTab(text: "API's"),
                CustomTab(text: "history"),
                CustomTab(text: "tests"),
              ],
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}

class CustomTab extends StatelessWidget {
  final String text;
  const CustomTab({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: Center(child: Text(text)),
    );
  }
}

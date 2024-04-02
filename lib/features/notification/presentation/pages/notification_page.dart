import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              toolbarHeight: 0,
              automaticallyImplyLeading: false,
              bottom: const TabBar(tabs: [
                Tab(
                  text: 'Chats',
                ),
                Tab(
                  text: 'Notification',
                ),
              ]),
            ),
            body: TabBarView(
              children: [
                Container(),
                Container(),
              ],
            ),
          ),
        ));
  }
}

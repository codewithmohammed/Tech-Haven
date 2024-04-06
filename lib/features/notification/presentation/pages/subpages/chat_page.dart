import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            toolbarHeight: 50,
            forceElevated: false,
            scrolledUnderElevation: 0,
            elevation: 0,
            automaticallyImplyLeading: false,
            snap: true,
            // pinned: true,

            floating: true,
            //the whole height of the appBar
            // expandedHeight: 40,
            //the height of the app bar when it is collapsed or scrolled
            collapsedHeight: 56,
            stretchTriggerOffset: 100,
            onStretchTrigger: () async {},
            flexibleSpace: const FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: AppBarSearchBar(
                  hintText: 'Search Chats',
                  favouriteIconNeeded: false,
                  deliveryPlaceNeeded: false,
                ),
              ),
              expandedTitleScale: 1,
              centerTitle: true,
            ),
          ),
        ],
        body: ListView.builder(
          itemCount: 40,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.red,
              ),
              title: const Text('Name'),
              subtitle: const Text('Last Message'),
              trailing: const CircleAvatar(
                radius: 5,
                backgroundColor: Colors.red,
              ),
              onTap: () {
                print('object');
              },
            );
          },
        ),
      ),
    );

    //    Scaffold(
    //       body: NestedScrollView(
    //     // slivers: [

    //     //   // SliverToBoxAdapter(
    //     //   //   child: SliverList.builder(
    //     //   //     itemCount: 40,
    //     //   //     itemBuilder: (context, index) {
    //     //   //       (context, index) {
    //     //   //         return ListTile(
    //     //   //           leading: const CircleAvatar(
    //     //   //             backgroundColor: Colors.red,
    //     //   //           ),
    //     //   //           title: const Text('Name'),
    //     //   //           subtitle: const Text('Last Message'),
    //     //   //           trailing: const CircleAvatar(
    //     //   //             radius: 5,
    //     //   //             backgroundColor: Colors.red,
    //     //   //           ),
    //     //   //           onTap: () {
    //     //   //             print('object');
    //     //   //           },
    //     //   //         );
    //     //   //       };
    //     //   //       return null;
    //     //   //     },
    //     //   //   ),
    //     //   // )
    //     //   SliverToBoxAdapter(

    //     //   )
    //     // ],
    //     headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //       return [

    //       ];
    //     },
    // body:

    //   ));
    // }
  }
}

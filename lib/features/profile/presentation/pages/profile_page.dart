import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: const AppBarSearchBar(),
        body: Container(
          //column for the whole
          child: const Column(
            children: [
              //hello nice to meet you
              ProfileWelcomeText(),
              //your orders
              Row(
                children: [
                  Icon(Icons.card_travel),
                  Text('data'),
                ],
              )
            ],
          ),
        ));
  }
}

class ProfileWelcomeText extends StatelessWidget {
  const ProfileWelcomeText({
    super.key,
    this.name = 'Nice to meet you',
  });
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      color: AppPallete.lightgreyColor,
      height: 80,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlobalTitleText(
            title: 'Hello! $name',
            fontSize: 15,
          ),
          const Text(
            'You are currently not signed in',
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}

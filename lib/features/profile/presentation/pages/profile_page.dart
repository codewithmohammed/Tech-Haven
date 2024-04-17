import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/features/profile/presentation/widgets/profile_header_tile.dart';
import 'package:tech_haven/features/profile/presentation/widgets/profile_welcome_text.dart';
import 'package:tech_haven/features/profile/presentation/widgets/tile_bar_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: const AppBarSearchBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //hello nice to meet you
              const ProfileWelcomeText(),
              //your orders
              const TileBarButton(
                title: 'Your Orders',
                icon: CustomIcons.orderListSvg,
              ),
              const TileBarButton(
                title: 'Start Selling',
                subtitle:
                    'Activate this option to start selling your products as a vendor on our platform.',
                icon: CustomIcons.cartSvg,
              ),
              const ProfileHeaderTile(
                title: 'SETTINGS',
              ),
              const TileBarButton(
                title: 'Country',
                icon: CustomIcons.globeSvg,
              ),
              const TileBarButton(
                title: 'Language',
                icon: CustomIcons.languageSvg,
              ),
              const ProfileHeaderTile(
                title: 'REACH OUT TO US',
              ),
              const TileBarButton(
                title: 'Help Center',
                icon: CustomIcons.questionMarkSvg,
              ),
              const TileBarButton(
                title: 'About App',
                icon: CustomIcons.exclamationSvg,
              ),
              TileBarButton(
                title: 'Sign Out',
                icon: CustomIcons.rightArrowExitSvg,
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  // context.read<AuthBloc>().add(SignOutUserEvent());
                },
              ),
              // Row(
              //   children: [
              //     Icon(Icons.card_travel),
              //     Text('data'),
              //   ],
              // )
            ],
          ),
        ));
  }
}

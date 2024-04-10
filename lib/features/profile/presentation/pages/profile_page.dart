import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/features/profile/presentation/widgets/profile_welcome_text.dart';

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
              TileBarButton(
                title: 'Your Orders',
                icon: CustomIcons.orderListSvg,
              ),
              TileBarButton(
                title: 'Start Selling',
                subtitle:
                    'Activate this option to start selling your products as a vendor on our platform.',
                icon: CustomIcons.cartSvg,
              ),
              ProfileHeader(
                title: 'SETTINGS',
              ),
              TileBarButton(
                title: 'Country',
                icon: CustomIcons.globeSvg,
              ),
              TileBarButton(
                title: 'Language',
                icon: CustomIcons.languageSvg,
              ),
              ProfileHeader(
                title: 'REACH OUT TO US',
              ),
              TileBarButton(
                title: 'Help Center',
                icon: CustomIcons.questionMarkSvg,
              ),
              TileBarButton(
                title: 'About App',
                icon: CustomIcons.exclamationSvg,
              ),
              TileBarButton(
                title: 'Sign Out',
                icon: CustomIcons.rightArrowExitSvg,
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

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      color: AppPallete.lightgreyColor,
      height: 45,
      width: double.infinity,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }
}

class TileBarButton extends StatelessWidget {
  const TileBarButton({
    super.key,
    required this.title,
    required this.icon,
    this.subtitle,
    this.color = AppPallete.primaryAppButtonColor,
    this.trailing,
  });
  final String title;
  final String icon;
  final String? subtitle;
  final Color color;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      onTap: () {},
      leading: SvgIcon(
        icon: icon,
        radius: 20,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 10,
              ),
            )
          : null,
      trailing: trailing != null
          ? Row(
              children: [
                trailing!,
                const SvgIcon(
                  icon: CustomIcons.angleRightSvg,
                  radius: 15,
                ),
              ],
            )
          : const SvgIcon(
              icon: CustomIcons.angleRightSvg,
              radius: 15,
            ),
    );
  }
}

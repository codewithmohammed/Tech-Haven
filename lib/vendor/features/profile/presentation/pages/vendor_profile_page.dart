import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/profile_header_tile.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/profile_welcome_text.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/tile_bar_button.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';

class VendorProfilePage extends StatelessWidget {
  const VendorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: const VendorAppBar(
            title: 'Profile',
            bottom: null,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                //hello nice to meet you
                const ProfileWelcomeText(
                  name: 'Rayid',
                  subText: 'Enjoy Selling withTexh Heaven',
                ),
                //your orders
                TileBarButton(
                  title: 'Your Orders',
                  icon: CustomIcons.orderListSvg,
                  onTap: () {},
                ),
                // TileBarButton(
                //   title: 'Switch To Customer Mode',
                //   subtitle:
                //       'Activate this option to start selling your products as a vendor on our platform.',
                //   icon: CustomIcons.cartSvg,
                //   onTap: () {
                //     GoRouter.of(context).pushNamed(
                //       AppRouteConstants.vendorMainPage,
                //     );
                //   },
                // ),
                // const ProfileHeaderTile(
                //   title: 'SETTINGS',
                // ),
                // const TileBarButton(
                //   title: 'Country',
                //   icon: CustomIcons.globeSvg,
                // ),
                // const TileBarButton(
                //   title: 'Language',
                //   icon: CustomIcons.languageSvg,
                // ),
                const ProfileHeaderTile(
                  title: 'REACH OUT TO US',
                ),
                const TileBarButton(
                  title: 'Help Center',
                  icon: CustomIcons.questionMarkSvg,
                ),
                // const TileBarButton(
                //   title: 'About App',
                //   icon: CustomIcons.exclamationSvg,
                // ),
                TileBarButton(
                  title: 'Sign Out',
                  icon: CustomIcons.rightArrowExitSvg,
                  onTap: () {
                    // FirebaseAuth.instance.signOut();
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
          )),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/appbar_searchbar.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/user/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/profile_header_tile.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/profile_welcome_text.dart';
import 'package:tech_haven/user/features/profile/presentation/widgets/tile_bar_button.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProfileBloc>().add(GetUserProfileDataEvent());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        appBar: const AppBarSearchBar(),
        body: SingleChildScrollView(
          child: BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            buildWhen: (previous, current) => current is GetProfileDataState,
            builder: (context, state) {
              // if(state is GetProfileDataSuccessState){
              //   return
              // }
              return Column(
                children: [
                  //hello nice to meet you
                  ProfileWelcomeText(
                    name: state is GetProfileDataSuccessState
                        ? state.user.username!
                        : 'Nice to meet you',
                    subText: state is GetProfileDataSuccessState
                        ? 'Enjoy your Tech Journey with Tech Haven'
                        : 'You are currently not signed in',
                  ),
                  //your orders
                  TileBarButton(
                    title: 'Your Orders',
                    icon: CustomIcons.orderListSvg,
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.userOrderPage);
                    },
                  ),
                  TileBarButton(
                    title: state is GetProfileDataSuccessState
                        ? state.user.isVendor
                            ? 'Enter Vendor Mode'
                            : 'Start Selling'
                        : 'Please Wait',
                    subtitle: state is GetProfileDataSuccessState
                        ? state.user.isVendor
                            ? 'Start Selling your new Product!'
                            : 'Activate this option to start selling your products as a vendor on our platform.'
                        : 'Please Wait',
                    icon: CustomIcons.cartSvg,
                    onTap: () {
                      //if the user is vendor we will direct them to vendor else wilill direct him to register page where they will see the status of the vendor status.
                      state is GetProfileDataSuccessState && state.user.isVendor
                          ? GoRouter.of(context)
                              .pushNamed(AppRouteConstants.vendorMainPage)
                          : state is GetProfileDataSuccessState &&
                                  !state.user.isVendor
                              ? GoRouter.of(context).pushNamed(
                                  AppRouteConstants.registerVendorPage,
                                  extra: state.user)
                              : null;
                    },
                  ),
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
                  TileBarButton(
                    title: 'Help Center',
                    onTap: () {
                      GoRouter.of(context)
                          .pushNamed(AppRouteConstants.helpCenterPage);
                    },
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
                      GoRouter.of(context)
                          .goNamed(AppRouteConstants.splashScreen);
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
              );
            },
          ),
        ));
  }
}

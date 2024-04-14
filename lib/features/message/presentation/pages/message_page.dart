import 'package:flutter/material.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/circular_button.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/theme/theme.dart';
import 'package:tech_haven/features/message/presentation/pages/widgets/message_card.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        toolbarHeight: 65,
        leadingWidth: 100,
        backgroundColor: AppPallete.primaryAppColor,
        leading: Row(
          children: [
            CircularButton(
              onPressed: () {},
              color: AppPallete.primaryAppColor,
              shadow: false,
              diameter: 50,
              circularButtonChild: const SvgIcon(
                icon: CustomIcons.arrowLeftSvg,
                radius: 15,
              ),
            ),
            const CircleAvatar(
              radius: 25,
            )
          ],
        ),
        title: const GlobalTitleText(
          title: 'Name',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const MessageCard();
              },
            ),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              // borderRadius: BorderRadius.all(
              //   Radius.circular(
              //     50,
              //   ),
              // ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: AppTheme.inputDecoration.copyWith(
                      hintText: 'Message',
                      prefixIcon: GestureDetector(
                        onTap: () {
                          //on click the emoji
                        },
                        child: const SvgIcon(
                          icon: CustomIcons.faceGrinSvg,
                          radius: 15,
                          color: AppPallete.greyTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
                // const SizedBox(
                //   width: 5,
                // ),
                CircularButton(
                  onPressed: () {},
                  circularButtonChild: const SvgIcon(
                    icon: CustomIcons.microphoneSvg,
                    radius: 25,
                  ),
                  diameter: 55,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class MessageCard extends StatelessWidget {
//   const MessageCard({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(
//         left: 25,
//       ),
//       child: Card(
//         color: AppPallete.primaryAppColor.withOpacity(0.5),
//         elevation: 1,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         child: Stack(
//           children: [
//             Column(
//               children: [
//                 Container(
//                     padding: const EdgeInsets.all(10),
//                     decoration: const BoxDecoration(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(
//                           5,
//                         ),
//                       ),
//                     ),
//                     child: const Text(
//                         'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')),
//                 const SizedBox(height: 8),
//               ],
//             ),
//             const Positioned(
//               bottom: 4,
//               right: 10,
//               child: Row(
//                 children: [
//                   Text(
//                     'time',
//                     style: TextStyle(
//                       fontSize: 13,
//                       color: Colors.white60,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Icon(
//                     Icons.done_all,
//                     size: 20,
//                     color: Colors.blue,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

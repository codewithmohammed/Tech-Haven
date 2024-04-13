import 'package:flutter/material.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:tech_haven/core/common/enums/message_enum.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/features/message/presentation/pages/widgets/display_text_image_gif.dart';

// class MessageCard extends StatelessWidget {
//   final String message;
//   final String date;
//   final MessageEnum type;
//   final VoidCallback onLeftSwipe;
//   final String repliedText;
//   final String username;
//   final MessageEnum repliedMessageType;
//   final bool isSeen;

//   const MessageCard({
//     super.key,
//     required this.message,
//     required this.date,
//     required this.type,
//     required this.onLeftSwipe,
//     required this.repliedText,
//     required this.username,
//     required this.repliedMessageType,
//     required this.isSeen,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isReplying = repliedText.isNotEmpty;

//     return SwipeTo(
//       // onLeftSwipe:,
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: ConstrainedBox(
//           constraints: BoxConstraints(
//             maxWidth: MediaQuery.of(context).size.width - 45,
//           ),
//           child: Card(
//             elevation: 1,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             color: Colors.red,
//             margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//             child: Stack(
//               children: [
//                 Padding(
//                   padding: type == MessageEnum.text
//                       ? const EdgeInsets.only(
//                           left: 10,
//                           right: 30,
//                           top: 5,
//                           bottom: 20,
//                         )
//                       : const EdgeInsets.only(
//                           left: 5,
//                           top: 5,
//                           right: 5,
//                           bottom: 25,
//                         ),
//                   child: Column(
//                     children: [
//                       if (isReplying) ...[
//                         Text(
//                           username,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 3),
//                         Container(
//                             padding: const EdgeInsets.all(10),
//                             decoration: const BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(
//                                   5,
//                                 ),
//                               ),
//                             ),
//                             child: const Text('data')),
//                         const SizedBox(height: 8),
//                       ],
//                       Text(message)
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 4,
//                   right: 10,
//                   child: Row(
//                     children: [
//                       Text(
//                         date,
//                         style: const TextStyle(
//                           fontSize: 13,
//                           color: Colors.white60,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         isSeen ? Icons.done_all : Icons.done,
//                         size: 20,
//                         color: isSeen ? Colors.blue : Colors.white60,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class MessageCard extends StatelessWidget {
  const MessageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25,
      ),
      child: Card(
        color: AppPallete.primaryAppColor.withOpacity(0.5),
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                    ),
                    child: const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.')),
                const SizedBox(height: 8),
              ],
            ),
            const Positioned(
              bottom: 4,
              right: 10,
              child: Row(
                children: [
                  Text(
                    'time',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.done_all,
                    size: 20,
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

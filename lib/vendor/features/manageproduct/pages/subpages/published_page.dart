import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tech_haven/core/common/widgets/svg_icon.dart';
import 'package:tech_haven/core/icons/icons.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class PublishedPage extends StatefulWidget {
  const PublishedPage({super.key});

  @override
  State<PublishedPage> createState() => _PublishedPageState();
}

class _PublishedPageState extends State<PublishedPage> {
  @override
  Widget build(BuildContext context) {
// void _handleOpen() {
//   controller.close();
// }
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
        ],
        body: ListView.builder(
          itemCount: 40,
          itemBuilder: (context, index) {
            return Slidable(
              // enabled:,
              startActionPane:
                  ActionPane(motion: const StretchMotion(), children: [
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.unpublished,
                  label: 'UnPublish',
                  padding: const EdgeInsets.all(
                    2,
                  ),
                ),
                SlidableAction(
                  onPressed: (context) {},
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  padding: const EdgeInsets.all(
                    2,
                  ),
                ),
              ]),
              child: ListTile(
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    color: AppPallete.darkgreyColor,
                  ),
                  child: Image.asset('assets/dev/hp-laptop-png.png'),
                ),
                title: const Text('Name'),
                subtitle: const Text('Last Message'),
                // trailing:
                onTap: () {
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

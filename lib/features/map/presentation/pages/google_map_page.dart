import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';

class GoogleMapPage extends StatelessWidget {
  const GoogleMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: const Text('CANCEL'),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.red,
      ),
      bottomNavigationBar: Container(
        height: 70,
        color: AppPallete.whiteColor,
        padding: const EdgeInsets.all(8),
        child: const RoundedRectangularButton(
          title: 'CONFIRM LOCATION',
        ),
      ),
    );
  }
}

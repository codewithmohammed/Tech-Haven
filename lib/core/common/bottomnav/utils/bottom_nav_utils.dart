import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:tech_haven/core/rive/rive_assets.dart';
import 'package:tech_haven/core/rive/rive_utils.dart';


class BottomNavUtils{
   static  ValueNotifier<RiveAsset> selectedBottomNav =
        ValueNotifier(bottonNavs[0].riveAsset);
  static  void animateTheIcon(int index) {
      final riveIcon = bottonNavs[index].riveAsset;
      riveIcon.input?.change(true);
      Future.delayed(const Duration(seconds: 1), () {
        riveIcon.input?.change(false);
      });
      // setState(() {
      selectedBottomNav.value = riveIcon;
      // });
    }
     static   void riveOnInIt(int index, Artboard artboard) {
      final riveIcon = bottonNavs[index].riveAsset;
      StateMachineController? controller = RiveUtils.getRiveController(artboard,
          stateMachineName: riveIcon.stateMachineName);
      riveIcon.setInput = controller.findInput<bool>('active') as SMIBool;
      riveIcon.input?.change(false);
    }
}
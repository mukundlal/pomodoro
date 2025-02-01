import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
        () => controller.isLandscape.value
            ? buildLandscapeLayout(context)
            : buildPortraitLayout(context),
      ),
    );
  }

  List<Widget> getActionItems() => [
        Obx(
          () => IconButton(
            icon: Icon(
              controller.isRunning.value ? Icons.pause : Icons.play_arrow,
              size: 40,
              color: Colors.grey,
            ),
            onPressed: () {
              if (controller.isRunning.value) {
                controller.pauseTimer();
              } else {
                controller.startTimer();
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.refresh,
            size: 40,
            color: Colors.grey,
          ),
          onPressed: controller.resetTimer,
        ),
        IconButton(
          onPressed: controller.toggleOrientation,
          icon: Icon(
            controller.isLandscape.value
                ? Icons.screen_rotation
                : Icons.screen_rotation_alt,
            color: Colors.white70,
          ),
        )
      ];

  Widget buildLandscapeLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Timer Display
        Expanded(child: buildDigitalClock()),
        // Buttons

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...getActionItems()],
        ),
        SizedBox(width: 20),
      ],
    );
  }

  Widget buildPortraitLayout(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(child: buildDigitalClock()),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...getActionItems()],
      ),
      SizedBox(height: 20),
    ]);
  }

  Widget buildDigitalClock() {
    return Container(
      width: Get.width,
      margin: EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white24, width: 1),
        borderRadius: BorderRadius.circular(32),
        color: Colors.black,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Text(
              controller.formatTime(controller.secondsRemaining.value),
              style: TextStyle(
                fontSize: 120,
                fontWeight: FontWeight.bold,
                fontFamily: 'digital', // Calculator-style font
                color: Colors.greenAccent,
                shadows: [
                  Shadow(
                    blurRadius: 8.0,
                    color: Colors.green.withAlpha(80),
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => SizedBox(
              width: 300,
              height: 100,
              child: Marquee(
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.yellow,
                  fontFamily: 'digital',
                ),
                text: "${controller.currentQuote.value}                      ",
              ),
            ),
          )
        ],
      ),
    );
  }
}

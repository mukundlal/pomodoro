import 'dart:async';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final secondsRemaining = 1500.obs; // Default to 25 minutes
  final isRunning = false.obs;
  final isLandscape = true.obs;
  final RxString currentQuote = ''.obs;
  void toggleOrientation() {
    if (isLandscape.value) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    isLandscape.toggle();
  }
@override
  void onInit() {

    super.onInit();
    updateQuote();
  }
// List of motivational quotes
  final List<String> quotes = [
    "Believe in yourself!",
    "You are capable of amazing things.",
    "Don't stop when you're tired. Stop when you're done.",
    "Keep going, you're getting there.",
    "Dream it. Wish it. Do it.",
    "The only limit is your mind.",
    "Make today amazing.",
    "You are your only limit."
  ];

  // Function to get a random quote
  String getRandomQuote() {
    final random = Random();
    return quotes[random.nextInt(quotes.length)];
  }

  // Update the quote every minute
  void updateQuote() {
    currentQuote.value = getRandomQuote(); // Set a random quote
  }

  void startTimer() {
    isRunning.value = true;
    updateTimer();
  }

  void pauseTimer() {
    isRunning.value = false;
  }

  void resetTimer() {
    isRunning.value = false;
    secondsRemaining.value = 1500; // Reset to 25 minutes
  }

  void updateTimer() {
    if (isRunning.value) {
      Future.delayed(Duration(seconds: 1), () {
        if (secondsRemaining.value > 0 && isRunning.value) {
          secondsRemaining.value--;
          // Every time the minute changes, update the motivational quote
          if (secondsRemaining.value % 60 == 0) {
            updateQuote();
          }
          updateTimer();
        } else {
          isRunning.value = false;
        }
      });
    }
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}

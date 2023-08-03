import 'package:flutter/material.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;
  Color backgroundColor;
  UnbordingContent({
    required this.image,
    required this.title,
    required this.discription,
    required this.backgroundColor,
  });
}

// Created By Flutter Baba
List<UnbordingContent> contentsList = [
  UnbordingContent(
    backgroundColor: Colors.white,
    title: "No more waiting in line",
    image: 'assets/lottie/wait_line.json',
    discription:
        "WYCA lets you choose from a range of services and pick a convenient time.\nOur skilled team will come to you",
  ),
  UnbordingContent(
    backgroundColor: Colors.white,
    title: 'Your Car Your style',
    image: 'assets/lottie/car_style.json',
    discription:
        "We understand that your vehicle is not just a means of transportation\nbut a reflection of your personality and style",
  ),
  UnbordingContent(
    backgroundColor: Colors.white,
    title: 'Customer satisfaction',
    image: 'assets/lottie/best.json',
    discription:
        "You can rest assured that your vehicle will be in the hands of experts ",
  ),
  UnbordingContent(
    backgroundColor: Colors.white,
    title: 'Welcome to the future of car care',
    image: 'assets/lottie/logo.json',
    discription:
        "WYCA the easiest way to keep your car looking fresh and clean! \n With just a few taps on your phone, you can book a professional car wash wherever you are.",
  ),
];

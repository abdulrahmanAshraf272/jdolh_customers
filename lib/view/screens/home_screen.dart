import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/localization/words/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(WordsHome.wordKey1.tr),
      ),
    );
  }
}

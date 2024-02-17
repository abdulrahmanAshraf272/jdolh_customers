import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAds extends StatelessWidget {
  const CustomAds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.width * 0.55,
      child: CarouselSlider.builder(
        itemCount: 3,
        options: CarouselOptions(
          autoPlay: false,
          aspectRatio: 2.1,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
        ),
        itemBuilder: (context, index, realIndex) => Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 3),
                      blurRadius: 4,
                      color: Colors.black45.withOpacity(0.23))
                ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/images/breakfastDishe24.jpg',
                fit: BoxFit.cover,
              ),
            )),
      ),
    );
  }
}

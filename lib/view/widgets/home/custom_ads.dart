import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/controller/home_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/data/models/ad.dart';
import 'package:shimmer/shimmer.dart';

class CustomAds extends StatelessWidget {
  const CustomAds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        builder: (controller) => HandlingDataRequest(
            statusRequest: controller.statusAds,
            widget: controller.ads.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: Get.width * 0.55,
                    child: CarouselSlider.builder(
                      itemCount: controller.ads.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.1,
                        enlargeCenterPage: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                      ),
                      itemBuilder: (context, index, realIndex) => AdListItem(
                        ad: controller.ads[index],
                        onTap: () => controller.onTapAd(index),
                      ),
                    ),
                  )));
  }
}

class AdListItem extends StatelessWidget {
  final Ad ad;
  final void Function() onTap;
  const AdListItem({Key? key, required this.ad, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 4,
              color: Colors.black45.withOpacity(0.23),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: ad.image != null
              ? Image.network(
                  '${ApiLinks.adsImages}/${ad.image}',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, widget, event) {
                    if (event == null) {
                      return widget; // Image is fully loaded
                    } else {
                      // Display shimmer while image is loading
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        period: const Duration(milliseconds: 800),
                        child: Container(
                          color: Colors.grey,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    }
                  },
                )
              : Image.asset(
                  'assets/images/noImageAvailable.jpg',
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }
}

// class AdListItem extends StatelessWidget {
//   final Ad ad;
//   final void Function() onTap;
//   const AdListItem({super.key, required this.ad, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               boxShadow: [
//                 BoxShadow(
//                     offset: const Offset(0, 3),
//                     blurRadius: 4,
//                     color: Colors.black45.withOpacity(0.23))
//               ]),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(15),
//             child: ad.image != null
//                 ? FadeInImage.assetNetwork(
//                     placeholder: 'assets/images/loading2.gif',
//                     image: '${ApiLinks.adsImages}/${ad.image}',
//                     fit: BoxFit.cover,
//                   )
//                 : Image.asset(
//                     'assets/images/noImageAvailable.jpg',
//                     fit: BoxFit.cover,
//                   ),
//           )),
//     );
//   }
// }

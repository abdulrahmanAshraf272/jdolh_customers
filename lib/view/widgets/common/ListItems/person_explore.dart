import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class PersonExploreListItem extends StatelessWidget {
  final String name;
  final String? image;
  final void Function() onTap;
  const PersonExploreListItem(
      {super.key,
      required this.name,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 115.h,
        width: 60.h,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image != '' && image != null
                  ? FadeInImage.assetNetwork(
                      height: 60.w,
                      width: 60.w,
                      placeholder: 'assets/images/loading2.gif',
                      image: '${ApiLinks.customerImage}/$image',
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/person4.jpg',
                      fit: BoxFit.cover,
                      height: 60.w,
                      width: 60.w,
                    ),
            ),
            const SizedBox(height: 5),
            AutoSizeText(
              name,
              maxLines: 2,
              style: titleSmall,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}

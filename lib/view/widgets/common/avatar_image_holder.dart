import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';

class AvatarImageHolder extends StatelessWidget {
  final Function() onTap;
  final Uint8List? selectedImage;
  final String imageFromNetwork;
  final bool activePickImage;

  const AvatarImageHolder(
      {Key? key,
      required this.onTap,
      required this.selectedImage,
      this.imageFromNetwork = '',
      this.activePickImage = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: Get.width / 6, // Adjust as needed
              backgroundImage: selectedImage != null
                  ? MemoryImage(selectedImage!)
                  : imageFromNetwork != ''
                      ? NetworkImage(imageFromNetwork)
                      : const AssetImage('assets/images/person4.jpg')
                          as ImageProvider,
            ),
            if (activePickImage)
              Positioned(
                bottom: 0,
                right: -5,
                child: GestureDetector(
                  onTap: onTap,
                  child: const CircleAvatar(
                    radius: 20, // Adjust the size of the icon button as needed
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'حجم الصورة لا بتجاوز: 5M',
          style: titleSmallGray,
        ),
      ],
    );
  }
}

class AvatarImageDisplay extends StatelessWidget {
  final String imageFromNetwork;

  const AvatarImageDisplay({
    Key? key,
    required this.imageFromNetwork,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: Get.width / 6, // Adjust as needed
          backgroundImage: imageFromNetwork != ''
              ? NetworkImage(imageFromNetwork)
              : const AssetImage('assets/images/person4.jpg') as ImageProvider,
        ),
      ],
    );
  }
}

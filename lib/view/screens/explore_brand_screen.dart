import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:jdolh_customers/api_links.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/core/constants/app_routes_name.dart';
import 'package:jdolh_customers/core/constants/text_syles.dart';
import 'package:jdolh_customers/data/models/bch.dart';
import 'package:jdolh_customers/data/models/brand.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/brand_detailed.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class ExploreBrandScreen extends StatefulWidget {
  const ExploreBrandScreen({super.key});

  @override
  State<ExploreBrandScreen> createState() => _ExploreBrandScreenState();
}

class _ExploreBrandScreenState extends State<ExploreBrandScreen> {
  List<Brand> brands = [];
  List<Bch> bchs = [];
  gotoBrand(int index) {
    Get.toNamed(AppRouteName.brandProfile,
        arguments: {"brand": brands[index], "bch": bchs[index]});
  }

  @override
  void initState() {
    if (Get.arguments != null) {
      brands = List.from(Get.arguments["brands"]);
      bchs = List.from(Get.arguments["bchs"]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        title: 'الأكثر زيارة خلال اسبوع'.tr,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: brands.length,
                itemBuilder: (context, index) => BrandDetailedListItem(
                      brandName: brands[index].brandStoreName ?? '',
                      type: brands[index].brandType ?? '',
                      subtype: brands[index].brandSubtype ?? '',
                      isVerified: brands[index].brandIsVerified ?? 0,
                      address: bchs[index].bchCity ?? '',
                      rate: 5.0,
                      image: '${ApiLinks.logoImage}/${brands[index].brandLogo}',
                      onTap: () => gotoBrand(index),
                      resCount: bchs[index].resCount,
                    )),
          ),
        ],
      ),
    );
  }
}

class ExploreBrandListItem extends StatelessWidget {
  final String name;
  final String? image;
  const ExploreBrandListItem(
      {super.key, required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: Get.width / 2 - 30,
      // height: Get.width / 2 - 30,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
        BoxShadow(
            offset: const Offset(0, 3),
            blurRadius: 4,
            color: Colors.black45.withOpacity(0.23))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            image != null
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading2.gif',
                    image: image!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/noImageAvailable.jpg',
                    fit: BoxFit.cover,
                  ),
            Expanded(
              child: Container(
                height: 40,
                color: AppColors.gray,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        ' بيتزابيتزابيتزاهتبيتزاهت',
                        maxLines: 2,
                        style: titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 3),
                    Row(
                      children: [
                        Text(
                          '300',
                          style: titleSmall,
                        ),
                        const Icon(Icons.person)
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/ListItems/food.dart';

class ProductsSubScreen extends StatefulWidget {
  const ProductsSubScreen({
    super.key,
  });

  @override
  State<ProductsSubScreen> createState() => _ProductsSubScreenState();
}

class _ProductsSubScreenState extends State<ProductsSubScreen> {
  int selectedIndex = 0;
  List<String> list = ['مشويات', 'مقبلات', 'معجنات', 'سندوتشات'];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 45,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(right: 16),
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: CategoriesListItem(
                    index: index,
                    selectedIndex: selectedIndex,
                    text: list[index],
                  ))),
        ),
        ListView.builder(
          itemCount: 6,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => FoodListItem(),
        )
      ],
    );
  }
}

class CategoriesListItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final String text;
  const CategoriesListItem(
      {super.key,
      required this.index,
      required this.text,
      required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: selectedIndex == index
                  ? AppColors.secondaryColor
                  : Colors.grey,
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 2,
            width: 20,
            color: selectedIndex == index ? AppColors.secondaryColor : null,
          ),
        ],
      ),
    );
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

/// Copy the content of FlixableToggleButton
class FlixableToggleButton extends StatefulWidget {
  const FlixableToggleButton({
    super.key,
  });

  @override
  State<FlixableToggleButton> createState() => _FlixableToggleButtonState();
}

class _FlixableToggleButtonState extends State<FlixableToggleButton> {
  int selectedIndex = 0;
  List<String> list = ['كبير', 'متوسط', 'صغير'];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: ToggleButtonItem(
                index: index,
                selectedIndex: selectedIndex,
                text: list[index])));
  }
}

////////////////////////////////////////////////////
///                                              //
// == ToggleButtonItem Fixed Don't Modify it == //
//                                             //
////////////////////////////////////////////////
class ToggleButtonItem extends StatelessWidget {
  final int index;
  int selectedIndex;
  final String text;
  final double circleSize;
  final double fontSize;
  final String? svgIconPath;
  ToggleButtonItem(
      {super.key,
      required this.index,
      required this.selectedIndex,
      required this.text,
      this.circleSize = 16,
      this.fontSize = 11,
      this.svgIconPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: circleSize,
          width: circleSize,
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black.withOpacity(0.5)),
              shape: BoxShape.circle,
              color: const Color(0xffF3F3F3)),
          child: Center(
            child: Container(
              height: circleSize,
              width: circleSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      selectedIndex == index ? AppColors.secondaryColor : null),
            ),
          ),
        ),
        svgIconPath != null
            ? SvgPicture.asset(
                'assets/icons/bill.svg',
                width: 20,
                height: 20,
              )
            : SizedBox(),
        Expanded(
          child: AutoSizeText(text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: fontSize.sp,
                color: AppColors.grayText,
              )),
        ),
      ],
    );
  }
}

// class ToggleButtonItem extends StatelessWidget {
//   final void Function() onTap;
//   final String text;
//   final bool on;
//   final double circleSize;
//   final double fontSize;

//   const ToggleButtonItem(
//       {super.key,
//       required this.onTap,
//       required this.text,
//       required this.on,
//       this.circleSize = 16,
//       this.fontSize = 11});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {},
//       child: Row(
//         children: [
//           Container(
//             height: circleSize,
//             width: circleSize,
//             padding: const EdgeInsets.all(2),
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black.withOpacity(0.5)),
//                 shape: BoxShape.circle,
//                 color: const Color(0xffF3F3F3)),
//             child: Center(
//               child: Container(
//                 height: circleSize,
//                 width: circleSize,
//                 decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: on ? AppColors.secondaryColor : null),
//               ),
//             ),
//           ),
//           Text(text,
//               style: TextStyle(
//                 fontWeight: FontWeight.w600,
//                 fontSize: fontSize.sp,
//                 color: AppColors.grayText,
//               )),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class CustomToggleGeneral extends StatefulWidget {
  final String title;
  final Function() onTap;
  final bool initialValue;
  final bool isClickable;
  const CustomToggleGeneral(
      {super.key,
      required this.onTap,
      required this.title,
      this.initialValue = true,
      this.isClickable = true});

  @override
  State<CustomToggleGeneral> createState() => _CustomToggleGeneralState();
}

class _CustomToggleGeneralState extends State<CustomToggleGeneral> {
  late bool isDone;
  @override
  void initState() {
    // TODO: implement initState
    isDone = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: AppColors.gray,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isClickable
                ? () {
                    setState(() {
                      isDone = !isDone;
                      widget.onTap();
                    });
                  }
                : null,
            child: Container(
              //width: 80.w,
              padding: const EdgeInsets.only(left: 10),
              height: 35.h,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    margin: const EdgeInsets.all(8.5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDone ? Colors.green : null,
                        border: isDone
                            ? null
                            : Border.all(
                                width: 0.7, color: Colors.grey.shade400)),
                    child: Icon(
                      Icons.done,
                      color: isDone ? Colors.white : Colors.transparent,
                      size: 12,
                    ),
                  ),
                  Text(
                    widget.title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  SizedBox(width: 5)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

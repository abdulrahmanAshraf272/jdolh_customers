import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';

class ServiceDuration extends StatelessWidget {
  final int duration;
  const ServiceDuration({
    super.key,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'مدة الخدمة',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.sp,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 48,
            //width: 60,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
            child: Text('$duration دقيقة'),
          )
        ],
      ),
    );
  }
}

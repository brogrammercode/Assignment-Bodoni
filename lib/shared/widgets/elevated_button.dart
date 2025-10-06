import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedplan/core/theme/color.dart';
import 'package:wedplan/core/utils/definites.dart';

class AppElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final bool? loading;

  const AppElevatedButton({
    super.key,
    this.onPressed,
    required this.label,
    this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
        width: double.infinity,
        height: 55.h,
        decoration: BoxDecoration(
          color: AppColor.primaryLight,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColor.primary.withOpacity(.2),
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppDefinites.style.copyWith(color: Colors.black),
            ),
            if (loading != null && loading == true) ...[
              SizedBox(width: 30.w),
              SizedBox(
                height: 15.h,
                width: 15.h,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

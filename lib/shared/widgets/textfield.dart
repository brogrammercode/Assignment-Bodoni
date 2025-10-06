import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/definites.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool? obscureText;
  final String? Function(String?)? validator;

  const AppTextField({
    super.key,
    this.hintText,
    this.controller,
    this.obscureText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            validator: validator,
            obscureText: obscureText ?? false,
            style: TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.withOpacity(.2),
              border: AppDefinites.border,
              enabledBorder: AppDefinites.border,
              focusedBorder: AppDefinites.border,
              hintText: hintText,
              hintStyle: AppDefinites.style.copyWith(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

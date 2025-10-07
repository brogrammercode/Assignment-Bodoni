import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../core/utils/definites.dart';
import '../../features/weeding/data/model.dart';

class WeddingTile extends StatelessWidget {
  final Wedding wedding;

  const WeddingTile({super.key, required this.wedding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              width: 150.w,
              height: 100.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Image.network(wedding.venue.images[2], fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  wedding.name,
                  style: AppDefinites.style.copyWith(fontSize: 17.sp),
                ),
                Text(
                  "${wedding.location.city}, ${wedding.location.state}",
                  style: AppDefinites.style.copyWith(color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 30.h),
                Text(
                  DateFormat("dd MMM, yyyy").format(wedding.td),
                  style: AppDefinites.style.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

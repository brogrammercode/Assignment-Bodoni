import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/definites.dart';
import '../../data/model.dart';

class VenueDetailPage extends StatefulWidget {
  final Venue venue;

  const VenueDetailPage({super.key, required this.venue});

  @override
  State<VenueDetailPage> createState() => _VenueDetailPageState();
}

class _VenueDetailPageState extends State<VenueDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(widget.venue),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VenueSlider(images: widget.venue.images),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.venue.name,
                    style: AppDefinites.style.copyWith(fontSize: 20.sp),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.venue.location.city}, ${widget.venue.location.state}",
                        style: AppDefinites.style.copyWith(color: Colors.grey),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.person_2_fill,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            widget.venue.capacity.toString(),
                            style: AppDefinites.style,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "₹ ${widget.venue.price}",
                    style: AppDefinites.style.copyWith(
                      fontSize: 20.sp,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.venue.description,
                    style: AppDefinites.style.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(Venue venue) {
    return AppBar(
      title: Text(
        venue.name,
        style: AppDefinites.style.copyWith(fontSize: 17.sp),
      ),
    );
  }
}

class VenueSlider extends StatefulWidget {
  final List<String> images;

  const VenueSlider({super.key, required this.images});

  @override
  State<VenueSlider> createState() => _VenueSliderState();
}

class _VenueSliderState extends State<VenueSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget buildSlides() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            height: 300.h,
            width: double.infinity,

            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      widget.images[index],
                      fit: BoxFit.cover,
                      height: 300.h,
                      width: double.infinity,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: 10.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              height: 8.w,
              width: _currentPage == index ? 20.w : 8.w,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
                borderRadius: BorderRadius.circular(5.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildSlides();
  }
}

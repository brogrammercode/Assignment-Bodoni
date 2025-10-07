import 'package:badges/badges.dart' as badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedplan/core/utils/definites.dart';
import 'package:wedplan/features/weeding/data/model.dart';
import 'package:wedplan/features/weeding/presentation/cubit/wedding_cubit.dart';
import 'package:wedplan/shared/widgets/elevated_button.dart';
import 'package:wedplan/shared/widgets/textfield.dart';
import 'package:wedplan/shared/widgets/venue_tile.dart';

import '../../../../core/theme/color.dart';
import '../../../../core/utils/validations.dart';
import '../../../venue/data/model.dart';
import '../../../venue/presentation/pages/venue_grid_page.dart';

class ChecklistPage extends StatefulWidget {
  const ChecklistPage({super.key});

  @override
  State<ChecklistPage> createState() => _ChecklistPageState();
}

class _ChecklistPageState extends State<ChecklistPage> {
  final _key = GlobalKey<FormState>();
  final _name = TextEditingController();
  bool photography = false;
  bool catering = false;
  bool mehendi = false;
  bool sangeet = false;
  bool honeymoon = false;
  Venue? venue;

  Widget buildChecklistItem({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: CheckboxListTile(
        value: value,
        title: Text(title, style: AppDefinites.style),
        subtitle: Text(
          subtitle,
          style: AppDefinites.style.copyWith(color: Colors.black54),
        ),
        controlAffinity: ListTileControlAffinity.trailing,
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AppElevatedButton(
        label: "Add wedding",
        onPressed: _onAddPressed,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: Text(
          "Wedding Checklist",
          style: AppDefinites.style.copyWith(fontSize: 17.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Text("Wedding name", style: AppDefinites.style),
              ),
              SizedBox(height: 10.h),
              AppTextField(
                controller: _name,
                hintText: "e.g. Rohan & Seema",
                validator: Validation.weddingNameValidator,
              ),
              SizedBox(height: 10.h),
              _buildVenue(),
              SizedBox(height: 10.h),
              buildChecklistItem(
                title: "Photography",
                subtitle: "Capture memories with professional photographers",
                value: photography,
                onChanged: (val) => setState(() => photography = val!),
              ),
              buildChecklistItem(
                title: "Catering",
                subtitle: "Delicious food arrangements for guests",
                value: catering,
                onChanged: (val) => setState(() => catering = val!),
              ),
              buildChecklistItem(
                title: "Mehendi",
                subtitle: "Traditional mehendi ceremony preparations",
                value: mehendi,
                onChanged: (val) => setState(() => mehendi = val!),
              ),
              buildChecklistItem(
                title: "Sangeet",
                subtitle: "Celebrate with music, dance, and joy",
                value: sangeet,
                onChanged: (val) => setState(() => sangeet = val!),
              ),
              buildChecklistItem(
                title: "Honeymoon",
                subtitle: "Plan a romantic getaway after the wedding",
                value: honeymoon,
                onChanged: (val) => setState(() => honeymoon = val!),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildVenue() {
    return venue != null
        ? badge.Badge(
            onTap: () => setState(() => venue = null),
            position: badge.BadgePosition.topStart(start: 15.r),
            badgeContent: Icon(CupertinoIcons.multiply, color: Colors.white),
            child: VenueTile(venue: venue!),
          )
        : GestureDetector(
            onTap: () async {
              final selectedVenue = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const VenueGridPage()),
              );
              if (selectedVenue != null) {
                setState(() {
                  venue = selectedVenue;
                });
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 25.w),
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.primaryLight,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.primary.withOpacity(.2),
                  width: 1.5,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.add),
                  SizedBox(height: 10.h),
                  Text("Add Venue", style: AppDefinites.style),
                ],
              ),
            ),
          );
  }

  void _onAddPressed() {
    if (!_key.currentState!.validate()) return;

    if (venue == null) {
      Fluttertoast.showToast(msg: "Please select a venue");
      return;
    }

    final td = DateTime.now();

    context.read<WeddingCubit>().createWedding(
      Wedding(
        id: td.millisecondsSinceEpoch.toString(),
        name: _name.text.trim(),
        td: td,
        location: venue!.location,
        venue: venue!,
        photography: photography,
        catering: catering,
        mehendi: mehendi,
        sangeet: sangeet,
        honeymoon: honeymoon,
        createdBy: "currentUserId",
        creationTd: td,
      ),
    );

    Navigator.pop(context);
  }
}

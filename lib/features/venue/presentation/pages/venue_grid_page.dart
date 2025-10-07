import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wedplan/shared/widgets/venue_tile.dart';

import '../../../../core/utils/definites.dart';
import '../cubit/venue_cubit.dart';

class VenueGridPage extends StatefulWidget {
  const VenueGridPage({super.key});

  @override
  State<VenueGridPage> createState() => _VenueGridPageState();
}

class _VenueGridPageState extends State<VenueGridPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenueCubit, VenueState>(
      builder: (context, state) {
        final venues = state.venues;
        return Scaffold(
          appBar: buildAppBar(),
          body: Column(
            children: List.generate(venues.length, (index) {
              final venue = venues[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, venue);
                },
                child: VenueTile(venue: venue),
              );
            }),
          ),
        );
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "Select Venues",
        style: AppDefinites.style.copyWith(fontSize: 17.sp),
      ),
    );
  }
}

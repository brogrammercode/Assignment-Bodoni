import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wedplan/core/utils/definites.dart';
import 'package:wedplan/features/venue/presentation/cubit/venue_cubit.dart';
import 'package:wedplan/features/weeding/presentation/pages/checklist_page.dart';
import 'package:wedplan/shared/widgets/venue_tile.dart';
import 'package:wedplan/shared/widgets/wedding_tile.dart';

import '../../../../shared/entities/location.dart';
import '../../../venue/data/model.dart';
import '../cubit/wedding_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<WeddingCubit>().fetchWeddings();
    context.read<VenueCubit>().fetchVenues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VenueCubit, VenueState>(
      builder: (context, state) {
        final weddings = context.watch<WeddingCubit>().state.weddings;
        final venues = state.venues;
        log(venues.toString());
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: _onFloatingActionButton,
            shape: CircleBorder(),
            child: Icon(CupertinoIcons.add, color: Colors.white),
          ),
          appBar: buildAppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                buildHero(),
                buildIconGrid(),
                if (weddings.isNotEmpty) ...[
                  buildHeading("Planned Weddings"),
                  Column(
                    children: List.generate(weddings.length, (index) {
                      final wedding = weddings[index];
                      return WeddingTile(wedding: wedding);
                    }),
                  ),
                ],
                if (venues.isNotEmpty) ...[
                  buildHeading("Nearby Venues"),
                  Column(
                    children: List.generate(venues.length, (index) {
                      final venue = venues[index];
                      return VenueTile(venue: venue);
                    }),
                  ),
                ] else ...[
                  TextButton(
                    onPressed: _populateVenue,
                    child: Text("Populate Venues", style: AppDefinites.style),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Center buildHero() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Text(
          "Create Your Own Version Of Perfect Weeding",
          style: AppDefinites.style.copyWith(fontSize: 22.sp),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Container buildHeading(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppDefinites.style.copyWith(fontSize: 15.sp)),
          Text(
            "View All",
            style: AppDefinites.style.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Padding buildIconGrid() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: icons.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),

        itemBuilder: (context, index) {
          final icon = icons[index];
          return Column(
            children: [
              IconButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: "Yet to Implement !!");
                },
                icon: Icon(icon["icon"], color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: 10.h),
              Text(icon['label'], style: AppDefinites.style),
            ],
          );
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: _onAppBarLeadingPressed,
        icon: Icon(CupertinoIcons.bars),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.location, size: 16.sp),
          SizedBox(width: 10.w),
          Text(
            "Barari, Bihar",
            style: AppDefinites.style.copyWith(fontSize: 15.sp),
          ),
          SizedBox(width: 10.w),
          Icon(CupertinoIcons.chevron_down, size: 16.sp),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: _onAppBarActionPressed,
          icon: Icon(CupertinoIcons.bell_fill),
        ),
      ],
    );
  }

  void _onAppBarActionPressed() async {
    // final td = DateTime.now();
    // final success = await context.read<VenueCubit>().createVenue(
    //   Venue(
    //     id: (DateTime.now().millisecondsSinceEpoch + 4).toString(),
    //     images: [
    //       "https://images.unsplash.com/photo-1530023367847-fc3d357c01c7?w=500&auto=format&fit=crop&q=60",
    //       "https://images.unsplash.com/photo-1640290699030-b477f95f13b2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDh8fGluZGlhbiUyMHdlZGRpbmd8ZW58MHx8MHx8fDA%3D",
    //       "https://plus.unsplash.com/premium_photo-1724762183198-5d04b568772f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDl8fGluZGlhbiUyMHdlZGRpbmd8ZW58MHx8MHx8fDA%3D",
    //     ],
    //     name: "Golden Heritage Hall",
    //     description:
    //         "Golden Heritage Hall blends classic decor and modern amenities, ensuring memorable celebrations.",
    //     location: Location(),
    //     price: 450000,
    //     capacity: 400,
    //   ),
    // );
    //
    // if (success) {
    //   log("VENUE ADDED !!!");
    // }
  }

  void _onAppBarLeadingPressed() {}

  List icons = [
    {"icon": CupertinoIcons.person, "label": "Vendor"},
    {"icon": CupertinoIcons.house_alt, "label": "Venue"},
    {"icon": CupertinoIcons.shopping_cart, "label": "Dress"},
    {"icon": CupertinoIcons.color_filter, "label": "Makeup"},
    {"icon": CupertinoIcons.music_note, "label": "Sangeet"},
    {"icon": CupertinoIcons.camera, "label": "Photo"},
    {"icon": CupertinoIcons.cart, "label": "Catering"},
    {"icon": Icons.fastfood_outlined, "label": "Food"},
  ];

  void _onFloatingActionButton() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ChecklistPage()));
  }

  void _populateVenue() async {
    final venues = [
      Venue(
        id: "1759869676892",
        images: [
          "https://images.unsplash.com/photo-1587271636175-90d58cdad458?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1587271407850-8d438ca9fdf2?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1601120979673-b3f6f4c7d2ba?w=500&auto=format&fit=crop&q=60",
        ],
        name: "Lalit's Palace",
        description:
            "Step into Lalit’s Palace, a majestic wedding venue that turns every celebration into a timeless memory. Nestled amidst lush gardens and adorned with regal architecture, our palace offers the perfect blend of grandeur and intimacy. From elaborate indoor halls with sparkling chandeliers to serene outdoor spaces bathed in natural light, every corner is crafted to make your special day unforgettable.",
        location: Location(
          area: "Barari",
          city: "Bhagalpur",
          state: "Bihar",
          country: "India",
          pincode: 812003,
        ),
        price: 500000,
        capacity: 500,
      ),
      Venue(
        id: "1759869979624",
        images: [
          "https://images.unsplash.com/photo-1517841905240-472988babdf9?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1518098268026-4e89f1a2cd8c?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1464983953574-0892a716854b?w=500&auto=format&fit=crop&q=60",
        ],
        name: "Rajwada Banquet",
        description:
            "Rajwada Banquet brings Mughal grandeur with luxurious halls and lush lawns for a royal event.",
        location: Location(
          area: "Barari",
          city: "Bhagalpur",
          state: "Bihar",
          country: "India",
          pincode: 812003,
        ),
        price: 350000,
        capacity: 350,
      ),
      Venue(
        id: "1759870052166",
        images: [
          "https://images.unsplash.com/photo-1583878545126-2f1ca0142714?w=500&auto=format&fit=crop&q=60",
          "https://plus.unsplash.com/premium_photo-1724762182780-000d248f9301?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1601121141503-c4796ffc4b52?w=500&auto=format&fit=crop&q=60",
        ],
        name: "Serene Garden",
        description:
            "Serene Garden is known for its beautiful outdoor ambiance and floral arrangements, ideal for day events.",
        location: Location(
          area: "Barari",
          city: "Bhagalpur",
          state: "Bihar",
          country: "India",
          pincode: 812003,
        ),
        price: 280000,
        capacity: 270,
      ),
      Venue(
        id: "1759870114937",
        images: [
          "https://plus.unsplash.com/premium_photo-1682092635235-d775b3103eb8?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1665960211264-5e0a7112bacd?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1610173827002-62c0f1f05d04?w=500&auto=format&fit=crop&q=60",
        ],
        name: "Ambience Greens",
        description:
            "Ambience Greens delivers luxury and nature; perfect for grand receptions and sangeet nights.",
        location: Location(
          area: "Barari",
          city: "Bhagalpur",
          state: "Bihar",
          country: "India",
          pincode: 812003,
        ),
        price: 600000,
        capacity: 600,
      ),
      Venue(
        id: "1759870167287",
        images: [
          "https://images.unsplash.com/photo-1530023367847-fc3d357c01c7?w=500&auto=format&fit=crop&q=60",
          "https://images.unsplash.com/photo-1640290699030-b477f95f13b2?w=500&auto=format&fit=crop&q=60",
          "https://plus.unsplash.com/premium_photo-1724762183198-5d04b568772f?w=500&auto=format&fit=crop&q=60",
        ],
        name: "Golden Heritage Hall",
        description:
            "Golden Heritage Hall blends classic decor and modern amenities, ensuring memorable celebrations.",
        location: Location(
          area: "Barari",
          city: "Bhagalpur",
          state: "Bihar",
          country: "India",
          pincode: 812003,
        ),
        price: 450000,
        capacity: 400,
      ),
    ];

    for (var v in venues) {
      await context.read<VenueCubit>().createVenue(v);
    }

    Fluttertoast.showToast(msg: "Venues populated successfully!");
  }
}

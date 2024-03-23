import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_map/flutter_map.dart";
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import "package:get/get.dart";
import "package:partymap/Screens/home/widgets/location_search_controller.dart";
import "package:partymap/Screens/home/widgets/location_search_widget.dart";
import "package:partymap/Screens/home/widgets/map_type.dart";
import "package:partymap/Screens/home/widgets/venue_detail_bottomsheet.dart";
import "package:partymap/Screens/home/widgets/venue_details.dart";
import "package:partymap/res/assets/image_assets.dart";
import "package:partymap/res/colors/app_color.dart";
import "package:partymap/res/components/custom_text.dart";
import "package:partymap/utils/responsive_size_util.dart";
import "home_controller.dart";

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGFydHltYXAiLCJhIjoiY2x0Nm5wNWVoMDRmNDJxcHBqYTFuczdpNCJ9.k6rBlzpj-frFkNv8dOOtlA';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        // MapboxMap? mapboxMap;
        // PointAnnotationManager? pointAnnotationManager;

        // void _onMapCreated(MapboxMap mapboxmap) async {
        //   mapboxMap = mapboxmap;

        //   final ByteData bytes = await rootBundle.load(ImageAssets.markerIcon);
        //   final Uint8List list = bytes.buffer.asUint8List();
        //   List<PointAnnotationOptions> options = [];

        //   var points = [
        //     Point(
        //       coordinates: Position(-115.17217125911195, 36.11509362417488),
        //     ).toJson(),
        //     Point(
        //       coordinates: Position(-115.17255939774128, 36.11244019665051),
        //     ).toJson(),
        //     Point(
        //       coordinates: Position(-115.17323234620663, 36.11572852007753),
        //     ).toJson(),
        //   ];

        //   for (var point in points) {
        //     options.add(PointAnnotationOptions(
        //       geometry: point,
        //       image: list,
        //     ));
        //   }

        //   mapboxmap.annotations.createPointAnnotationManager().then((manager) {
        //     manager.createMulti(options);
        //   });
        // }

        return Scaffold(
          backgroundColor: AppColor.secondaryColor,
          // appBar: AppBar(
          //   // backgroundColor: AppColor.secondaryColor,
          //   backgroundColor: Colors.transparent,
          //   foregroundColor: AppColor.whiteColor,
          //   title: CustomText(
          //     text: "",
          //     color: AppColor.whiteColor,
          //     fontSize: ResponsiveSizeUtil.size16,
          //     fontWeight: FontWeight.w600,
          //   ),
          //   actions: [
          //     IconButton(
          //       onPressed: () => Get.toNamed("/profile_screen"),
          //       icon: const Icon(Icons.person_outline_rounded),
          //       iconSize: 24,
          //     ),
          //   ],
          // ),
          body: Container(
            decoration: BoxDecoration(
              color: AppColor.secondaryColor,
              border: const Border(
                bottom: BorderSide(
                  color: AppColor.whiteColor,
                ),
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(ResponsiveSizeUtil.size40),
                bottomRight: Radius.circular(ResponsiveSizeUtil.size40),
              ),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ResponsiveSizeUtil.size40),
                    bottomRight: Radius.circular(ResponsiveSizeUtil.size40),
                  ),
                  child: Obx(
                    () => MapWidget(
                      key: const ValueKey("partyMap"),
                      onMapCreated: controller.onMapCreated,
                      cameraOptions: CameraOptions(
                        center: Point(
                          coordinates: Position(controller.longitude.value,
                              controller.latitude.value),
                        ).toJson(),
                        zoom: controller.zoom.value,
                        pitch: 75.0,
                      ),
                      styleUri: controller.mapType.value == 'Dark'
                          ? 'mapbox://styles/partymap/clu160x05008h01qw2eal5cny'
                          : 'mapbox://styles/partymap/cltbpygi900hm01qn6m06fzul',
                    ),
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: IconButton(
                //     onPressed: () => Get.toNamed("/profile_screen"),
                //     icon: const Icon(Icons.person_rounded),
                //     color: AppColor.blackColor,
                //     iconSize: ResponsiveSizeUtil.size40,
                //   ),
                // ),
                // Positioned(
                //   top: 30,
                //   left: 10,
                //   child: MapTypeDropdown(),
                // ),

                // Positioned(
                //   bottom: 0,
                //   left: 5,
                //   child: Container(
                //     height: 30,
                //     width: 120,
                //     decoration: BoxDecoration(
                //       borderRadius: const BorderRadius.only(
                //           bottomLeft: Radius.circular(60)),
                //       color: Colors.black.withOpacity(1),
                //     ),
                //   ),
                // ),

                Positioned(
                  bottom: ResponsiveSizeUtil.size20,
                  left: ResponsiveSizeUtil.size20,
                  child: SizedBox(
                    width: ResponsiveSizeUtil.size40,
                    child: Container(
                      width: ResponsiveSizeUtil.size40,
                      height: ResponsiveSizeUtil.size40,
                      decoration: BoxDecoration(
                        color: AppColor.lightColor,
                        borderRadius:
                            BorderRadius.circular(ResponsiveSizeUtil.size6),
                      ),
                      child: Image.asset(
                        ImageAssets.partyMapLogoPink,
                        width: ResponsiveSizeUtil.size15,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: ResponsiveSizeUtil.size20,
                  left: ResponsiveSizeUtil.size72,
                  right: ResponsiveSizeUtil.size20,
                  child: Container(
                    height: 200, // Set this height appropriately
                    child: LocationSearchWidget(), // Your search widget
                  ),
                ),

                Obx(
                  () => controller.clicked.value
                      ? Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: VenueDetailBottomSheet(
                              venueDetails: VenueDetails(
                                  name: 'Venue Name',
                                  description: 'Venue Description')),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// child: ElevatedButton(
//   onPressed: () {
//     UserPreference up = UserPreference();
//     up.removeUser();
//     Get.offAllNamed(RouteName.loginScreen);
//   },
//   style: ElevatedButton.styleFrom(
//     backgroundColor: Colors.red,
//   ),
//   child: const Text(
//     'Logout',
//     style: TextStyle(color: Colors.white),
//   ),
// ),

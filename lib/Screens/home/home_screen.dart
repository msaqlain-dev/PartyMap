import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_map/flutter_map.dart";
import "package:get/get.dart";
import "package:latlong2/latlong.dart";
import "package:partymap/res/assets/image_assets.dart";
import "package:partymap/res/colors/app_color.dart";
import "package:partymap/res/components/custom_text.dart";
import "package:partymap/res/components/round_button.dart";
import "package:partymap/utils/responsive_size_util.dart";
import "home_controller.dart";

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoicGFydHltYXAiLCJhIjoiY2x0Nm5wNWVoMDRmNDJxcHBqYTFuczdpNCJ9.k6rBlzpj-frFkNv8dOOtlA';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());
  final LatLng lasVegasCoordinates = const LatLng(36.1699, -115.1398);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      appBar: AppBar(
        // backgroundColor: AppColor.secondaryColor,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColor.whiteColor,
        title: CustomText(
          text: "",
          color: AppColor.whiteColor,
          fontSize: ResponsiveSizeUtil.size16,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed("/profile_screen"),
            icon: const Icon(Icons.person_outline_rounded),
            iconSize: 24,
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColor.secondaryColor,
          border: const Border(
            bottom: BorderSide(
              color: AppColor.whiteColor,
              // width: 2.0,
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
              child: FlutterMap(
                options: MapOptions(
                  center: lasVegasCoordinates,
                  minZoom: 5,
                  maxZoom: 22,
                  zoom: 14,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                    additionalOptions: const {
                      'accessToken': MAPBOX_ACCESS_TOKEN,
                      // 'id': 'partymap/cltbpygi900hm01qn6m06fzul'
                      // 'id': 'mapbox/satellite-streets-v12'
                      'id': 'mapbox/dark-v11',
                    },
                    retinaMode: true,
                  ),
                  const MarkerLayer(
                    markers: [
                      // Marker(
                      //   point: myPosition!,
                      //   builder: (context) {
                      //     return Container(
                      //       child: const Icon(
                      //         Icons.person_pin,
                      //         color: Colors.blueAccent,
                      //         size: 40,
                      //       ),
                      //     );
                      //   },
                      // )
                    ],
                  ),
                ],
              ),
            ),
            // Positioned(
            //   bottom: ResponsiveSizeUtil.size20,
            //   left: ResponsiveSizeUtil.size20,
            //   child: Row(
            //     children: [
            //       Container(
            //         width: ResponsiveSizeUtil.size40,
            //         height: ResponsiveSizeUtil.size40,
            //         decoration: BoxDecoration(
            //           color: AppColor.lightColor,
            //           borderRadius:
            //               BorderRadius.circular(ResponsiveSizeUtil.size6),
            //         ),
            //         child: Image.asset(
            //           ImageAssets.partyMapLogoPink,
            //           width: ResponsiveSizeUtil.size15,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Positioned(
              bottom: ResponsiveSizeUtil.size20,
              left: ResponsiveSizeUtil.size20,
              child: SizedBox(
                width: MediaQuery.of(context).size.width -
                    2 * ResponsiveSizeUtil.size20,
                child: Row(
                  children: [
                    Container(
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
                    SizedBox(
                      width: ResponsiveSizeUtil.scaleFactorWidth * 10,
                    ), // Adding space between the image and search field
                    Expanded(
                      child: Container(
                        height: ResponsiveSizeUtil.size40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(ResponsiveSizeUtil.size10),
                          color: const Color(0xFFF0F0F0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveSizeUtil.size3,
                          ),
                          child: TextFormField(
                            controller: controller.searchController.value,
                            focusNode: controller.searchFocusNode.value,
                            style: TextStyle(
                              fontSize: ResponsiveSizeUtil.size15,
                              color: AppColor.blackColor,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: AppColor.primaryColor,
                                size: 24,
                              ),
                              labelText: 'Search',
                              labelStyle: TextStyle(
                                fontSize: ResponsiveSizeUtil.size15,
                                color: AppColor.grayColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
      ),
    );
  }
}
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final LatLng lasVegasCoordinates = const LatLng(36.1699, -115.1398);
//   final MapController mapController = MapController();
//   double? previousY;

//   void onVerticalDragUpdate(DragUpdateDetails details) {
//     final currentY = details.globalPosition.dy;
//     if (previousY != null) {
//       final deltaY = currentY - previousY!;
//       final newZoom = mapController.zoom + deltaY / 100;
//       mapController.move(mapController.center, newZoom);
//     }
//     previousY = currentY;
//   }

//   void onVerticalDragEnd(DragEndDetails details) {
//     previousY = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.secondaryColor,
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: AppColor.secondaryColor,
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(ResponsiveSizeUtil.size40),
//                 bottomRight: Radius.circular(ResponsiveSizeUtil.size40),
//               ),
//             ),
//             child: FlutterMap(
//               options: MapOptions(
//                 center: lasVegasCoordinates,
//                 minZoom: 5,
//                 maxZoom: 22,
//                 zoom: 14,
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate:
//                       "https://api.mapbox.com/styles/v1/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
//                   additionalOptions: const {
//                     'accessToken': MAPBOX_ACCESS_TOKEN,
//                     'id': 'mapbox/satellite-streets-v12'
//                   },
//                   retinaMode: true,
//                 ),
//                 const MarkerLayer(
//                   markers: [],
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: AppBar(
//               backgroundColor: Colors.transparent,
//               foregroundColor: AppColor.whiteColor,
//               title: CustomText(
//                 text: "",
//                 color: AppColor.whiteColor,
//                 fontSize: ResponsiveSizeUtil.size16,
//                 fontWeight: FontWeight.w600,
//               ),
//               actions: [
//                 IconButton(
//                   onPressed: () => Get.toNamed("/profile_screen"),
//                   icon: const Icon(Icons.person_outline_rounded),
//                   iconSize: 24,
//                 )
//               ],
//             ),
//           ),
//           Positioned.fill(
//             child: GestureDetector(
//               onVerticalDragUpdate: onVerticalDragUpdate,
//               onVerticalDragEnd: onVerticalDragEnd,
//               behavior: HitTestBehavior.translucent,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

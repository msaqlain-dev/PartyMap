import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:partymap/Screens/home/home_controller.dart';
import 'package:partymap/Screens/home/widgets/location_search_controller.dart';
import 'package:partymap/res/colors/app_color.dart';
import 'package:partymap/utils/responsive_size_util.dart';

class LocationSearchWidget extends StatelessWidget {
  final LocationSearchController controller =
      Get.put(LocationSearchController());

  final HomeController homeController = Get.put(HomeController());

  LocationSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => controller.showSuggestions.value
              ? Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColor.lightColor,
                    ),
                    child: Obx(
                      () => ListView.builder(
                        itemCount: controller.suggestions.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(controller.suggestions[index].name),
                            onTap: () {
                              homeController.updateCameraPosition(
                                  controller.suggestions[index].latitude,
                                  controller.suggestions[index].longitude);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 160,
                ),
        ),
        Container(
          height: ResponsiveSizeUtil.size40,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ResponsiveSizeUtil.size10),
            color: const Color(0xFFF0F0F0),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveSizeUtil.size3,
            ),
            child: TextFormField(
              onChanged: controller.searchLocation,
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
                hintText: 'Search',
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:partymap/Screens/home/home_controller.dart';
import 'package:partymap/Screens/home/widgets/venue_details.dart';
import 'package:partymap/res/assets/image_assets.dart';
import 'package:partymap/res/colors/app_color.dart';
import 'package:partymap/res/components/custom_text.dart';
import 'package:partymap/utils/responsive_size_util.dart';

class VenueDetailBottomSheet extends StatelessWidget {
  final VenueDetails venueDetails;

  VenueDetailBottomSheet({Key? key, required this.venueDetails})
      : super(key: key);

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final List<double> data = [50, 60, 45, 80, 100, 75, 65];
    final List<String> times = [
      '4am',
      '5am',
      '6am',
      '4pm',
      '6pm',
      '7pm',
      '8pm',
    ];
    final double maxBarHeight = 50.0;
    return Container(
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.9),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: IconButton(
          //     icon: Icon(Icons.close, color: Colors.white),
          //     onPressed: () {
          //       homeController.clicked.value = false; // Close the bottom sheet
          //     },
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          // Your venue detail widgets go here. For example:
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Venue',
                    fontSize: 16,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                  Container(
                    height: 48,
                    width: 48,
                    // color: AppColor.grayColor,
                    child: Image.asset(ImageAssets.partyImg1),
                  ),
                  CustomText(
                    text: 'www.org.com',
                    fontSize: 8,
                    color: AppColor.whiteColor,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Tonight',
                    fontSize: 16,
                    color: AppColor.whiteColor,
                    fontWeight: FontWeight.w800,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 48,
                        width: 48,
                        // color: AppColor.grayColor,
                        child: Image.asset(ImageAssets.partyImg2),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 200,
                        child: CustomText(
                          text:
                              'Step into the ultimate party zone: where music pumps, drinks flow, and good times roll!',
                          fontSize: 8,
                          color: AppColor.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Spacer(),
              Column(
                children: [
                  CustomText(
                    text: 'Tickets',
                    color: AppColor.whiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  CustomText(
                    text: 'Time',
                    color: AppColor.whiteColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  )
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  data.length,
                  (index) {
                    final barHeight = 50 / data[index] * maxBarHeight;
                    return Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 12,
                              height: barHeight, // Scale the bar height.
                              decoration: BoxDecoration(
                                color: times[index].endsWith('am')
                                    ? Colors.blue
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                            const SizedBox(height: 5),
                            CustomText(
                              text: times[index],
                              color: AppColor.whiteColor,
                              fontSize: 8,
                            )
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ],
      ),
    );
  }
}

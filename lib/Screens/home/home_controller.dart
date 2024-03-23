import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:latlong2/latlong.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:partymap/Screens/dashboard/dashboard_controller.dart';
import 'package:partymap/Screens/home/widgets/venue_detail_bottomsheet.dart';
import 'package:partymap/Screens/home/widgets/venue_details.dart';
import 'package:partymap/res/assets/image_assets.dart';
import 'package:partymap/res/colors/app_color.dart';

class HomeController extends GetxController {
  MapboxMap? mapboxMap;

  RxDouble latitude = 36.1699.obs;
  RxDouble longitude = (-115.1398).obs;
  RxDouble zoom = 10.0.obs;

  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();
  final DashboardController dashboardController =
      Get.find<DashboardController>();
  PointAnnotationManager? pointAnnotationManager;
  List<PointAnnotationOptions> options = [];

  final Rxn<VenueDetails> selectedVenue = Rxn<VenueDetails>();

  RxBool clicked = false.obs;

  RxString mapType = "Dark".obs;

  // Additional variable to store details for each annotation
  final Map<String, VenueDetails> annotationDetails = {};

  // final List<VenueDetails> party = [
  //   VenueDetails(
  //     name: "Drai's Beachclub & Nightclub",
  //     description: "It's Paty",
  //     longitude: -115.17217125911195,
  //     latitude: 36.11509362417488,
  //   ),
  // ];

  // final List<VenueDetails> bar = [
  //   VenueDetails(
  //     name: 'Arc Bar',
  //     description: "It's Bar",
  //     longitude: -115.17255939774128,
  //     latitude: 36.11244019665051,
  //   ),
  // ];

  // final List<VenueDetails> restaurant = [
  //   VenueDetails(
  //     name: "Hell's Kitchen",
  //     description: "It's Restaurant",
  //     longitude: -115.17323234620663,
  //     latitude: 36.11572852007753,
  //   ),
  // ];

  @override
  void onInit() {
    super.onInit();
    // Listen to changes in selected markers and update the map accordingly
    ever(dashboardController.selectedMarkers, (_) => updateMarkers());
  }

  void updateMapType(String newMapType) {
    mapType.value = newMapType;
    update();
  }

  void updateCameraPosition(double latitude, double longitude) {
    if (mapboxMap != null) {
      // Ensure the mapboxMap is not null
      CameraOptions cameraOptions = CameraOptions(
        center: {
          'type': 'Point',
          'coordinates': [
            longitude,
            latitude
          ], // Notice the order is [longitude, latitude]
        },
        zoom: 18,
        pitch: 75.0,
      );

      MapAnimationOptions animationOptions = MapAnimationOptions(
        duration: 1000, // Set the animation duration to 1000 milliseconds
        startDelay: 0, // Start the animation immediately
      );

      // Use easeTo for a smooth transition, applying the camera and animation options
      mapboxMap!.easeTo(cameraOptions, animationOptions);
    }
  }

  void onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    pointAnnotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    updateMarkers();
    setupPointAnnotationListener();
  }

  // void updateMarkers() async {
  //   final ByteData bytes = await rootBundle.load(ImageAssets.markerIconSmall);
  //   final Uint8List list = bytes.buffer.asUint8List();
  //   // List<PointAnnotationOptions> options = [];

  //   var labels = {
  //     MarkerType.parties: 'Party',
  //     MarkerType.bars: 'Bar',
  //     MarkerType.restaurants: "Hell's Kitchen",
  //   };

  //   // This is a simplification. You would have different lists for each marker type.
  //   var points = {
  //     MarkerType.parties: [
  //       Point(coordinates: Position(-115.17217125911195, 36.11509362417488))
  //           .toJson(),
  //       // Add more party points
  //     ],
  //     MarkerType.bars: [
  //       Point(coordinates: Position(-115.17255939774128, 36.11244019665051))
  //           .toJson(),
  //       // Add more bar points
  //     ],
  //     MarkerType.restaurants: [
  //       Point(coordinates: Position(-115.17323234620663, 36.11572852007753))
  //           .toJson(),
  //       // Add more restaurant points
  //     ],
  //   };

  //   var details = {
  //     MarkerType.parties: [
  //       VenueDetails(
  //         name: "Drai's Beachclub & Nightclub",
  //         description: "It's Paty",
  //       ),
  //       // Add more party points
  //     ],
  //     MarkerType.bars: [
  //       VenueDetails(
  //         name: 'Arc Bar',
  //         description: "It's Bar",
  //       ),
  //       // Add more bar points
  //     ],
  //     MarkerType.restaurants: [
  //       VenueDetails(
  //         name: "Hell's Kitchen",
  //         description: "It's Restaurant",
  //       ),
  //       // Add more restaurant points
  //     ],
  //   };

  //   // Update the markers based on selected types
  //   if (dashboardController.selectedMarkers.isNotEmpty) {
  //     for (var type in dashboardController.selectedMarkers) {
  //       for (var point in points[type] ?? []) {
  //         options.add(
  //           PointAnnotationOptions(
  //             geometry: point,
  //             image: list,
  //             textField: labels[type], // Add text label
  //             textSize: 14, // Set the size of the text (optional)
  //             textColor:
  //                 AppColor.whiteColor.value, // Set the text color (optional)
  //             textHaloColor: AppColor.primaryColor
  //                 .value, // Set the text halo color for better readability (optional)
  //             textHaloWidth: 5.0, // Set the text halo width (optional)
  //             textHaloBlur: 5.0,
  //             textOffset: [0.0, 1.5],
  //           ),
  //         );
  //       }
  //     }
  //   } else {
  //     // If no markers are selected, add all
  //     for (var typePoints in points.values) {
  //       for (var point in typePoints) {
  //         options.add(PointAnnotationOptions(geometry: point, image: list));
  //       }
  //     }
  //   }

  //   // Clear existing markers and add new ones based on selected types
  //   await pointAnnotationManager?.deleteAll();
  //   await pointAnnotationManager?.createMulti(options);
  // }

  void updateMarkers() async {
    final ByteData bytes = await rootBundle.load(ImageAssets.markerIconSmall);
    final Uint8List list = bytes.buffer.asUint8List();
    List<PointAnnotationOptions> options = [];
    List<String> ids = []; // Temp store for generated ids

    // Definitions for marker points and details should be here
    var points = {
      MarkerType.parties: [
        Point(coordinates: Position(-115.17217125911195, 36.11509362417488))
            .toJson(),
        // Add more party points
      ],
      MarkerType.bars: [
        Point(coordinates: Position(-115.17255939774128, 36.11244019665051))
            .toJson(),
        // Add more bar points
      ],
      MarkerType.restaurants: [
        Point(coordinates: Position(-115.17323234620663, 36.11572852007753))
            .toJson(),
        // Add more restaurant points
      ],
    };

    var details = {
      MarkerType.parties: [
        VenueDetails(
          name: "Drai's Beachclub & Nightclub",
          description: "It's Paty",
        ),
        // Add more party points
      ],
      MarkerType.bars: [
        VenueDetails(
          name: 'Arc Bar',
          description: "It's Bar",
        ),
        // Add more bar points
      ],
      MarkerType.restaurants: [
        VenueDetails(
          name: "Hell's Kitchen",
          description: "It's Restaurant",
        ),
        // Add more restaurant points
      ],
    };

    // Clear existing markers
    await pointAnnotationManager?.deleteAll();

    // Create new annotations based on the filters
    int counter = 0;
    dashboardController.selectedMarkers.forEach((type) {
      var typePoints = points[type] ?? [];
      var typeDetails = details[type] ?? [];

      for (int i = 0; i < typePoints.length; i++) {
        // var pointId = 'point_$counter';
        String pointId = "point_${type.toString()}_$i";
        counter++;

        options.add(PointAnnotationOptions(
          geometry: typePoints[i],
          image: list,
          textField: typeDetails[i].name, // Here we add the name
          textSize: 14, // Set the size of the text (optional)
          textColor: AppColor.whiteColor.value, // Set the text color (optional)
          textHaloColor: AppColor.primaryColor
              .value, // Set the text halo color for better readability (optional)
          textHaloWidth: 5.0, // Set the text halo width (optional)
          textHaloBlur: 5.0,
          textOffset: [0.0, 1.5],
        ));

        // Map this point's unique ID (or geometry) to its VenueDetails
        String geoKey = typePoints[i]
            .toString(); // Convert geometry to string as unique key
        annotationDetails[geoKey] = typeDetails[i];

        // Save details for this point
        // annotationDetails[pointId] = typeDetails[i];
      }
    });

    // If no markers are selected, add all types
    if (dashboardController.selectedMarkers.isEmpty) {
      for (var type in MarkerType.values) {
        var typePoints = points[type] ?? [];
        var typeDetails = details[type] ?? [];

        for (int i = 0; i < typePoints.length; i++) {
          var pointId = 'point_${type.toString()}_$i';
          counter++;

          options.add(PointAnnotationOptions(
            geometry: typePoints[i],
            image: list,
            textField: typeDetails[i].name, // Here we add the name
            textSize: 14, // Set the size of the text (optional)
            textColor:
                AppColor.whiteColor.value, // Set the text color (optional)
            textHaloColor: AppColor.primaryColor
                .value, // Set the text halo color for better readability (optional)
            textHaloWidth: 5.0, // Set the text halo width (optional)
            textHaloBlur: 5.0,
            textOffset: [0.0, 1.5],
          ));

          // Map this point's unique ID (or geometry) to its VenueDetails
          String geoKey = typePoints[i]
              .toString(); // Convert geometry to string as unique key
          annotationDetails[geoKey] = typeDetails[i];

          // Save details for this point
          // annotationDetails[pointId] = typeDetails[i];
        }
      }
    }

    // Add new markers
    pointAnnotationManager?.createMulti(options);
  }

  // void setupPointAnnotationListener() {
  //   pointAnnotationManager
  //       ?.addOnPointAnnotationClickListener((PointAnnotation annotation) {
  //     String annotationId = annotation.id;
  //     VenueDetails? details = annotationDetails[annotationId];
  //     if (details != null) {
  //       selectVenue(
  //           details); // Assuming you have a method to handle the selection and display of venue details
  //     }
  //   } as OnPointAnnotationClickListener);
  // }

  // void setupPointAnnotationListener() {
  //   var listener = MyPointAnnotationClickListener((PointAnnotation annotation) {
  //     String annotationId = annotation.id;
  //     VenueDetails? details = annotationDetails[annotationId];
  //     if (details != null) {
  //       selectVenue(
  //           details); // Assuming selectVenue updates your UI appropriately
  //     }
  //   });

  //   pointAnnotationManager?.addOnPointAnnotationClickListener(listener);
  // }

  void setupPointAnnotationListener() {
    var listener = MyPointAnnotationClickListener((PointAnnotation annotation) {
      String geoKey = annotation.geometry.toString();
      VenueDetails? details = annotationDetails[geoKey];
      if (details != null) {
        selectVenue(details);
      } else {
        Positioned(
            child: VenueDetailBottomSheet(
                venueDetails: VenueDetails(
                    name: 'Venue Name', description: 'Venue Description')));
      }
    });

    pointAnnotationManager?.addOnPointAnnotationClickListener(listener);
  }

  void selectVenue(VenueDetails details) {
    selectedVenue.value = details; // This should trigger the UI to update
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}

class MyPointAnnotationClickListener implements OnPointAnnotationClickListener {
  final void Function(PointAnnotation) callback;

  MyPointAnnotationClickListener(this.callback);

  final HomeController controller = Get.find<HomeController>();

  // @override
  // void onPointAnnotationClick(PointAnnotation annotation) {
  //   callback(annotation);
  // }
  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    print("Annotation clicked: ${annotation.id}");
    controller.clicked.value = true;
    callback(annotation);
  }
}

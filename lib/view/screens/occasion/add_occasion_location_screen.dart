import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/occasion/add_occasion_location_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class AddOccasionLocationScreen extends StatelessWidget {
  const AddOccasionLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddOccasionLocationController());
    return Scaffold(
      appBar: AppBar(title: const Text('Select your location')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.goToMyCurrentLocation();
        },
        backgroundColor: AppColors.secondaryColor,
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: GetBuilder<AddOccasionLocationController>(
        builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    markers: controller.marker.toSet(),
                    onTap: (latLong) {
                      controller.setMarkAndSaveNewLatLong(latLong);
                    },
                    initialCameraPosition: controller.cameraPosition,
                    onMapCreated: (GoogleMapController mController) {
                      controller.mapController.complete(mController);
                    },
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 120.w,
                    left: 120.w,
                    child: GoHomeButton(
                      text: 'حفظ',
                      onTap: () {
                        controller.onTapSave();
                      },
                    )),
                FloatingSearch()
              ],
            )),
      ),
    );
  }
}

class FloatingSearch extends StatelessWidget {
  const FloatingSearch({
    super.key,
    this.isPortrait = true,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: 'بحث...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          // child: CircularButton(
          //   icon: const Icon(Icons.place),
          //   onPressed: () {

          //   },
          // ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

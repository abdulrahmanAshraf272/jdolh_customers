import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/display_location_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';

class DisplayLocationScreen extends StatelessWidget {
  const DisplayLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayLocationController());
    return Scaffold(
      appBar: customAppBar(title: 'الموقع'.tr),
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
      body: GetBuilder<DisplayLocationController>(
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
                    initialCameraPosition: controller.cameraPosition,
                    onMapCreated: (GoogleMapController mController) {
                      controller.mapController.complete(mController);
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

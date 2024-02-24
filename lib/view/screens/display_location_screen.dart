import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jdolh_customers/controller/occasion/add_occasion_location_controller.dart';
import 'package:jdolh_customers/controller/display_location_controller.dart';
import 'package:jdolh_customers/controller/select_address_controller.dart';
import 'package:jdolh_customers/core/class/handling_data_view.dart';
import 'package:jdolh_customers/core/class/status_request.dart';
import 'package:jdolh_customers/core/constants/app_colors.dart';
import 'package:jdolh_customers/view/screens/checkin/checkin_screen.dart';
import 'package:jdolh_customers/view/widgets/common/buttons/gohome_button.dart';
import 'package:jdolh_customers/view/widgets/common/custom_appbar.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class DisplayLocationScreen extends StatelessWidget {
  const DisplayLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayLocationController());
    return Scaffold(
      appBar: customAppBar(title: 'الموقع'),
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

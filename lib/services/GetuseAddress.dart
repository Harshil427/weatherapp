// ignore_for_file: unnecessary_null_comparison, file_names, avoid_print, unused_import

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GetAddress {
  Future<String> getAddressFromCoordinates(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          latitude, longitude); // Set the desired timeout duration

      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;

        // Extract address components and return the address
        String address =
            "${placemark.subThoroughfare} ${placemark.thoroughfare}, "
            "${placemark.subLocality}, ${placemark.locality}, "
            "${placemark.subAdministrativeArea}, ${placemark.administrativeArea} ${placemark.postalCode}, "
            "${placemark.country}";

        return address;
      } else {
        return "Address not found";
      }
    } catch (e) {
      // Handle the timeout or any other exception
      return "Error retrieving address";
    }
  }

  void getUserAddress(double latitude, double longitude) async {
    print('Address Called');
    String address = await getAddressFromCoordinates(latitude, longitude);
    print('Called return');
    // Use the address in your app as needed
    print("User's address: $address");
  }
}

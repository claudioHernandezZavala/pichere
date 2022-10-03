import 'dart:async';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

/**
 * This function retrieves the gps position of the user
 */
Future<Position> determineCurrentPosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

Future<Placemark> completePosition() async {
  final position = await determineCurrentPosition();

  List pm =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  return pm[0];
}

/// Retrieves the name and extra info of position withoud calling the currentposition function.
Future<Placemark> completePositionWithParam(Position pos) async {
  List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
  return pm[0];
}

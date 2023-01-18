import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppyphilia/modules/profile/API/get_single_profile_api.dart';
import 'package:shoppyphilia/modules/profile/model/user.dart';

class ProfileProvider with ChangeNotifier {
  User user;
  bool isGetSingleUserFetching = false;
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> markers = [];
  Marker _markers;

  ProfileProvider(){
    getSingleUser();
  }
  /// get single user details api function
  getSingleUser() async {
    isGetSingleUserFetching = true;
    var response = await GetSingleProfileApi().getSingleProfile();
    isGetSingleUserFetching = false;
    notifyListeners();
    Map<String, dynamic> data = json.decode(response);
    user = User.fromJson(data);
    getUserLocation();
    notifyListeners();
  }

  /// get user location by his (lat,long)
  getUserLocation(){
    _markers = Marker(
      markerId: MarkerId('1'),
      position:
      LatLng(
        double.parse(user.address.geolocation.lat),
        double.parse(user.address.geolocation.long),
      ),
      infoWindow: InfoWindow(title: 'location'),
    );
    markers.add(_markers);
    notifyListeners();
  }
}


import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shoppyphilia/modules/signup/api/signup_api.dart';

class SignUpProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController buildingNoController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  String locationLatitude;
  String locationLongitude;
  bool personalInfoIsNotRequired = false;
  bool validCounter = false;
  bool validUpperCase = false;
  bool validSpecialCharacterCase = false;
  bool validNumbers = false;
  bool isSignUpFetching = false;
  Completer<GoogleMapController> mapController = Completer();
  List<Marker> markers = [];
  Marker _markers;

  SignUpProvider() {
    getDefaultLocation();
  }
  /// signUp api function
  Future<bool> signUp(
      {String email,
      String username,
      String password,
      String firstname,
      String lastname,
      String city,
      String street,
      int number,
      String zipcode,
      String lat,
      String long,
      String phone}) async {
    Map registerMap = {
      'email': 'John@gmail.com',
      'username': 'johnd',
      'password': 'm38rmF\$',
      'name': {'firstname': 'John', 'lastname': 'Doe'},
      'address': {
        'city': 'kilcoole',
        'street': '7835 new road',
        'number': 3,
        'zipcode': '12926-3874',
        'geolocation': {'lat': '-37.3159', 'long': '81.1496'}
      },
      'phone': '1-570-236-7033'
    };
    isSignUpFetching = true;
    notifyListeners();
    var response = await SignUpApi().signUp(registerMap.toString());
    isSignUpFetching = false;
    notifyListeners();
    var data = json.decode(response);
    bool status = false;
    if (data != null) {
      status = true;
    }
    notifyListeners();
    return status;
  }

  /// set default location on map
  getDefaultLocation() {
    _markers = Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.743525, 46.657719),
      infoWindow: InfoWindow(title: 'location'),
    );
    markers.add(_markers);
    notifyListeners();
  }
}

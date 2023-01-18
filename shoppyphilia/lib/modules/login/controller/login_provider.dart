import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppyphilia/Data_access_layer/sharedpref_constants.dart';
import 'package:shoppyphilia/modules/login/api/login_api.dart';

class LoginProvider with ChangeNotifier {
  TextEditingController loginUserNameController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool loginShowPassword = true;
  bool isLoginFetching = false;
  final formGlobalKey = GlobalKey<FormState>();

  /// login api function
  Future<bool> login({String userName,String password}) async {
    Map loginMap = {"username": "mor_2314", "password": "83r5^_"};
    isLoginFetching = true;
    notifyListeners();
    var response = await LoginApi().login(loginMap.toString());
    isLoginFetching = false;
    notifyListeners();
    var data = jsonDecode(response);
    bool status = false;
    if (data != null) {
      status = true;
    }
    notifyListeners();
    return status;
  }

  /// set app user state in shared preferences storage function
  setInSharedPreference() async {
    (await SharedPreferences.getInstance())
        .setString(SharedPrefConstants.userState, 'loggedIn');
  }
}

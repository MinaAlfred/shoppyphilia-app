import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/button.dart';
import 'package:shoppyphilia/constants/widget/divider_item.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/constants/widget/textField&validation.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/login/veiw/login_screen.dart';
import 'package:shoppyphilia/modules/signup/controller/signUp_provider.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<SignUpProvider>(
        create: (_) => SignUpProvider(),
        child: _SignUpProviderBody(),
      ),
    );
  }
}

class _SignUpProviderBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignUpProviderBodyState();
  }
}

class _SignUpProviderBodyState extends State<_SignUpProviderBody>
    with InputValidation {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(
        builder: (_, SignUpProvider myProvider, child) {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
        },
        child: Scaffold(
          backgroundColor: MyColors.whiteColor,
          body: SafeArea(
            child:  Form(
              key: myProvider.formGlobalKey,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 15, right: 15),
                  child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/images/back icon.gif',
                        height: 25,
                        width: 25,
                        color: MyColors.blackColor,
                      )),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: MyText.drawText(
                                content: 'SignUp',
                                fontSize: getFont(34),
                                fontColor: MyColors.mediumGreyColor,
                                bold: true),
                          ),

                          SpaceItem(height: getHeight(15)),

                          ///userName
                          getTextInputField(
                            labelText: "User Name",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.userNameController,
                            validatorFunction: validateName,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),

                          SpaceItem(height: getHeight(15)),

                          ///firstName
                          getTextInputField(
                            labelText: "First Name",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.firstNameController,
                            validatorFunction: validateName,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),

                          SpaceItem(height: getHeight(15)),

                          ///lastName
                          getTextInputField(
                            labelText: "Last Name",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.lastNameController,
                            validatorFunction: validateName,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),

                          SpaceItem(height: getHeight(15)),
                          ///PhoneNumber
                          getTextInputField(
                            labelText: "Phone number",
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.phoneController,
                            validatorFunction: validatePhoneNumber,
                            autoValidationMode:
                            AutovalidateMode.onUserInteraction,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),
                          SpaceItem(height: getHeight(15)),
                          ///Email
                          getTextInputField(
                            labelText: "Email",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.emailController,
                            validatorFunction: validateEmail,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),

                          SpaceItem(height: getHeight(15)),

                          ///Password
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: MyColors.textFieldBackground,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      width: getWidth(2),
                                      color: MyColors.textFieldBackground)),
                              child: TextFormField(
                                controller: myProvider.passwordController,
                                cursorColor: MyColors.orangeColor,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: validateNotEmpty,
                                onChanged: (value) {
                                  final validCounter = value.length >= 8;
                                  final validUpperCase =
                                      value.contains(RegExp(r'[a-zA-Z]'));
                                  final validSpecialCharacterCase =
                                      value.contains(
                                          RegExp(r'[\@\#\$\%\^\&\*\^\!]'));
                                  final validNumbers =
                                      value.contains(RegExp(r'[0-9]'));
                                  setState(() {
                                    if (validCounter) {
                                      myProvider.validCounter = true;
                                    } else {
                                      myProvider.validCounter = false;
                                    }
                                    if (validSpecialCharacterCase) {
                                      myProvider.validSpecialCharacterCase =
                                          true;
                                    } else {
                                      myProvider.validSpecialCharacterCase =
                                          false;
                                    }
                                    if (validUpperCase) {
                                      myProvider.validUpperCase = true;
                                    } else {
                                      myProvider.validUpperCase = false;
                                    }
                                    if (validNumbers) {
                                      myProvider.validNumbers = true;
                                    } else {
                                      myProvider.validNumbers = false;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  contentPadding: EdgeInsets.all(10.0),
                                  labelStyle: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: MyColors.blackColor,
                                      fontSize: getFont(22),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                    fontSize: getFont(24),
                                    color: MyColors.blackColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SpaceItem(height: getHeight(15)),

                          /// validation
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              (myProvider.validCounter)
                                                  ? MyImage.drawImage(
                                                      'assets/images/checked.png',
                                                      height: 15,
                                                      width: 15)
                                                  : MyImage.drawImage(
                                                      'assets/images/unchecked.png',
                                                      height: 15,
                                                      width: 15),
                                              const SpaceItem(width: 15),
                                              Text("At Least 8 Characters",
                                                  style: TextStyle(
                                                      color: (myProvider
                                                              .validCounter)
                                                          ? MyColors
                                                              .greenColor
                                                          : MyColors
                                                              .mediumGreyColor,
                                                      fontSize: getFont(16)))
                                            ])),
                                    const SpaceItem(width: 15),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              (myProvider.validUpperCase)
                                                  ? MyImage.drawImage(
                                                      'assets/images/checked.png',
                                                      height: 15,
                                                      width: 15)
                                                  : MyImage.drawImage(
                                                      'assets/images/unchecked.png',
                                                      height: 15,
                                                      width: 15),
                                              const SpaceItem(width: 10),
                                              Text("Upper/Lower letters",
                                                  style: TextStyle(
                                                      color: (myProvider
                                                              .validUpperCase)
                                                          ? MyColors
                                                              .greenColor
                                                          : MyColors
                                                              .mediumGreyColor,
                                                      fontSize: getFont(16)))
                                            ])),
                                  ],
                                ),
                                const SpaceItem(height: 15),
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              (myProvider
                                                      .validSpecialCharacterCase)
                                                  ? MyImage.drawImage(
                                                      'assets/images/checked.png',
                                                      height: 15,
                                                      width: 15)
                                                  : MyImage.drawImage(
                                                      'assets/images/unchecked.png',
                                                      height: 15,
                                                      width: 15),
                                              const SpaceItem(width: 10),
                                              Text(
                                                "Special Characters",
                                                style: TextStyle(
                                                    color: (myProvider
                                                            .validSpecialCharacterCase)
                                                        ? MyColors.greenColor
                                                        : MyColors
                                                            .mediumGreyColor,
                                                    fontSize: getFont(16)),
                                              )
                                            ])),
                                    const SpaceItem(width: 15),
                                    Expanded(
                                        flex: 1,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              (myProvider.validNumbers)
                                                  ? MyImage.drawImage(
                                                      'assets/images/checked.png',
                                                      height: 15,
                                                      width: 15)
                                                  : MyImage.drawImage(
                                                      'assets/images/unchecked.png',
                                                      height: 15,
                                                      width: 15),
                                              const SpaceItem(width: 10),
                                              Text("Numbers",
                                                  style: TextStyle(
                                                      color: (myProvider
                                                              .validNumbers)
                                                          ? MyColors
                                                              .greenColor
                                                          : MyColors
                                                              .mediumGreyColor,
                                                      fontSize: getFont(16)))
                                            ])),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const DividerItem(),

                          ///City
                          getTextInputField(
                            labelText: "City",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.cityController,
                            validatorFunction: validateNotEmpty,
                            autoValidationMode:
                            AutovalidateMode.onUserInteraction,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),
                          SpaceItem(height: getHeight(15)),

                          ///street
                          getTextInputField(
                            labelText: "Street",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.streetController,
                            validatorFunction: validateNotEmpty,
                            autoValidationMode:
                            AutovalidateMode.onUserInteraction,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),
                          SpaceItem(height: getHeight(15)),

                          ///building no.
                          getTextInputField(
                            labelText: "Building No.",
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: myProvider.buildingNoController,
                            validatorFunction: validateNotEmpty,
                            autoValidationMode:
                            AutovalidateMode.onUserInteraction,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),
                          SpaceItem(height: getHeight(15)),

                          ///ZIP code.
                          getTextInputField(
                            labelText: "ZIP code",
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            controller: myProvider.zipCodeController,
                            validatorFunction: validateNotEmpty,
                            autoValidationMode:
                            AutovalidateMode.onUserInteraction,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                          ),

                          SpaceItem(height: getHeight(15)),

                          ///Location
                          getTextInputField(
                            labelText: "Location",
                            controller: myProvider.locationController,
                            validatorFunction: validateNotEmpty,
                            autoValidationMode:
                            AutovalidateMode.onUserInteraction,
                            maxLines: 2,
                            fontSize: getFont(24),
                            hintFontSize: getFont(22),
                            enabled: false,
                            suffix: Icon(
                              Icons.location_on,
                              color: MyColors.mediumGreyColor,
                            ),
                          ),
                          SpaceItem(height: getHeight(15)),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///location title
                                MyText.drawText(
                                    content: 'Pick Your Location',
                                    fontSize: getFont(23),
                                    fontColor: MyColors.blackColor,
                                    bold: true),
                                SpaceItem(height: getHeight(10)),
                                SizedBox(
                                  height: getHeight(200),
                                  child: GoogleMap(
                                    mapType: MapType.normal,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(24.743525, 46.657719),
                                      zoom: 2.0,
                                    ),
                                    onMapCreated: (GoogleMapController
                                        googleMapController) {
                                      myProvider.mapController
                                          .complete(googleMapController);
                                    },
                                    markers: Set.from(myProvider.markers),
                                    onTap: (x) {
                                      myProvider.markers.clear();
                                      Marker f = Marker(
                                          markerId: MarkerId('1'),
                                          infoWindow: InfoWindow(
                                            title: 'My Location',
                                          ),
                                          position:
                                              LatLng(x.latitude, x.longitude),
                                          onTap: () {});
                                      setState(() {
                                        myProvider.markers.add(f);
                                        myProvider.locationController.text =
                                            'lat: ${x.latitude}\nlong: ${x.longitude}';
                                        myProvider.locationLatitude =
                                            x.latitude.toString();
                                        myProvider.locationLongitude =
                                            x.longitude.toString();
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SpaceItem(height: getHeight(30)),
                          myProvider.isSignUpFetching
                              ? const LoadingItem()
                              : SpaceItem(height: getHeight(20)),
                          SpaceItem(height: getHeight(20)),

                          ///register Button
                          Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0),
                              child: AppButton(
                                onPressed: () async {
                                  if (myProvider.formGlobalKey.currentState
                                      .validate()) {
                                    bool status = await myProvider.signUp(
                                      email: myProvider.emailController.text,
                                      username:
                                          myProvider.userNameController.text,
                                      password:
                                          myProvider.passwordController.text,
                                      firstname:
                                          myProvider.firstNameController.text,
                                      lastname:
                                          myProvider.lastNameController.text,
                                      city: myProvider.cityController.text,
                                      street:
                                          myProvider.streetController.text,
                                      number: int.parse(myProvider
                                          .buildingNoController.text),
                                      zipcode:
                                          myProvider.zipCodeController.text,
                                      lat: myProvider.locationLatitude,
                                      long: myProvider.locationLongitude,
                                      phone: myProvider.phoneController.text,
                                    );
                                    if (status) {
                                      MyToast('You Registered Successfully');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    }
                                  }
                                  else {
                                    MyToast('Please fill all required data');
                                  }
                                },
                                buttonText: "SignUp",
                                textSize: getFont(25),
                              )),
                          SpaceItem(height: getHeight(15)),
                        ],
                      ),
                    ),
                ),
                SpaceItem(height: getHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText.drawText(
                        content: "Already have account? ",
                        fontSize: getFont(20),
                        fontColor: MyColors.blackColor,
                        bold: false),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: MyText.drawText(
                          content: "Login",
                          fontSize: getFont(22),
                          fontColor: MyColors.orangeColor,
                          bold: true),
                    ),
                  ],
                ),
                SpaceItem(height: getHeight(15)),
              ],
            ),
          ),
        ),
       ),
      );
    });
  }
}

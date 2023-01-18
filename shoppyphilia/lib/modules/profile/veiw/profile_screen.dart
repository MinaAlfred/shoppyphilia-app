import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/appbar.dart';
import 'package:shoppyphilia/constants/widget/divider_item.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/profileText.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/profile/controller/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileProvider>(
      create: (_) => ProfileProvider(),
      child: _ProfileScreenBody(),
    );
  }
}

class _ProfileScreenBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenBodyState();
  }
}

class _ProfileScreenBodyState extends State<_ProfileScreenBody> {
  @override
  Widget build(BuildContext context) {
    DateTime _lastExitTime = DateTime.now();
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
        builder: (_, ProfileProvider myProvider, child) {
      return Scaffold(
        backgroundColor: MyColors.whiteColor,
        resizeToAvoidBottomInset: false,
        body: WillPopScope(
          onWillPop: () async {
            if (DateTime.now().difference(_lastExitTime) >=
                Duration(seconds: 2)) {
              MyToast(
                'Press the back button again to exist the application',
              );
              _lastExitTime = DateTime.now();
              return false; // disable back press
            } else {
              return true; //  exit the app
            }
          },
          child: Column(
            children: [
              /// appbar
              MyAppbar(
                title: 'Profile',
                isCart: false,
              ),
              Expanded(
                      child:myProvider.isGetSingleUserFetching
                          ? const LoadingItem()
                          :  SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SpaceItem(height: getHeight(30)),

                            /// user image
                            Center(
                              child: Container(
                                width: 100,
                                height: 100,
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: MyImage.drawImage(
                                        'assets/images/userImg.png',
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.fill),
                                  ),
                                ),
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///userName
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'User Name',
                                profileData: myProvider.user.username,
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///firstName
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'First Name',
                                profileData: myProvider.user.name.firstname,
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///lastName
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'Last Name',
                                profileData: myProvider.user.name.lastname,
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///Email
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'Email',
                                profileData: myProvider.user.email,
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///MobileNumber
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'Mobile Number',
                                profileData: myProvider.user.phone,
                              ),
                            ),
                            const DividerItem(),

                            ///city
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'City',
                                profileData: myProvider.user.address.city,
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///street
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'street',
                                profileData: myProvider.user.address.street,
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///building no
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'Building No.',
                                profileData:
                                    myProvider.user.address.number.toString(),
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            ///ZIP code
                            SizedBox(
                              width: size.width,
                              height: 70,
                              child: MyProfileText.drawProfileText(
                                title: 'ZIP code.',
                                profileData: myProvider.user.address.zipcode,
                              ),
                            ),
                            SpaceItem(height: getHeight(20)),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ///location title
                                  MyText.drawText(
                                      content: 'Location',
                                      fontSize: getFont(23),
                                      fontColor: MyColors.blackColor,
                                      bold: true),
                                  SpaceItem(height: getHeight(10)),
                                  /// google map
                                  SizedBox(
                                    height: getHeight(200),
                                    child: GoogleMap(
                                      mapType: MapType.normal,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                          double.parse(myProvider
                                              .user.address.geolocation.lat),
                                          double.parse(myProvider
                                              .user.address.geolocation.long),
                                        ),
                                        zoom: 2.0,
                                      ),
                                      onMapCreated: (GoogleMapController
                                          googleMapController) {
                                        myProvider.mapController
                                            .complete(googleMapController);
                                      },
                                      markers: Set.from(myProvider.markers),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SpaceItem(height: getHeight(30)),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}

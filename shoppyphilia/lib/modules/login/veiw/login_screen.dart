import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shoppyphilia/constants/appColors.dart';
import 'package:shoppyphilia/constants/utils/size_config.dart';
import 'package:shoppyphilia/constants/widget/button.dart';
import 'package:shoppyphilia/constants/widget/image.dart';
import 'package:shoppyphilia/constants/widget/loading_item.dart';
import 'package:shoppyphilia/constants/widget/space_item.dart';
import 'package:shoppyphilia/constants/widget/text.dart';
import 'package:shoppyphilia/constants/widget/textField&validation.dart';
import 'package:shoppyphilia/constants/widget/toast.dart';
import 'package:shoppyphilia/modules/main_tab_pages/view/main_tab_pages.dart';
import 'package:shoppyphilia/modules/login/controller/login_provider.dart';
import 'package:shoppyphilia/modules/signup/view/signUp_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
        child: _LoginProviderBody(),
      ),
    );
  }
}

class _LoginProviderBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginProviderBodyState();
  }
}

class _LoginProviderBodyState extends State<_LoginProviderBody> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (_, LoginProvider myProvider, child) {
      return Scaffold(
          backgroundColor: MyColors.whiteColor,
          body: Container(child: LoginPortrait()));
    });
  }
}

class LoginPortrait extends StatefulWidget {
  @override
  _LoginPortraitState createState() => _LoginPortraitState();
}

class _LoginPortraitState extends State<LoginPortrait> with InputValidation {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
        builder: (_, LoginProvider myProvider, child) {
      return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: myProvider.formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///login pic
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    child: Center(
                      child: MyImage.drawImage(
                        'assets/images/shoppyphilia.jpg',
                        width: getWidth(200),
                        height: getHeight(200),
                      ),
                    ),
                  ),

                  SpaceItem(height: getHeight(20)),

                  ///login title
                  Center(
                    child: MyText.drawText(
                        content: 'Login',
                        fontSize: getFont(34),
                        fontColor: MyColors.mediumGreyColor,
                        bold: true),
                  ),

                  SpaceItem(height: getHeight(20)),

                  ///userName
                  getTextInputField(
                    labelText: "User Name",
                    keyboardType: TextInputType.text,
                    controller: myProvider.loginUserNameController,
                    validatorFunction: validateName,
                    autoValidationMode: AutovalidateMode.onUserInteraction,
                    fontSize: getFont(24),
                    hintFontSize: getFont(22),
                    textInputAction: TextInputAction.next,
                  ),

                  SpaceItem(height: getHeight(20)),

                  ///password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: MyColors.textFieldBackground,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          controller: myProvider.loginPasswordController,
                          cursorColor: MyColors.orangeColor,
                          style: TextStyle(
                            color: MyColors.blackColor,
                            fontSize: getFont(24),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: myProvider.loginShowPassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: MyColors.blackColor,
                                fontSize: getFont(22),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                                icon: Icon(
                                  myProvider.loginShowPassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color(0xff30332E),
                                ),
                                onPressed: () {
                                  setState(() {
                                    myProvider.loginShowPassword =
                                        !myProvider.loginShowPassword;
                                  });
                                }),
                          ),
                          validator: validateLoginInput,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                    ),
                  ),

                  SpaceItem(height: getHeight(30)),
                  myProvider.isLoginFetching
                      ? const LoadingItem()
                      : SpaceItem(height: getHeight(20)),
                  SpaceItem(height: getHeight(20)),

                  ///login button
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: AppButton(
                        onPressed: () {
                          if (myProvider.formGlobalKey.currentState
                              .validate()) {
                             myProvider.login(
                                userName:
                                    myProvider.loginUserNameController.text,
                                password:
                                    myProvider.loginPasswordController.text);
                            myProvider.setInSharedPreference();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainTabPages(
                                          pageIndex: 1,
                                        )),
                                (Route<dynamic> route) => false);
                          } else {
                            MyToast('Please fill user name and password');
                          }
                        },
                        buttonText: "Login",
                        textSize: getFont(25),
                      ),
                  ),

                  SpaceItem(height: getHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText.drawText(
                          content: "Don\'t have account? ",
                          fontSize: getFont(20),
                          fontColor: MyColors.blackColor,
                          bold: false),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: MyText.drawText(
                            content: "SignUp",
                            fontSize: getFont(22),
                            fontColor: MyColors.orangeColor,
                            bold: true),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

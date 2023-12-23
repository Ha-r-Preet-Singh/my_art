import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_art/customs/custom_Elevated_Button.dart';
import 'package:my_art/customs/custom_container.dart';
import 'package:my_art/customs/custom_text.dart';
import 'package:my_art/customs/custom_textfield.dart';
import 'package:my_art/screens/home_screen.dart';
import 'package:my_art/screens/onboading/forget_password.dart';
import 'package:my_art/screens/onboading/login_screen.dart';
import 'package:my_art/screens/onboading/otp%20screen/otp_screen.dart';
import 'package:my_art/screens/onboading/signup_screen.dart';
import 'package:my_art/ui_helper.dart';

class MobileScreen extends StatefulWidget {
  const MobileScreen({super.key});

  @override
  State<MobileScreen> createState() => _MobileScreenState();
}

class _MobileScreenState extends State<MobileScreen> {
  var auth = FirebaseAuth.instance;

  var orientation;
  var portraitKey = GlobalKey<FormState>();
  var landscapeKey = GlobalKey<FormState>();
  var mobNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColors.onboardingColor,
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Form(
              key: portraitKey,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/originals/54/bd/ea/54bdea150e1dad3bc3586e7ab70f8fb7.png"),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: CustomContainer(
                    cHeight: media.size.height * .8,
                    cWidth: media.size.width * .9,
                    cColor: AppColors.begniColor.withOpacity(.3),
                    cRadius: BorderRadius.circular(20),
                    borderSideColor: AppColors.whiteColor,
                    borderSideWidth: 1,
                    mChild: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      color: AppColors.whiteColor,
                                    ),
                                    CustomText(
                                        fText: "Back",
                                        fSize: 25,
                                        fFamily: "poppinsbold",
                                        fColor: AppColors.whiteColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          hSpacer(mHeight: media.size.height * .03),
                          CustomText(
                              fText: "Login with Mobile Number",
                              fSize: 30,
                              fFamily: "poppinsbold",
                              fColor: AppColors.whiteColor),
                          hSpacer(mHeight: media.size.height * .03),
                          CustomText(
                              fText:
                                  "You will a receive 4 digit to verify that ",
                              fSize: 20,
                              fFamily: "poppinsbold",
                              fColor: AppColors.whiteColor),
                          hSpacer(mHeight: media.size.height * .03),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: CustomTextField(
                                    // TextEditContoller: mobNoController,

                                    hintTxt: "+91",
                                  ),
                                ),
                                wSpacer(),
                                Expanded(
                                  flex: 7,
                                  child: CustomTextField(
                                    TextEditContoller: mobNoController,
                                    hintTxt: "Phone Number",
                                    validate: (value) {
                                      if (value == "" || value!.length < 10) {
                                        return "Please enter a valid Phone Number(Password must be 10 Characters)";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          hSpacer(mHeight: media.size.height * .25),
                          SizedBox(
                            height: media.size.height * .07,
                            width: media.size.width * .75,
                            child: CustomElevatedButton(
                              onTap: () async {
                                auth.verifyPhoneNumber(
                                    phoneNumber:
                                        "+91${mobNoController.text.toString()}",
                                    verificationCompleted: (PhoneAuthCredential credential) {
                                      auth
                                          .signInWithCredential(credential)
                                          .then((value) => print(
                                              "Auto Sign-in Completed!!:${value.user!.uid}"));
                                    },
                                    verificationFailed: (error) {
                                      print(
                                          "Verification Failed: ${error.message}");
                                    },
                                    codeSent: (verificationId, resendToken) {
                                      // mVerificationId = verificationId;

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OtpScreen(mVId: verificationId),
                                          ));
                                    },
                                    codeAutoRetrievalTimeout:
                                        (verificationId) {});
                              },
                              mChild: CustomText(
                                fText: "Send OTP",
                                fFamily: "poppinsbold",
                                fColor: AppColors.whiteColor,
                                fSize: 20,
                              ),
                              ButtonRadius: BorderRadius.circular(15),
                              ButtonColor: AppColors.buttonColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Form(
              key: landscapeKey,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://i.pinimg.com/originals/54/bd/ea/54bdea150e1dad3bc3586e7ab70f8fb7.png"),
                      fit: BoxFit.cover),
                ),
                child: Center(
                  child: CustomContainer(
                    cHeight: media.size.height * .8,
                    cWidth: media.size.width * .9,
                    cColor: AppColors.begniColor.withOpacity(.3),
                    cRadius: BorderRadius.circular(20),
                    borderSideColor: AppColors.whiteColor,
                    borderSideWidth: 1,
                    mChild: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomText(
                            fText: "Welcome Back",
                            fSize: 30,
                            fFamily: "poppinsbold",
                            fColor: AppColors.whiteColor),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: media.size.height * .12,
                                width: media.size.width * .75,
                                child: CustomTextField(
                                  hintTxt: "Email address",
                                  validate: (value) {
                                    if (value == "" || !value!.contains("@")) {
                                      return "Please enter a valid email address";
                                    } else {
                                      return null;
                                    }
                                  },
                                )),
                            hSpacer(mHeight: media.size.height * .035),
                            SizedBox(
                              height: media.size.height * .12,
                              width: media.size.width * .75,
                              child: CustomTextField(
                                hintTxt: "Password",
                                suffIcon: Icons.visibility_off_outlined,
                                validate: (value) {
                                  if (value == "" || value!.length < 5) {
                                    return "Please enter a valid Password(Password must be 6 Characters)";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            hSpacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgetPassword(),
                                    ));
                              },
                              child: CustomText(
                                fText: "Forget Password?",
                                fColor: AppColors.hintextColor,
                                fFamily: "poppinsbold",
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: media.size.height * .1,
                                  width: media.size.width * .33,
                                  child: CustomElevatedButton(
                                    onTap: () async {},
                                    mChild: CustomText(
                                      fText: "Login",
                                      fFamily: "poppinsbold",
                                      fColor: AppColors.whiteColor,
                                      fSize: 20,
                                    ),
                                    ButtonRadius: BorderRadius.circular(15),
                                    ButtonColor: AppColors.buttonColor,
                                  ),
                                ),
                                hSpacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      fText: "Don't have account ?",
                                      fColor: AppColors.hintextColor,
                                      fFamily: "poppinsbold",
                                    ),
                                    wSpacer(mWidth: media.size.width * .01),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen(),
                                            ));
                                      },
                                      child: CustomText(
                                        fText: "Sign up",
                                        fColor: AppColors.hintextColor,
                                        fFamily: "poppinsbold",
                                        underText: TextDecoration.underline,
                                        fSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            wSpacer(mWidth: media.size.width * .1),
                            // Column(
                            //   children: [
                            //     CustomText(
                            //       fText: "continue with",
                            //       fColor: AppColors.hintextColor,
                            //       fFamily: "poppinsbold",
                            //     ),
                            //     hSpacer(),
                            //     // Row(
                            //     //   mainAxisAlignment: MainAxisAlignment.center,
                            //     //   children: [
                            //     //     Image.network(
                            //     //       "https://ww1.freelogovectors.net/wp-content/uploads/2023/03/facebook-logo-new-2019-freelogovectors.net_.png?lossy=1&ssl=1",
                            //     //       scale: 12,
                            //     //     ),
                            //     //     wSpacer(mWidth: media.size.width*.056),
                            //     //     Image.network(
                            //     //       "https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png",
                            //     //       scale: 9,
                            //     //     ),
                            //     //     wSpacer(mWidth: media.size.width*.056),
                            //     //     Image.network(
                            //     //       "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Logo_of_Twitter.svg/512px-Logo_of_Twitter.svg.png?20220821125553",
                            //     //       scale: 12,
                            //     //     ),
                            //     //   ],
                            //     // ),
                            //
                            //
                            //   ],
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

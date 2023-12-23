import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:my_art/customs/custom_Elevated_Button.dart';
import 'package:my_art/customs/custom_container.dart';
import 'package:my_art/customs/custom_text.dart';
import 'package:my_art/customs/custom_textfield.dart';
import 'package:my_art/screens/home_screen.dart';
import 'package:my_art/screens/onboading/forget_password.dart';
import 'package:my_art/screens/onboading/login_screen.dart';
import 'package:my_art/screens/onboading/signup_screen.dart';
import 'package:my_art/ui_helper.dart';

class OtpScreen extends StatefulWidget {
  String mVId;
  OtpScreen({required this.mVId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var auth = FirebaseAuth.instance;
  var orientation;
  var portraitKey = GlobalKey<FormState>();
  var landscapeKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  var mVerificationId = "";

  var otpNo1Controller = TextEditingController();
  var otpNo2Controller = TextEditingController();
  var otpNo3Controller = TextEditingController();
  var otpNo4Controller = TextEditingController();
  var otpNo5Controller = TextEditingController();
  var otpNo6Controller = TextEditingController();
@override
  void initState() {

    super.initState();
    mVerificationId=widget.mVId;
  }
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
                              fText: "Verify Phone",
                              fSize: 30,
                              fFamily: "poppinsbold",
                              fColor: AppColors.whiteColor),
                          hSpacer(mHeight: media.size.height * .03),
                          Column(
                            children: [
                              CustomText(
                                  fText: "Code is sent to",
                                  fSize: 20,
                                  fFamily: "poppinsbold",
                                  fColor: AppColors.whiteColor),
                              CustomText(
                                  fText: "+91 7015902389",
                                  fSize: 25,
                                  fFamily: "poppinsbold",
                                  fColor: AppColors.whiteColor),
                            ],
                          ),
                          hSpacer(mHeight: media.size.height * .05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              otpTextField(otpNo1Controller, true),
                              otpTextField(otpNo2Controller, false),
                              otpTextField(otpNo3Controller, false),
                              otpTextField(otpNo4Controller, false),
                              otpTextField(otpNo5Controller, false),
                              otpTextField(otpNo6Controller, false),
                            ],
                          ),
                          hSpacer(),
                          // SizedBox(
                          //     height: media.size.height * .056,
                          //     // width: media.size.width * .55,
                          //     child:  OtpTextField(
                          //       numberOfFields: 4,
                          //       borderColor: Color(0xFF512DA8),
                          //       //set to true to show as box or false to show as dash
                          //       showFieldAsBox: true,
                          //       //runs when a code is typed in
                          //       onCodeChanged: (String code) {
                          //         //handle validation or checks here
                          //       },
                          //       //runs when every textfield is filled
                          //       onSubmit: (String verificationCode){
                          //         showDialog(
                          //             context: context,
                          //             builder: (context){
                          //               return AlertDialog(
                          //                 title: Text("Verification Code"),
                          //                 content: Text('Code entered is $verificationCode'),
                          //               );
                          //             }
                          //         );
                          //       }, // end onSubmit
                          //     ),
                          // ),

                          hSpacer(mHeight: media.size.height * .04),

                          CustomText(
                              fText: "Get via Call",
                              fSize: 20,
                              fFamily: "poppinsbold",
                              fColor: AppColors.whiteColor),
                          hSpacer(mHeight: media.size.height * .04),

                          CustomText(
                              fText: "Resend-otp",
                              fSize: 20,
                              fFamily: "poppinsbold",
                              fColor: AppColors.whiteColor),

                          hSpacer(mHeight: media.size.height * .13),
                          SizedBox(
                            height: media.size.height * .07,
                            width: media.size.width * .75,
                            child: CustomElevatedButton(
                              onTap: () async {
                                if (portraitKey.currentState!.validate()) {
                                  var otp =
                                      "${otpNo1Controller.text.toString()}${otpNo2Controller.text.toString()}${otpNo3Controller.text.toString()}${otpNo4Controller.text.toString()}${otpNo5Controller.text.toString()}${otpNo6Controller.text.toString()}";

                                  if (mVerificationId != "") {
                                    var credential =
                                        PhoneAuthProvider.credential(
                                            verificationId: mVerificationId,
                                            smsCode: otp);

                                    auth.signInWithCredential(credential).then(
                                        (value) => print(
                                            "Auto Sign-in Completed!!:${value.user!.uid}"));
                                  }

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ));
                                }
                              },
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
                                        fText: "Log in",
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

  Widget otpTextField(mController, mAutoFocus) {
    return SizedBox(
      height: 50,
      width: 40,
      child: TextField(
        controller: mController,
        maxLines: 1,
        minLines: 1,
        maxLength: 1,
        autofocus: mAutoFocus,
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
          ;
        },
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(21),
          ),
        ),
      ),
    );
  }
}

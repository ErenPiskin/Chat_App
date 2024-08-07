import 'package:chat_app_staj/colors.dart';
import 'package:chat_app_staj/common/widgets/custom_button.dart';
import 'package:chat_app_staj/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context){
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xff4a86f7),
              Color(0xff457ded),
              Color(0xff3f74e3),
              Color(0xff3a6bd9),
              Color(0xff3562cf),
              Color(0xff2f59c5),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 90),
                const Text(
                  "Welcome to ChatBox",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                  ),
                ),
                SizedBox(height: size.height/25),
                Image.asset("assets/Texting.png"),
                SizedBox(height: size.height/25),
                const Padding(
                  padding:  EdgeInsets.all(15.0),
                  child:  Text('Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service.',
                  style: TextStyle(
                    color: whiteColor2,
                  ),
                  textAlign: TextAlign.center,),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: size.width*0.75,
                  child: CustomButton(text: "AGREE AND CONTINUE",
                      buttonColor: whiteColor,
                      textColor: blackColor,
                      onPressed: () => navigateToLoginScreen(context)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

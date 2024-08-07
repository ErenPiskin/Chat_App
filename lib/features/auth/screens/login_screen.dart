import 'package:chat_app_staj/colors.dart';
import 'package:chat_app_staj/common/utils/utils.dart';
import 'package:chat_app_staj/common/widgets/custom_button.dart';
import 'package:chat_app_staj/features/auth/controller/auth_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = "/login-screen";
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();

}
class _LoginScreenState extends ConsumerState<LoginScreen> {
final phoneController = TextEditingController();
Country? country;
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry (){
    showCountryPicker(context: context, onSelect: (Country _country){

      setState(() {
        country = _country;
      });
    });
}

void sendPhoneNumber(){
    String phoneNumber = phoneController.text.trim();
    if(country!=null && phoneNumber.isNotEmpty){
      ref.read(authControllerProvider).signInWithPhone(context, "+${country!.phoneCode}$phoneNumber");
          //Provider red -> Interact provider with provider
          // Widget ref -> makes wdget interact with provider
    }else{
      showSnackBar(context: context, content: "Fill out all the fields");
    }
}
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter your phone number"),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("We will need to verify your phone number."),
              const SizedBox(height: 10,),
              TextButton(onPressed: pickCountry, child:const  Text("Pick Country",style: TextStyle(
                color: messageColor
              ),)),
              const SizedBox(height: 10,),
              Row(
                children: [
                  if(
                  country != null)
                     Text("+${country!.phoneCode}"),
                  const SizedBox(width: 10),
                  SizedBox(width: size.width*0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                      hintText: "Phone Number",
                    ),
                  ),),
        
                ],
              ),
              SizedBox(height:  size.height*0.6),
              SizedBox(
                width: 90,
                child: CustomButton(
                    text: "Next",
                    textColor: whiteColor,
                    buttonColor: ButtonColor3,
                    onPressed: sendPhoneNumber
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

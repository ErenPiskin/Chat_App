import 'package:chat_app_staj/colors.dart';
import 'package:chat_app_staj/common/widgets/error.dart';
import 'package:chat_app_staj/common/widgets/loader.dart';
import 'package:chat_app_staj/features/auth/controller/auth_controller.dart';
import 'package:chat_app_staj/features/landing/screens/landing_screen.dart';
import 'package:chat_app_staj/firebase_options.dart';
import 'package:chat_app_staj/router.dart';
import 'package:chat_app_staj/screens/mobile_layout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const ProviderScope(
    child:  MyApp(),
  ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return MaterialApp(
      title: 'Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor2,
        appBarTheme: const AppBarTheme(
          color: appBarColor
        )

      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(data: (user) {
        if(user== null){
          return const LandingScreen();
        }
        return const MobileLayoutScreen();
      }, error: (err,trace) {
        return ErrorScreen(
          error: err.toString(),
        );
      }, loading: () => const Loader()
      ),
    );
  }
}


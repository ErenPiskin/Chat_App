import 'package:chat_app_staj/colors.dart';
import 'package:chat_app_staj/features/auth/controller/auth_controller.dart';
import 'package:chat_app_staj/features/select_contacts/screens/select_contacts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/chat/widgets/contacts_list.dart';

class MobileLayoutScreen extends ConsumerStatefulWidget {
  const MobileLayoutScreen({super.key});

  @override
  ConsumerState<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends ConsumerState<MobileLayoutScreen> with WidgetsBindingObserver{

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:
        ref.read(authControllerProvider).setUserState(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
        ref.read(authControllerProvider).setUserState(false);
        break;


    }
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: appBarColor,
            centerTitle: false,
            title: const Text(
              "ChatBox",
              style: TextStyle(
                fontFamily: "Inter",
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            actions: [
              IconButton(onPressed: (){

              }, icon: const Icon(Icons.search,color: Colors.grey,)
              ),
              IconButton(onPressed: (){

              }, icon: const Icon(Icons.more_vert,color: Colors.grey,)
              ),
            ],
            bottom: const TabBar(
                indicatorColor: ButtonColor3,
                indicatorWeight: 4,
                labelColor: ButtonColor3,
                unselectedLabelColor: Colors.grey,
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                tabs: [
                  Tab(
                    text: "Chats",

                  ),
                  Tab(
                    text: "Calls",
                  )
                ]),
          ),
          body: const ContactsList(),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              Navigator.pushNamed(context, SelectContactsScreen.routeName);
            },
            backgroundColor: ButtonColor3,
            child: const Icon(Icons.comment,color: Colors.white,),
          ),

        )
    );
  }
}

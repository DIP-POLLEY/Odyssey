import 'package:farm_ai_agent/screens/Homescreen2.dart';
import 'package:farm_ai_agent/screens/LiveChatScreen.dart';
import 'package:farm_ai_agent/screens/homescreen.dart';
import 'package:farm_ai_agent/screens/introform.dart';
import 'package:farm_ai_agent/screens/loginscreen.dart';
import 'package:farm_ai_agent/screens/otpscreen.dart';
import 'package:farm_ai_agent/screens/sfchatbot.dart';
import 'package:farm_ai_agent/screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Splashscreen.id,
      routes: {
        Splashscreen.id : (context) => const Splashscreen(),
        Loginscreen.id : (context) => const Loginscreen(),
        Otpscreen.id: (context) => const Otpscreen(),
        Introform.id: (context) => const Introform(),
        Homescreen.id: (context) => const Homescreen(),
        LiveChatPage.id: (context)=> const LiveChatPage(),
        HomeScreen2.id: (context)=> const HomeScreen2(),
        SalesforceChatWidget.id: (context) => const SalesforceChatWidget()

      },
    );
  }
}

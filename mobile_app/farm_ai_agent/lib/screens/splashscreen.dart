

import 'package:farm_ai_agent/screens/homescreen.dart';
import 'package:farm_ai_agent/screens/loginscreen.dart';
import 'package:farm_ai_agent/utilities/storeLocalDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utilities/constants.dart';
import '../utilities/sflogin.dart';

class Splashscreen extends StatefulWidget {
  static const String id = 'splashscreen';
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  void checklogin() async
  {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mob = prefs.getString("phone").toString();
    if(prefs.getString("phone")!=null)
      // ignore: duplicate_ignore
        {
      setState(() { kPhone = mob; });

      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, Homescreen.id);
      print("Loging   directly");
    }
    else
    {
      Navigator.pushReplacementNamed(context, Loginscreen.id);
    }
  }
  Future<void> checkSFConnection()
  async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String logtime = prefs.getString("logintime").toString();
    //print(logtime.);
    if(prefs.getString("logintime") == null)
      {
        SFLogin();
        Storedata('logintime', DateTime.now().toString());
      }
    else
      {
        DateTime lasttime = DateTime.parse(logtime);
        DateTime curntime = DateTime.now();
        if(curntime.difference(lasttime).inHours>1 )
        {
          //re-login
          SFLogin();
        }
      }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSFConnection();
    checklogin();

  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        // ignore: avoid_unnecessary_containers
        body: Center(
          child: CircularProgressIndicator(),
        )
      ),
    );
  }
}

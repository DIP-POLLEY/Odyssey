

import 'package:farm_ai_agent/screens/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utilities/storeLocalDetails.dart';


class HomeScreen2 extends StatefulWidget {
  static const String id = 'Homescreen2';
  const HomeScreen2({Key? key}) : super(key: key);

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {

  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://dip-polley.github.io/Odyssey/'));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child:SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome',
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            backgroundColor: Colors.green,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.call)
                ),
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen2()),
                      );
                    },
                    icon: Icon(Icons.home)
                ),
                IconButton(
                    onPressed: (){
                      clearData();
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Splashscreen()),
                      );
                    },
                    icon: Icon(Icons.logout)
                ),
              ],
            ),
          ),
          body:  Column(
            children: [
              Expanded(
                child: Container(
                  child: Text('test'),
                ),
              ),
              Expanded(
                child: Container(
                    child: WebViewWidget(controller: _controller)
                ),
              ),
            ],
          ),
        ),
      )

    );
  }
}

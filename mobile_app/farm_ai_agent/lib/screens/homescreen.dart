


import 'package:farm_ai_agent/screens/LiveChatScreen.dart';
import 'package:farm_ai_agent/screens/loginscreen.dart';
import 'package:farm_ai_agent/screens/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utilities/storeLocalDetails.dart';

class Homescreen extends StatefulWidget {
  static const String id = 'homescreen';
  const Homescreen({Key? key}) : super(key: key);


  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  late final WebViewController _controller;
  String  name='';
  String usertype='';

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = WebViewController()
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..loadRequest(Uri.parse('https://dip-polley.github.io/Odyssey/'));
  // }
  Future<void> updatename() async {
    String nam = await readData('Name');
    setState(() {
      name = nam;
    });
  }
  Future<void> updateusertype() async {
    String ut = await readData('Name');
    setState(() {
      usertype = ut;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatename();
    updateusertype();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome, $name',
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
                        MaterialPageRoute(builder: (context) => Homescreen()),
                      );
                    },
                    icon: Icon(Icons.home)
                ),
                IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LiveChatPage()),
                      );
                    },
                    icon: Icon(Icons.chat)
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
          body: ListView(
            children: [
              //Container(child: WebViewWidget(controller: _controller)),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Card(
                  color: Colors.green,
                  child: Container(
                    //height: MediaQuery.of(context).size.height/6,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Job Type: Sowing',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            'No. of workers needed: 12',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                          Text(
                            'Amount /day: Rs.400',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                          Text(
                            'Location: Whitefield',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

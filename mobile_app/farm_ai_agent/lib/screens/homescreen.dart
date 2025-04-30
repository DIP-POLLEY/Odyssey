


import 'dart:async';

import 'package:farm_ai_agent/screens/JobApplicationScreen.dart';
import 'package:farm_ai_agent/screens/LiveChatScreen.dart';
import 'package:farm_ai_agent/screens/loginscreen.dart';
import 'package:farm_ai_agent/screens/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../models/JobApplications.dart';
import '../models/JobListings.dart';
import '../utilities/SFGetJobApplications.dart';
import '../utilities/SFGetJobListings.dart';
import '../utilities/storeLocalDetails.dart';
import '../widgets/JobCard.dart';

class Homescreen extends StatefulWidget {
  static const String id = 'homescreen';
  const Homescreen({Key? key}) : super(key: key);


  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  late final WebViewController _controller;
  late Future<List<JobListing>> _futureJobs;
  late Future<List<JobApplication>> _futureApplications;

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
    String ut = await readData('UserType');
    setState(() {
      usertype = ut;
    });
  }

  late Timer _timer;
  String _currentTime = '';


  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now().toLocal().toString();
      _futureJobs = getJobListings();
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updatename();
    updateusertype();

    _futureApplications = getJobApplications();
    _updateTime(); // Initial time display

    // Start timer to update every 20 seconds
    _timer = Timer.periodic(Duration(seconds: 20), (Timer t) {
      _updateTime(); // Trigger rebuild with new data
      print('check');
    });
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
                // usertype == 'Farmer'?IconButton(
                //     onPressed: (){
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(builder: (context) => JobApplicationsScreen()),
                //       );
                //     },
                //     icon: Icon(Icons.add_alert)
                // ):
                // SizedBox(
                //   width: 0,
                // ),
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
          body: FutureBuilder<List<JobListing>>(
            future: _futureJobs,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text("You have not created job listings. \nCreate a Job Listing from chat icon below."));
              }

              final jobs = snapshot.data!;
              return ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return JobCard(job: jobs[index]);
                },
              );
            },

          ),
        ),
      ),
    );
  }
}

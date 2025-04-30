import 'package:farm_ai_agent/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import '../models/JobApplications.dart';
import '../utilities/SFGetJobApplications.dart';
import '../utilities/storeLocalDetails.dart';
import '../widgets/JobApplications.dart';
import 'LiveChatScreen.dart';
import 'homescreen.dart';

class JobApplicationsScreen extends StatefulWidget {
  static const String id = 'JAscreen';
  @override
  _JobApplicationsScreenState createState() => _JobApplicationsScreenState();
}

class _JobApplicationsScreenState extends State<JobApplicationsScreen> {
  late Future<List<JobApplication>> _futureApplications;

  @override
  void initState() {
    super.initState();
    _futureApplications = getJobApplications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              "Job Applications",
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
      body: FutureBuilder<List<JobApplication>>(
        future: _futureApplications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No job applications available."));
          }

          final applications = snapshot.data!;
          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              return JobApplicationCard(application: applications[index]);
            },
          );
        },
      ),
    );
  }
}

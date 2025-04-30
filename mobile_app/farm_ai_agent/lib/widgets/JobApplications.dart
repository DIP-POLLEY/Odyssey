import 'package:flutter/material.dart';
import '../models/JobApplications.dart';

class JobApplicationCard extends StatelessWidget {
  final JobApplication application;

  JobApplicationCard({required this.application});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(application.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Job ID: ${application.jobListingId}"),
            Text("Contact: ${application.contactNumber}"),
            Text("Status: ${application.status}"),
            if (application.appliedDate != null)
              Text("Applied On: ${application.appliedDate}"),
          ],
        ),
      ),
    );
  }
}

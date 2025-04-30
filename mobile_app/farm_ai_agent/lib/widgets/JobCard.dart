
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/JobListings.dart';

class JobCard extends StatelessWidget {
  final JobListing job;

  JobCard({required this.job});

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
            Text(job.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Farmer: ${job.farmerName} (${job.contactNumber})"),
            Text("Location: ${job.location}"),
            Text("Pay Rate: ${job.payRate}"),
            Text("Skill Required: ${job.skill}"),
            Text("Status: ${job.status}"),
            Text("Workers Needed: ${job.workersRequired.toInt()}"),
            Text("Farm: ${job.farmName}"),
            if (job.startDate != null) Text("Start Date: ${job.startDate}"),
            if (job.endDate != null) Text("End Date: ${job.endDate}"),
          ],
        ),
      ),
    );
  }
}

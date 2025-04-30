import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farm_ai_agent/utilities/storeLocalDetails.dart';
import '../models/JobApplications.dart';

Future<List<JobApplication>> getJobApplications() async {
  var url = Uri.parse(
      'https://orgfarm-069efd2b82.my.salesforce.com/services/data/v62.0/query/?q=SELECT%20Name%2C%20Job_Listing__c%2C%20Applied_Date__c%2C%20Labour__r.Contact_Number__c%2C%20Status__c%2C%20Labour_Contact_Number__c%2C%20Id%20FROM%20Job_Application__c%20where%20status__c%3D%27Applied%27');

  String bearer = await readData('Accesstoken');

  var headers = {
    'Authorization': 'Bearer $bearer',
    'Content-Type': 'application/json'
  };

  var response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final Map<String, dynamic> decoded = json.decode(response.body);
    final List<JobApplication> applications = (decoded['records'] as List)
        .map((item) => JobApplication.fromJson(item))
        .toList();
    return applications;
  } else {
    print(response.body);
    throw Exception('Failed to fetch job applications: ${response.statusCode}');
  }
}




import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:farm_ai_agent/utilities/storeLocalDetails.dart';

import '../models/JobListings.dart';

Future<List<JobListing>> getJobListings()
async {
  String phone = await readData('phone');
  String query = '''
SELECT Name, Farmer_Name__c, Farmer_Contact_Number__c, Start_Date__c, End_Date__c,
Location__c, Pay_Rate__c, Skill__c, Status__c, Number_of_workers_required__c,
Farm__c, Farm_Name__c 
FROM Job_Listing__c 
WHERE Farmer_Contact_Number__c = '$phone' 
ORDER BY CreatedDate DESC
''';
  String encodedQuery = Uri.encodeComponent(query);


  var url = Uri.parse('https://orgfarm-069efd2b82.my.salesforce.com/services/data/v62.0/query/?q=$encodedQuery');
  String bearer = await readData('Accesstoken');

  print(bearer);
  var headers = {
    'Authorization': 'Bearer $bearer',
    'Content-Type': 'application/json'
  };

  var response = await http.get(url, headers: headers);

  // Handle the response
  if (response.statusCode == 200) {
    final Map<String, dynamic> decoded = json.decode(response.body);
    final List<JobListing> jobs = (decoded['records'] as List)
        .map((item) => JobListing.fromJson(item))
        .toList();
    return jobs;
  } else {
    throw Exception('Failed to fetch job listings: ${response.statusCode}');
  }

}
import 'package:farm_ai_agent/utilities/storeLocalDetails.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void SendRegistrationdata(String sobject, var data) async {
  // Set the URL and headers
  var url = Uri.parse('https://orgfarm-069efd2b82.my.salesforce.com/services/data/v62.0/sobjects/$sobject/');
  String bearer = await readData('Accesstoken');
  var headers = {
    'Authorization': 'Bearer $bearer',
    'Content-Type': 'application/json'
  };

  // Data to send (replace with actual data)
  // var data = json.encode({
  //   // You can add your contact data here, for example:
  //   'FirstName': 'John',
  //   'LastName': 'Doe',
  //   'Email': 'john.doe@example.com',
  // });

  // Send the request
  var response = await http.post(url, headers: headers, body: data);

  // Handle the response
  if (response.statusCode == 201 || response.statusCode == 200) {
    print(response.body);
  } else {
    print('Failed to create contact. Status code: ${response.statusCode}');
  }
}

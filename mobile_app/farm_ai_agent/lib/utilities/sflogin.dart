import 'dart:convert';

import 'package:farm_ai_agent/utilities/storeLocalDetails.dart';
import 'package:http/http.dart' as http;



void SFLogin() async {
  // Define the URL
  var url = Uri.parse('https://orgfarm-069efd2b82.my.salesforce.com/services/oauth2/token');

  // Define the headers
  Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };
//'https://orgfarm-069efd2b82.my.salesforce.com/services/oauth2/token?grant_type=password&
// client_id=3MVG9VMBZCsTL9hke9ZvJxbbFChwo8_QW83XNFrJo0pQXYPpgZ4wJ2oeKbgx58j9bcUzwB8EzE9nt8LwSfN6g&
// client_secret=8D2CCBD5B510E4FE0D1260CA4418DE0751577ECF5341715FE982191150746957&username=madhusudhan007%40gmail.com&
// password=Farm%401234'
  // Define the body
  String body = 'grant_type=password&'
      'client_id=3MVG9VMBZCsTL9hke9ZvJxbbFChwo8_QW83XNFrJo0pQXYPpgZ4wJ2oeKbgx58j9bcUzwB8EzE9nt8LwSfN6g&'

      'client_secret=8D2CCBD5B510E4FE0D1260CA4418DE0751577ECF5341715FE982191150746957&'
      'username=madhusudhan007%40gmail.com&'
      'password=Farm%401234';

  try {
    // Send the POST request
    var response = await http.post(url, headers: headers, body: body);

    // Check for a successful response
    if (response.statusCode == 200) {
      print('Request successful: ${response.body}');
      storeAccessToken(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void storeAccessToken(String jsonResponse){
  Map<String, dynamic> jsonMap = jsonDecode(jsonResponse);

  // Access and print the access token
  String accessToken = jsonMap['access_token'];
  print('Access Token: $accessToken');
  Storedata('Accesstoken', accessToken);
}
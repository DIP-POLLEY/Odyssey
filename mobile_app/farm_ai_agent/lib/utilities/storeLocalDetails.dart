

import 'package:shared_preferences/shared_preferences.dart';

Future<void> Storedata(String key, String value)
async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}


Future<void> clearData()
async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.clear();
}

Future<String> readData(String key)
async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 // print('Testing ${prefs.getString(key).toString()}');
  return (prefs.getString(key).toString());
}

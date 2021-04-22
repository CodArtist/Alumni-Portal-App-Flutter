import 'dart:convert';
import 'package:http/http.dart' as http;
import 'User.dart';

class Services {
  static const String url = 'https://alumniportal2001.000webhostapp.com/GetEvents.php';
  static var userList=[];
  static Future<List<User>> getUsers() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body.toString());
        List<User> list = parseUsers(response.body);
        userList=jsonDecode(response.body)[1];
        return list;
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static List<User> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody)[0].cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
}
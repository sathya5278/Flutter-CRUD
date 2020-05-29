import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crud/user_type.dart';

class Services {
  static const SERVER = 'http://10.0.2.2/crud/user_actions.php';
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_USER_ACTION = 'ADD_USER';
  static const _UPDATE_USER_ACTION = 'UPDATE_USER';
  static const _DELETE_USER_ACTION = 'DELETE_USER';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = Map<String, dynamic>();
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(SERVER, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return json.decode(response.body);
      } else {
        return "statusCode error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<List<User>> getUsers() async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(SERVER, body: map);
      print('getUsers Response: ${response.body}');
      if (response.statusCode == 200) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      print(e);
      return List<User>();
    }
  }

  static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> addUser(String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _ADD_USER_ACTION;
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      final response = await http.post(SERVER, body: map);
      print('addUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return json.decode(response.body);
      } else {
        return "statusCode error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateUser(
      int id, String firstName, String lastName) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _UPDATE_USER_ACTION;
      map['id'] = id.toString();
      map['first_name'] = firstName;
      map['last_name'] = lastName;
      print(map);
      final response = await http.post(SERVER, body: map);
      print('updateUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return json.decode(response.body);
      } else {
        return "statusCode error";
      }
    } catch (e) {
      return e.toString();
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteUser(int id) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _DELETE_USER_ACTION;
      map['id'] = id.toString();
      final response = await http.post(SERVER, body: map);
      print('deleteUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return json.decode(response.body);
      } else {
        return "statusCode error";
      }
    } catch (e) {
      return e
          .toString(); // returning just an "error" string to keep this simple...
    }
  }
}

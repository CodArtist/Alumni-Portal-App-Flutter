import 'dart:convert';
import 'package:http/http.dart' as http;

class Services {
  static const String url = 'https://alumniportal2001.000webhostapp.com/GetAll.php';


  static getAll() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        

        var tableList = jsonDecode(response.body);
         var table_events=tableList[0];
         var table_users=tableList[1];
         var table_news=tableList[2];
         var table_internships=tableList[3];

         print("****************************events*****************************************");

         print(table_events.length);
                  print("****************************users*****************************************");

         print(table_users.length);
         print("****************************news*****************************************");

         print(table_news.length);
                  print("****************************internships*****************************************");

         print(table_internships.length);
         

         var arr=[];
         arr.add(table_events);
         arr.add(table_users);
         arr.add(table_news);
         arr.add(table_internships);
        //  print(arr);
         
         return arr;
        
        // for(var i =0;i<tableList.length;i++)
        // {
           
        // }


        // List<User> list = parseUsers(response.body);
        // return list;
      
      
      
      
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

//   static List<User> parseUsers(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<User>((json) => User.fromJson(json)).toList();
//   }
}
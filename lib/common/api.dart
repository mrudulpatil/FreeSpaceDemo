import 'dart:convert';

import 'package:free_space_demo/model/Aminities.dart';
import 'package:free_space_demo/model/Occupancy.dart';
import 'package:free_space_demo/model/Result.dart';
import 'package:http/http.dart' as http;

class API {
  Result dataObj;
  List<Aminities> aminitiesList = [];
  List<Occupancy> occupancyList = [];

  Future<void> getDataFromAPI() async {
    String url =
        "https://getfreespacerecords.free.beeceptor.com/"; //"https://getrecordlist.free.beeceptor.com/";
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['StatusCode'] == "200") {
      String StatusCode = jsonData['StatusCode'];
      String Name = jsonData['Name'];
      String ProfileIamge = jsonData['ProfileIamge'];
      String Notification = jsonData['Notification'];
      String Address = jsonData['Address'];

      jsonData["Aminities"].forEach((element) {
        Aminities article = Aminities(
          title: element['Title'],
          icon: element['Icon'],
        );
        aminitiesList.add(article);
      });
      jsonData["Occupancy"].forEach((element) {
        Occupancy occupancyObj = Occupancy(
            Today: element['Today'],
            Time: element['Time'],
            Previous: element['Previous']);
        occupancyList.add(occupancyObj);
      });
      dataObj = new Result(StatusCode, Name, ProfileIamge, Notification,
          Address, aminitiesList, occupancyList);
    }
  }
}

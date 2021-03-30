import 'package:free_space_demo/model/Aminities.dart';
import 'package:free_space_demo/model/Occupancy.dart';

class Result {
  String StatusCode;
  String Name;
  String ProfileIamge;
  String Notification;
  String Address;

  List<Aminities> aminitiesList = [];
  List<Occupancy> occupancyList = [];

  Result(this.StatusCode, this.Name, this.ProfileIamge, this.Notification,
      this.Address, this.aminitiesList, this.occupancyList);
}

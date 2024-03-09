import 'dart:convert';
import 'dart:io';
import 'package:insta_json_analyzer/app/utils/const.dart';
import 'package:insta_json_analyzer/app/utils/path.dart';
import 'package:insta_json_analyzer/data/local/DAO/profile_dao.dart';
import 'package:insta_json_analyzer/data/model/local/profile.dart';

class ProfileDaoImp extends ProfileDao {
  @override
  Future<List<ProfileModel>> getFollowersList() async {
    String path = await getDownloadDirectoryPath();
    path += "/$directoryJsonName/followers_1.json";
    List<ProfileModel> toRet = [];
    try {
      File file = File(path);
      String data = await file.readAsString();

      List<dynamic> jsonArray = json.decode(data);

      for (var value in jsonArray) {
        if (value is Map<String, dynamic>) {
          List<dynamic> stringListData = value["string_list_data"];

          for (var stringDataValue in stringListData) {
            if (stringDataValue is Map<String, dynamic>) {
              String href = stringDataValue["href"];
              String value = stringDataValue["value"];
              int timestamp = stringDataValue["timestamp"];

              ProfileModel newProfileItem = ProfileModel(
                name: value,
                href: href,
                date: DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
              );

              toRet.add(newProfileItem);
            }
          }
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    return toRet;
  }

  @override
  Future<List<ProfileModel>> getFollowingList() async {
    String path = await getDownloadDirectoryPath();
    path += "/$directoryJsonName/following.json";
    List<ProfileModel> toRet = [];
    try {
      File file = File(path);
      String data = await file.readAsString();

      Map<String, dynamic> jsonDoc = json.decode(data);
      if (jsonDoc == null) {
        print("Error in json converter");
        return toRet;
      }

      List<dynamic> followingArray = jsonDoc["relationships_following"];
      for (var followingValue in followingArray) {
        Map<String, dynamic> followingObject = followingValue;
        List<dynamic> stringListData = followingObject["string_list_data"];
        for (var stringDataValue in stringListData) {
          Map<String, dynamic> stringDataObject = stringDataValue;
          String href = stringDataObject["href"];
          String value = stringDataObject["value"];
          int timestamp = stringDataObject["timestamp"];

          ProfileModel newProfileItem = ProfileModel(
            name: value,
            href: href,
            date: DateTime.fromMillisecondsSinceEpoch(timestamp * 1000),
          );

          toRet.add(newProfileItem);
        }
      }
    } catch (e) {
      print("Error: $e");
    }

    return toRet;
  }
}

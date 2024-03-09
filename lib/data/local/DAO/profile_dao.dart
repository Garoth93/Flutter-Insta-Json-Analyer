import 'package:insta_json_analyzer/data/model/local/profile.dart';

abstract class ProfileDao {
  Future<List<ProfileModel>> getFollowersList();

  Future<List<ProfileModel>> getFollowingList();
}

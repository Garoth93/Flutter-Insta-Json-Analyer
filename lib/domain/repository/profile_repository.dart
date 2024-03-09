import 'package:insta_json_analyzer/domain/entity/profile.dart';

abstract class ProfileRepository {
  Future<List<ProfileEntity>> getFollowersList();

  Future<List<ProfileEntity>> getFollowingList();
}

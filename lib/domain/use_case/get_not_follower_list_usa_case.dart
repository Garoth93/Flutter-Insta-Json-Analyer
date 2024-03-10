import 'package:insta_json_analyzer/app/di/injector.dart';
import 'package:insta_json_analyzer/domain/entity/profile.dart';
import 'package:insta_json_analyzer/domain/repository/profile_repository.dart';

class GetNotFollowerListUseCase {
  final ProfileRepository _profileRepository = injector<ProfileRepository>();

  Future<List<ProfileEntity>> getNotFollowerList() async {
    List<ProfileEntity> followingList =
        await _profileRepository.getFollowingList();

    List<ProfileEntity> followerList =
        await _profileRepository.getFollowersList();

    Set<String> namesFollower =
        Set.from(followerList.map((profile) => profile.name));

    List<ProfileEntity> data = [];

    for (var profile in followingList) {
      if (!namesFollower.contains(profile.name)) {
        data.add(profile);
      }
    }

    return data;
  }
}

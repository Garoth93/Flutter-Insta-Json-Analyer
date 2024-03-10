import 'package:insta_json_analyzer/app/di/injector.dart';
import 'package:insta_json_analyzer/domain/entity/profile.dart';
import 'package:insta_json_analyzer/domain/repository/profile_repository.dart';

class GetNotFollowingListUseCase {
  final ProfileRepository _profileRepository = injector<ProfileRepository>();

  Future<List<ProfileEntity>> getNotFollowingList() async {
    List<ProfileEntity> followingList =
        await _profileRepository.getFollowingList();

    List<ProfileEntity> followerList =
        await _profileRepository.getFollowersList();

    Set<String> namesFollowing =
        Set.from(followingList.map((profile) => profile.name));

    List<ProfileEntity> data = [];

    for (var profile in followerList) {
      if (!namesFollowing.contains(profile.name)) {
        data.add(profile);
      }
    }

    return data;
  }
}

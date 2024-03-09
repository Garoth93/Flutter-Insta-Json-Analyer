import 'package:insta_json_analyzer/data/local/DAO/profile_dao.dart';
import 'package:insta_json_analyzer/domain/entity/profile.dart';
import 'package:insta_json_analyzer/domain/repository/profile_repository.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileDao profileDao;

  ProfileRepositoryImp(this.profileDao);

  @override
  Future<List<ProfileEntity>> getFollowersList() async {
    return await profileDao.getFollowersList();
  }

  @override
  Future<List<ProfileEntity>> getFollowingList() async {
    return await profileDao.getFollowingList();
  }
}

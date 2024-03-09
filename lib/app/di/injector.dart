import 'package:get_it/get_it.dart';
import 'package:insta_json_analyzer/data/local/DAO/profile_dao.dart';
import 'package:insta_json_analyzer/data/local/profile_dao_imp.dart';
import 'package:insta_json_analyzer/data/repository/profile_repository.dart';
import 'package:insta_json_analyzer/domain/repository/profile_repository.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<ProfileDao>(ProfileDaoImp());

  injector
      .registerSingleton<ProfileRepository>(ProfileRepositoryImp(injector()));
}

import 'package:insta_json_analyzer/domain/entity/profile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel(
      {required String name, required String href, required DateTime date})
      : super(date: date, href: href, name: name);
}

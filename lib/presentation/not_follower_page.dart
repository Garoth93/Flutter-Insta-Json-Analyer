import 'package:flutter/material.dart';
import 'package:insta_json_analyzer/app/di/injector.dart';
import 'package:insta_json_analyzer/domain/entity/profile.dart';
import 'package:insta_json_analyzer/domain/repository/profile_repository.dart';

class NotFollowerPage extends StatefulWidget {
  const NotFollowerPage({super.key});

  @override
  State<StatefulWidget> createState() => NotFollowerPageState();
}

class NotFollowerPageState extends State<NotFollowerPage> {
  final ProfileRepository _profileRepository = injector<ProfileRepository>();
  bool _isLoading = false;

  late List<ProfileEntity> _data = [];
  late List<ProfileEntity> _filteredData = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
    });

    List<ProfileEntity> followingList =
        await _profileRepository.getFollowingList();

    List<ProfileEntity> followerList =
        await _profileRepository.getFollowersList();

    Set<String> namesFollower = Set.from(followerList.map((profile) => profile.name));

    List<ProfileEntity> data = [];

    for (var profile in followingList) {
      if (!namesFollower.contains(profile.name)) {
        data.add(profile);
      }
    }

    setState(() {
      _data = data;
      _filteredData = data;
      _isLoading = false;
    });
  }

  void _filterData(String query) {
    setState(() {
      _filteredData = _data
          .where((a) => (a.name.toLowerCase().contains(query.toLowerCase()) ||
              a.href.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  void _goBack() {
    Navigator.pop(context);
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _filteredData.length,
      itemBuilder: (context, index) {
        final item = _filteredData[index];
        return Card(
          child: Column(
            children: [
              ListTile(
                title: Text(item.name),
                subtitle: Text(
                    'Href: ${item.href} \nData ora: ${item.date.toString()}'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not follower'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _filterData,
                    decoration: const InputDecoration(
                      labelText: 'Ricerca',
                      hintText: 'Ricerca...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: _listView(),
                ),
        ],
      ),
    );
  }
}

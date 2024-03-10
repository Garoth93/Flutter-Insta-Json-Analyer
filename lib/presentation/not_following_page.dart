import 'package:flutter/material.dart';
import 'package:insta_json_analyzer/domain/entity/profile.dart';
import 'package:insta_json_analyzer/domain/use_case/get_not_following_list_usa_case.dart';
import 'package:insta_json_analyzer/domain/use_case/launch_url_use_case.dart';

class NotFollowingPage extends StatefulWidget {
  const NotFollowingPage({super.key});

  @override
  State<StatefulWidget> createState() => NotFollowingPageState();
}

class NotFollowingPageState extends State<NotFollowingPage> {
  GetNotFollowingListUseCase _getNotFollowingListUseCase =
      GetNotFollowingListUseCase();

  LaunchUrlUseCase _launchUrlUseCase = LaunchUrlUseCase();

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

    List<ProfileEntity> notFollowerList =
        await _getNotFollowingListUseCase.getNotFollowingList();
    setState(() {
      _data = notFollowerList;
      _filteredData = notFollowerList;
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
                onTap: () async {
                  await _launchUrlUseCase.launchInBrowser(item.href);
                },
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
        title: const Text('Not following'),
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

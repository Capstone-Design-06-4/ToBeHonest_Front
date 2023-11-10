import 'package:flutter/material.dart';

import '../models/friend.dart';

import '../services/friend_service.dart';

import '../widgets/friend_list_widget.dart';
import '../widgets/friend_search_widget.dart';
import '../widgets/friend_add_widget.dart';
import '../widgets/friend_categorized_widget.dart';

// 친구 페이지를 표시하기 위한 StatefulWidget 입니다.
// 사용자가 친구 목록을 볼 수 있고, 검색할 수 있는 기능을 제공합니다.
class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

// FriendPage의 상태를 관리하는 클래스입니다.
class _FriendPageState extends State<FriendPage> {
  // 검색 필드의 텍스트를 관리하기 위한 컨트롤러입니다.
  TextEditingController _searchController = TextEditingController();

  // 친구 목록을 비동기적으로 가져올 Future입니다.
  Future<List<Friend>>? _friendsFuture;

  // 모든 친구 목록을 저장하는 리스트입니다.
  List<Friend> _allFriends = [];

  // 필터링된 친구 목록을 저장하는 리스트입니다.
  List<Friend> _filteredFriends = [];

  // 위젯이 생성될 때 호출됩니다.
  @override
  void initState() {
    super.initState();
    // 검색 필드에 입력이 있을 때마다 _onSearchChanged를 호출하기 위한 리스너를 추가합니다.
    _searchController.addListener(_onSearchChanged);

    // 모든 친구 목록을 가져오는 함수를 호출하고 결과를 _friendsFuture에 저장합니다.
    _friendsFuture = getAllFriends();
  }

  // 검색 필드에 입력이 있을 때 호출되는 함수입니다.
  void _onSearchChanged() {
    String searchQuery = _searchController.text.toLowerCase();
    setState(() {
      // 검색 쿼리에 맞게 친구 목록을 필터링합니다.
      _filteredFriends = _allFriends.where((friend) {
        return friend.name.toLowerCase().contains(searchQuery);
      }).toList();
    });
  }

  // 위젯의 메인 빌드 함수입니다.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Friend>>(
      future: _friendsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터를 기다리는 동안 로딩 인디케이터를 표시합니다.
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // 데이터 로드 중 오류가 발생한 경우 오류 메시지를 표시합니다.
          return Center(child: Text('오류가 발생했습니다: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // 데이터가 없는 경우 해당 메시지를 표시합니다.
          return Center(child: Text('친구가 없습니다.'));
        } else {
          // 데이터가 로드된 경우, 전체 친구 목록과 필터링된 친구 목록을 업데이트합니다.
          _allFriends = snapshot.data!;
          _filteredFriends = _searchController.text.isEmpty ? _allFriends : _filteredFriends;

          // 친구 목록을 표시하는 ListView를 구성합니다.
          return ListView(
            children: <Widget>[
              // 검색 위젯을 추가합니다.
              SearchFriendWidget(
                controller: _searchController,
                onSearch: (query) {
                  // 검색 쿼리가 변경될 때 호출됩니다.
                  // 현재는 _onSearchChanged에서 처리하고 있으므로 여기서는 빈 함수입니다.
                },
              ),
              // 친구 추가 타일을 추가합니다.
              const AddFriendTile(),
              // 친구 목록의 카테고리 타이틀을 추가합니다.
              const FriendCategorized(title: '친구 목록'),
              // 목록 사이의 간격을 추가합니다.
              SizedBox(height: 10),
              // 필터링된 친구 목록을 표시하는 위젯들을 추가합니다.
              ..._filteredFriends.map((friend) => buildFriendContainer(context, friend)).toList(),
            ],
          );
        }
      },
    );
  }

  // 위젯이 파괴될 때 호출됩니다.
  @override
  void dispose() {
    // 리스너를 제거하고 컨트롤러를 해제합니다.
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
}
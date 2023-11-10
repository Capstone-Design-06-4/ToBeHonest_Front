import 'package:flutter/material.dart';

/// SearchFriendWidget는 사용자가 친구를 검색할 수 있는 입력 필드를 제공합니다.
///
/// [controller]는 이 위젯의 [TextField]를 위한 [TextEditingController] 입니다.
/// [onSearch]는 검색 필드에 입력이 있을 때마다 호출될 콜백 함수입니다.
class SearchFriendWidget extends StatelessWidget {
  final TextEditingController controller; // 텍스트 필드와 바인딩 될 컨트롤러입니다.
  final ValueChanged<String> onSearch; // 검색 쿼리가 변경될 때 호출될 콜백 함수입니다.

  /// 생성자는 [controller]와 [onSearch] 콜백을 필요로 합니다.
  /// 이 두 매개변수는 필수이므로 `required`로 표시되어 있습니다.
  const SearchFriendWidget({
    Key? key,
    required this.controller,
    required this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Padding 위젯은 입력 필드 주변에 공간을 추가하여 UI를 더 깔끔하게 만듭니다.
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextField(
        controller: controller, // 입력된 텍스트를 관리하기 위해 컨트롤러를 사용합니다.
        onChanged: onSearch, // 텍스트 필드에 입력이 있을 때마다 onSearch 콜백을 호출합니다.
        style: const TextStyle(fontSize: 14), // 텍스트 필드의 글자 크기를 설정합니다.
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10), // 입력 필드 내부의 패딩을 설정합니다.
          prefixIcon: const Icon(Icons.search, size: 30), // 검색 아이콘을 추가합니다.
          hintText: '친구 이름 검색하기', // 사용자에게 힌트를 제공하는 텍스트를 설정합니다.
          filled: true, // 텍스트 필드의 배경을 채웁니다.
          fillColor: Colors.white, // 배경색을 흰색으로 설정합니다.
          border: OutlineInputBorder( // 텍스트 필드의 테두리를 설정합니다.
            borderRadius: BorderRadius.circular(30.0), // 테두리의 모서리를 둥글게 합니다.
            borderSide: BorderSide(color: Colors.grey, width: 1.0), // 테두리 색과 너비를 설정합니다.
          ),
          enabledBorder: OutlineInputBorder( // 활성화되지 않았을 때의 테두리 스타일을 설정합니다.
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder( // 포커스를 받았을 때의 테두리 스타일을 설정합니다.
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(color: Colors.grey, width: 2.0),
          ),
        ),
      ),
    );
  }
}

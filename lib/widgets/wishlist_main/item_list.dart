import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 더미 데이터로 아이템 목록을 생성합니다.
    // 각 아이템은 아이콘, 퍼센트, 제품 이름을 맵 형태로 가집니다.
    final List<Map<String, Object>> items = List.generate(
      18,
          (index) => {
        'icon': Icons.dashboard, // 예시 아이콘, 실제 앱에서 적절한 아이콘으로 변경해야 합니다.
        'percentage': '${(index * 5 + 10) % 100}%', // 퍼센테이지 값을 문자열로 저장합니다.
        'itemName': '제품 ${index + 1}', // 제품 이름을 생성하여 저장합니다.

      },
    );

    // GridView.builder를 사용하여 아이템들을 그리드 형태로 나열합니다.
    return GridView.builder(
      shrinkWrap: true, // 그리드의 크기를 자식들의 크기에 맞춥니다.
      physics: NeverScrollableScrollPhysics(), // 스크롤이 되지 않도록 설정합니다.
      padding: const EdgeInsets.all(10.0), // 모든 방향으로 패딩을 추가합니다.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 한 줄에 나타낼 아이템의 개수를 2로 설정합니다.
        childAspectRatio: 0.8, // 아이템의 가로 세로 비율을 1:1로 설정합니다.
        crossAxisSpacing: 10, // 가로 방향 아이템 간의 간격을 설정합니다.
        mainAxisSpacing: 10, // 세로 방향 아이템 간의 간격을 설정합니다.
      ),
      itemCount: items.length, // 아이템의 총 개수를 지정합니다.
      itemBuilder: (ctx, index) => Card(
        elevation: 10, // 카드의 그림자 높이를 설정합니다.
        child: Padding(
          padding: const EdgeInsets.all(10.0), // 카드 내부의 패딩을 설정합니다.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 세로축 기준으로 중앙 정렬합니다.
            children: [
              // 아이콘을 표시하는 컨테이너
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 처리합니다.
                  border: Border.all(color: Colors.grey.shade300, width: 1), // 테두리를 설정합니다.
                ),
                padding: EdgeInsets.all(8.0), // 아이콘 주변의 패딩을 추가합니다.
                child: Icon(
                  items[index]['icon'] as IconData, // 아이콘 데이터를 설정합니다.
                  size: 100, // 아이콘 크기를 설정합니다.
                ),
              ),
              SizedBox(height: 10), // 아이콘과 텍스트 사이의 공간을 추가합니다.
              // 제품 이름을 표시하는 텍스트 위젯
              Text(
                items[index]['itemName'] as String, // 제품 이름을 표시합니다.
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // 텍스트 스타일을 설정합니다.
              ),
              SizedBox(height: 10), // 제품 이름과 퍼센트 바 사이의 공간을 추가합니다.
              // 퍼센트 바를 구성하는 스택 위젯
              Stack(
                children: [
                  // 퍼센트 바의 배경 컨테이너
                  Container(
                    height: 20, // 컨테이너의 높이를 설정합니다.
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 처리합니다.
                      border: Border.all(color: Colors.grey.shade300, width: 1), // 테두리를 설정합니다.
                    ),
                  ),
                  // 퍼센트를 나타내는 색상이 채워지는 컨테이너
                  Container(
                    height: 20, // 컨테이너의 높이를 설정합니다.
                    width: (MediaQuery.of(ctx).size.width - 270) *
                        double.parse((items[index]['percentage'] as String).replaceRange(2, 3, '')) /
                        100, // 퍼센트 값에 따라 너비를 계산합니다.
                    decoration: BoxDecoration(
                      color: Colors.green, // 채워진 부분의 색상을 지정합니다.
                      borderRadius: BorderRadius.circular(10.0), // 모서리를 둥글게 처리합니다.
                    ),
                  ),
                  // 퍼센트 값을 표시하는 텍스트
                  Center(
                    child: Text(
                      items[index]['percentage'] as String, // 퍼센트 값을 표시합니다.
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // 텍스트 스타일을 설정합니다.
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

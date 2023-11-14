import 'package:flutter/material.dart';

class ProductGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, Object>> items = List.generate(
      18,
          (index) => {
        'icon': Icons.onetwothree,
        'percentage': '${(index * 5 + 10) % 100}%', // 예제로, 인덱스에 따라 다양한 백분율을 생성합니다.
      },
    );

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: items.length,
      itemBuilder: (ctx, index) => Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 아이콘
              Expanded(
                child: Icon(
                  items[index]['icon'] as IconData,
                  size: 80,
                ),
              ),
              SizedBox(height: 10),

              // 퍼센트 바 및 값
              Stack(
                children: [
                  Container(
                    height: 20, // 바의 높이를 20으로 변경
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 반지름도 줄임
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: (MediaQuery.of(ctx).size.width - 270) *
                        double.parse((items[index]['percentage'] as String).replaceRange(2, 3, '')) /
                        100,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                        topRight: double.parse((items[index]['percentage'] as String).replaceRange(2, 3, '')) < 100 ? Radius.circular(0) : Radius.circular(10.0),
                        bottomRight: double.parse((items[index]['percentage'] as String).replaceRange(2, 3, '')) < 100 ? Radius.circular(0) : Radius.circular(10.0),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      '${(double.parse((items[index]['percentage'] as String).replaceRange(2, 3, '')))}%',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

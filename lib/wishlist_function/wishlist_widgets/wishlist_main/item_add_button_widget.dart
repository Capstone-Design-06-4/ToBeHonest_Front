import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_add_view.dart';
import 'package:tobehonest/wishlist_function/wishlist_view/item_add_view_category.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget ItemAddBar(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 16, right: 16),
    child: Column(
      children: [
        GestureDetector(
          onTap: () {
            ModalUtils.showFriendModal(context);
          },
          child: Container(
            height: 70.0,
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              leading: CircleAvatar(
                backgroundColor: AppColor.swatchColor,
                child: Icon(Icons.favorite, color: Colors.white),
              ),
              title: Text('상품 추가하기'),
              subtitle: Text('위시리스트에 선물을 추가해요!'),
              trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
            ),
          ),
        ),
      ],
    ),
  );
}

class ModalUtils {
  static void showFriendModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 260, // 모달 높이 크기
            margin: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 100,
            ), // 모달 좌우하단 여백 크기
            decoration: BoxDecoration(
              color: Colors.white, // 모달 배경색
              borderRadius: BorderRadius.all(
                Radius.circular(20), // 모달 전체 라운딩 처리
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(height: 5,),
                Container(
                  height: 70.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                    leading: CircleAvatar(
                      backgroundColor: AppColor.swatchColor,
                      child: Icon(Icons.favorite, color: Colors.white),
                    ),
                    title: Text('상품 추가하기',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),),
                    subtitle: Text('위시리스트에 선물을 추가해요!'),
                    trailing: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.clear, // You can change this to any other icon
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewItemPage(),
                        ));
                  },
                  child: Container(
                    height: 70.0,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        leading: CircleAvatar(
                          backgroundColor: AppColor.swatchColor,
                          child: Icon(FontAwesomeIcons.basketShopping, color: Colors.white),
                        ),
                        title: Text('상품명으로 검색하기'),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewItemPagebyCategory(),
                        ));
                  },
                  child: Container(
                    height: 70.0,
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                        leading: CircleAvatar(
                          backgroundColor: AppColor.swatchColor,
                          child: Icon(FontAwesomeIcons.tag, color: Colors.white),
                        ),
                        title: Text('카테고리로 검색하기'),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey[600]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        backgroundColor: Colors.transparent
    );
  }
}
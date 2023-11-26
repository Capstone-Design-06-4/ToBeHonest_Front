import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:tuple/tuple.dart';
import 'package:tobehonest/models/friend.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_add_controller.dart';

class EmailAddPage extends StatefulWidget {
  @override
  _EmailAddPageState createState() => _EmailAddPageState();
}

class _EmailAddPageState extends State<EmailAddPage> {
  final TextEditingController _emailController = TextEditingController();
  final AddController _addController = Get.find<AddController>();
  final List<String> _domainList = ['직접 입력', 'naver.com', 'kakao.com'];
  String _selectedDomain = '직접 입력';
  String errorText = '';
  String friendName = '';
  String friendBirthdate = '';
  String friendImage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: '이메일 입력',
                  border: OutlineInputBorder(),
                  hintText: 'yourname@example.com',
                  suffixIcon: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedDomain,
                      items: _domainList.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value == '직접 입력' ? value : '@' + value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedDomain = newValue!;
                          _emailController.text = newValue == '직접 입력'
                              ? ''
                              : _emailController.text.split('@').first + '@' + newValue;
                        });
                      },
                    ),
                  ),
                  errorText: errorText.isNotEmpty ? errorText : null,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 35.0),
              if (friendName.isNotEmpty)
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 40.0,
                        child: Center(
                          child: Text(
                            '친구 목록에 추가되었어요!',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 70.0,
                        child: Center(
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                            leading: CircleAvatar(
                              backgroundColor: AppColor.swatchColor,
                              child: CircleAvatar(
                                backgroundColor: Colors.black,
                                backgroundImage: NetworkImage(friendImage),
                                radius: 60.0,
                              ),
                            ),
                            title: Text(
                              friendName,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                            subtitle: Text(friendBirthdate),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: AppColor.backgroundColor,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: Size(0, 36),
                    ),
                    onPressed: () async {
                      if (!_validateForm()) {
                        setState(() {
                          errorText = '올바른 이메일을 입력해주세요.';
                        });
                      } else {
                        setState(() {
                          errorText = '';
                        });
                        String fullEmail = _emailController.text;
                        print('전체 이메일: $fullEmail');

                        Tuple2<Friend, String> searchResult =
                        await _addController.searchFriendsByEmail(fullEmail);

                        switch (searchResult.item2) {
                          case 'EMPTY':
                          // Handle empty result
                            break;
                          case 'ME':
                          // Handle result when the searched user is the current user
                            break;
                          case 'FRIEND':
                          // Handle result when the searched user is already a friend
                            break;
                          case 'NOT_FRIEND':
                          // Handle result when the searched user is not a friend
                            print('검색된 친구 정보: ${searchResult.item1.name}');
                            setState(() {
                              friendName = searchResult.item1.name;
                              friendBirthdate = searchResult.item1.birthDate;
                              friendImage = searchResult.item1.profileURL;
                            });
                            break;
                          default:
                          // Handle unknown result
                            break;
                        }
                      }
                    },
                    child: Text(
                      '이메일로 추가하기',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    final emailPattern = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$');
    return emailPattern.hasMatch(_emailController.text);
  }
}
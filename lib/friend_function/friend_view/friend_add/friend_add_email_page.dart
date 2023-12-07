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
  int status = 0;

  void updateStatus(int newStatus) {
    setState(() {
      status = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30.0),
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 300,
                        child: (() {
                          switch (status) {
                            case 1:
                              return Container(
                                height: 100.0,
                                child: Center(
                                  child: Text(
                                    '등록되지 않은 사용자에요.',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              );
                            case 2:
                              return Container(
                                height: 100.0,
                                child: Center(
                                  child: Text(
                                    '본인의 이메일을 입력했어요.',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              );
                            case 3:
                              return Container(
                                height: 100.0,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 70,),
                                      Text(
                                        '이미 친구인 사용자예요.',
                                        style: TextStyle(fontSize: 18.0),
                                      ),
                                      SizedBox(height: 20,),
                                      Container(
                                        height: 70.0,
                                        child: Center(
                                          child: ListTile(
                                            contentPadding: EdgeInsets.symmetric(horizontal: 32.0),
                                            leading: CircleAvatar(
                                              backgroundColor: AppColor.swatchColor,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.black,
                                                backgroundImage: NetworkImage(
                                                  friendImage,
                                                ), // Provide the friend's profile image URL
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

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            case 4:
                              return Container(
                                height: 170.0,
                                child: Column(
                                  children: [
                                    SizedBox(height: 70,),
                                    Text(
                                      '친구 목록에 추가했어요.',
                                      style: TextStyle(fontSize: 18.0),
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
                                              backgroundImage: NetworkImage(
                                                friendImage,
                                              ), // Provide the friend's profile image URL
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
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            default:
                              return Container(
                                height: 100.0,
                                child: Center(
                                  child: Text(
                                    '이메일를 입력해주세요.',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              );
                          }
                        })(),
                      ),
                    ],
                  ),
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
                            updateStatus(1);
                            break;
                          case 'ME':
                            print('검색된 친구 정보: ${searchResult.item1.name}');
                            setState(() {
                              friendName = searchResult.item1.name;
                              friendBirthdate = searchResult.item1.birthDate;
                              updateStatus(2);
                            });
                            break;
                          case 'FRIEND':
                            print('검색된 친구 정보: ${searchResult.item1.name}');
                            setState(() {
                              friendName = searchResult.item1.name;
                              friendBirthdate = searchResult.item1.birthDate;
                              friendImage = searchResult.item1.profileURL;
                              updateStatus(3);
                            });
                            break;
                          case 'NOT_FRIEND':
                            print('검색된 친구 정보: ${searchResult.item1.name}');
                            setState(() {
                              friendName = searchResult.item1.name;
                              friendBirthdate = searchResult.item1.birthDate;
                              friendImage = searchResult.item1.profileURL;
                              updateStatus(4);
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
              SizedBox(height: 15,)
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
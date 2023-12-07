import 'package:flutter/material.dart';
import 'package:tobehonest/style.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tobehonest/models/friend.dart';
import 'package:tobehonest/controllers/friend_add_controller.dart';
import 'package:tuple/tuple.dart';


class PhoneNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    if (newValue.text.length > 13) {
      return oldValue;
    }

    final newText = StringBuffer();
    final String digitOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    for (int i = 0; i < digitOnly.length; i++) {
      if (i == 3 || i == 7) newText.write('-');
      newText.write(digitOnly[i]);
      if (i == 10) break;
    }

    return newValue.copyWith(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class PhoneNumberAddPage extends StatefulWidget {
  @override
  _PhoneNumberAddPageState createState() => _PhoneNumberAddPageState();
}

class _PhoneNumberAddPageState extends State<PhoneNumberAddPage> {
  final TextEditingController _phoneController = TextEditingController();
  final AddController _addController = Get.find<AddController>(); // AddController 인스턴스
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
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  hintText: '전화번호 입력',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      _phoneController.clear();
                      setState(() {
                        errorText = ''; // 입력값이 클리어되면 오류 메시지 초기화
                      });
                    },
                  ),
                  errorText: errorText.isNotEmpty ? errorText : null, // 오류 메시지 표시
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  PhoneNumberInputFormatter(),
                ],
                maxLength: 13,
                buildCounter: (
                    BuildContext context, {
                      required int currentLength,
                      required bool isFocused,
                      required int? maxLength,
                    }) {
                  return Text(
                    '${currentLength - (currentLength > 3 ? 1 : 0) - (currentLength > 7 ? 1 : 0)}/11',
                    semanticsLabel: 'counter',
                  );
                },
              ),
              SizedBox(height: 10.0),
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
                                    '본인의 전화번호를 입력했어요.',
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
                                        '이미 친구인 사용자에요.',
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
                                    '전화번호를 입력해주세요.',
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
                      final String digitOnly = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
                      if (digitOnly.length != 11) {
                        setState(() {
                          errorText = '올바른 전화번호를 입력해주세요.';
                        });
                      } else {
                        setState(() {
                          errorText = ''; // 오류 메시지 초기화
                        });
                        String fullNumber = _phoneController.text;
                        print('전체 이메일: $fullNumber');
                        Tuple2<Friend, String> searchResult = await _addController.searchFriendsByNumber(fullNumber);

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
                      '전화번호로 추가하기',
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
}

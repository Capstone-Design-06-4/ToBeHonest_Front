//friend_add_email_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_add_controller.dart';

class EmailAddPage extends StatefulWidget {
  @override
  _EmailAddPageState createState() => _EmailAddPageState();
}

class _EmailAddPageState extends State<EmailAddPage> {
  final TextEditingController _emailController = TextEditingController();
  final AddController _addController = Get.find<AddController>(); // AddController 인스턴스

  final List<String> _domainList = [
    '직접 입력',
    'naver.com',
    'kakao.com',
  ];
  String _selectedDomain = '직접 입력';
  String errorText = ''; // 오류 메시지 추가

  @override
  void initState() {
    super.initState();
  }

  bool _validateForm() {
    final emailPattern = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$');
    return emailPattern.hasMatch(_emailController.text);
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
              Container(
                margin: EdgeInsets.only(bottom: 16.0), // 아래쪽 마진 추가
                child: TextFormField(
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
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange.shade400,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: FittedBox(
                        child: Text(
                          '이메일로 추가하기',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      onPressed: () {
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
                          _addController.searchFriendsByEmail(fullEmail);
                        }
                      },

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
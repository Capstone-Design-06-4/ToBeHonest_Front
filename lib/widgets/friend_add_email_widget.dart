import 'package:flutter/material.dart';

class EmailAddPage extends StatefulWidget {
  @override
  _EmailAddPageState createState() => _EmailAddPageState();
}

class _EmailAddPageState extends State<EmailAddPage> {
  final TextEditingController _emailController = TextEditingController();

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
                  errorText: errorText.isNotEmpty ? errorText : null, // 오류 메시지 표시
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: Text('추가하기'),
                      onPressed: () {
                        if (!_validateForm()) {
                          setState(() {
                            errorText = '올바른 이메일을 입력해주세요.'; // 이메일이 유효하지 않을 때 오류 메시지 설정
                          });
                        } else {
                          setState(() {
                            errorText = ''; // 이메일이 유효하면 오류 메시지 초기화
                          });
                          String fullEmail = _emailController.text;
                          print('전체 이메일: $fullEmail');
                          // 여기에 이메일 추가 로직을 구현하세요
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

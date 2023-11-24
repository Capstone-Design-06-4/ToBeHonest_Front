import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tobehonest/controllers/friend_add_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
                          '전화번호로 추가하기',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      onPressed: () {
                        final String digitOnly = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
                        if (digitOnly.length != 11) {
                          setState(() {
                            errorText = '올바른 전화번호를 입력해주세요.';
                          });
                        } else {
                          // Valid phone number entered, proceed with the logic
                          setState(() {
                            errorText = ''; // 오류 메시지 초기화
                          });
                          String fullNumber = _phoneController.text;
                          print('전체 전화번호: $fullNumber');
                          _addController.searchFriendsByNumber(fullNumber);

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

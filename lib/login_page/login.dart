import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/login_page/sign_up.dart';
import 'package:tobehonest/main.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:tobehonest/services/login_service.dart';

import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import '../services/login_service.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '이메일',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFFFFFF).withAlpha(250),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            controller: _emailController, // Add this line
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.black,
              ),
              hintText: '이메일을 입력해주세요',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '비밀번호',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xFFFFFF).withAlpha(250),
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: TextField(
            controller: _passwordController, // Add this line
            obscureText: !_rememberMe,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: '비밀번호를 입력해주세요',
              hintStyle: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            '비밀번호 표시하기',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          // 로그인 버튼이 눌렸을 때 실행되는 로직
          String email = _emailController.text;
          String password = _passwordController.text;

          // 입력된 이메일과 비밀번호 출력
          print('Email: $email');
          print('Password: $password');

          // Attempt to log in
           bool loginSuccess = await login(email, password);
          //bool loginSuccess = await login('email1@example.com', 'password1');
          //bool loginSuccess = await login('email2@example.com', 'password2');
          //bool loginSuccess = await login('abc@abc.com', 'abcd1234');
          //bool loginSuccess = await login('abcd@abcd.com', 'abcd1234');
          // Check if login was successful
          if (loginSuccess) {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => MyHomePage(),
                transitionDuration: Duration.zero,
              ),
            );
          } else {
            Get.snackbar(
              '알림',
              '이메일 또는 비밀번호가 올바르지 않습니다.',
              snackPosition: SnackPosition.TOP,
            );
            print('Login failed');
            // You might want to show an error message or perform other actions
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          primary: Colors.white,
        ),
        child: Text(
          '로그인',
          style: TextStyle(
            color: Color(0xFFF25C54),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }



  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        print('Sign Up Button Pressed');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupScreen()),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '원하는 선물을 받고싶다면? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: '회원가입하기',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _naverButton(String imagePath,
      {double width = 100.0, double height = 45.0, BoxFit fit = BoxFit.fill}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            // 여기에 네이버 로그인 로직 추가!
            try {
              final NaverLoginResult login = await FlutterNaverLogin.logIn();
              final NaverAccessToken tokenResult =
                  await FlutterNaverLogin.currentAccessToken;
              String accessToken = tokenResult.accessToken;
              var encodedToken = Uri.encodeComponent(accessToken);

              var url = Uri.parse(
                  'http://52.78.37.19:8080/oauth/naver?accessToken=$encodedToken');
              //요거만 파싱
              final response = await http.get(url);
              print(response.body);
              print(response.statusCode);

              if (response.statusCode == 200) {
                final data = json.decode(response.body);
                final accessToken = data['accessToken'];
                //print('Token before saved: ' + accessToken);
                await saveToken(accessToken);

                await saveEmail(login.account.email);

                await getMyInfoFirst(login.account.email, accessToken);

                print('로그인 성공: ${response.statusCode}');
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => MyHomePage(),
                    transitionDuration: Duration.zero,
                  ),
                );
              }
            } catch (error) {
              print(error);
            }
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // 이미지 둥글게
            ),
            child: Image.asset(
              imagePath,
              width: width,
              height: height,
              fit: fit,
            ),
          ),
        ),
      ),
    );
  }

  Widget _kakaoButton(String imagePath,
      {double width = 100.0, double height = 45.0, BoxFit fit = BoxFit.fill}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            // 여기에 카카오 로그인 로직 추가!
            {

              var encodedToken = "";
              var email = "";

              if (await isKakaoTalkInstalled()) {
                try {
                  print("111111111111111111111111");

                  var oAuthToken = await UserApi.instance.loginWithKakaoTalk();

                  encodedToken =
                      Uri.encodeComponent(oAuthToken.accessToken.toString());
                } catch (error) {
                  print('카카오톡으로 로그인 실패 $error');
                }
// 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                try {
                  var oAuthToken =
                      await UserApi.instance.loginWithKakaoAccount();
                  encodedToken =
                      Uri.encodeComponent(oAuthToken.accessToken.toString());
                } catch (error) {
                  print('카카오계정으로 로그인 실패 $error');
                }
              } else {
                try {
                  var oAuthToken =
                      await UserApi.instance.loginWithKakaoAccount();
                  encodedToken =
                      Uri.encodeComponent(oAuthToken.accessToken.toString());

                  print('카카오계정으로 로그인 성공');
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) => MyHomePage(),
                      transitionDuration: Duration.zero,
                    ),
                  );
                } catch (error) {
                  print('카카오계정으로 로그인 실패 $error');
                }
              }
              if (encodedToken != "") {
                try {

                  var url = Uri.parse(
                      'http://52.78.37.19:8080/oauth/kakao?accessToken=$encodedToken');
                  final response = await http.get(url);
                  if (response.statusCode == 200) {
                    var me = await UserApi.instance.me();
                    email = me.kakaoAccount!.email!;

                    final data = json.decode(response.body);
                    final accessToken = data['accessToken'];
                    //print('Token before saved: ' + accessToken);
                    await saveToken(accessToken);
                    await saveEmail(email);
                    await getMyInfoFirst(email, accessToken);
                    print(email);

                    print('카카오로그인 성공: ${response.statusCode}');
                  }
                } catch (error) {
                  print("에러");
                }
              }
            }
          },
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // 이미지 둥글게
            ),
            child: Image.asset(
              imagePath,
              width: width,
              height: height,
              fit: fit,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Color(0xFFF27059).withAlpha(250),
                      Color(0xFFF4845F).withAlpha(250),
                      Color(0xFFF79D65).withAlpha(250),
                      Color(0xFFF7B267).withAlpha(250),
                    ],
                    stops: [0.1, 0.2, 0.3, 0.5],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 90.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: [
                          Container(
                            width: 125.0, // 원형 이미지의 가로 크기
                            height: 125.0, // 원형 이미지의 세로 크기
                            decoration: BoxDecoration(
                              shape: BoxShape.circle, // 원형 모양 지정
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/logo.png'), // 이미지 경로 지정
                                fit: BoxFit.fill, // 이미지가 컨테이너를 완전히 채우도록 설정
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black12,  // 배경색 설정
                              borderRadius: BorderRadius.circular(12.0),  // 둥근 모서리 설정
                            ),
                            padding: EdgeInsets.all(8.0),  // 내부 여백 설정
                            child: Text(
                              '원하는 선물을 받고!\n원하는 만큼 펀딩하자!',
                              style: TextStyle( fontSize: 16, color: Colors.white),  // 텍스트 스타일 설정
                            ),
                          ),
                          SizedBox(height: 30.0),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors
                              .white54, // Set your desired border radius here
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 30.0),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: _buildEmailTF(),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              child: _buildPasswordTF(),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            _buildRememberMeCheckbox(),
                            SizedBox(height: 30.0),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: _buildLoginBtn(),
                      ),
                      Text(
                        ' 또는 ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0, // Adjust the font size as needed
                          fontFamily:
                              'YourFontFamily', // Specify your desired font family
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _naverButton(
                            'assets/images/naver_login.png',
                            width: 100.0,
                            height: 45.0,
                            fit: BoxFit.fitHeight,
                          ),
                          SizedBox(width: 20.0),
                          _kakaoButton(
                            'assets/images/kakao_login.png',
                            width: 100.0,
                            height: 45.0,
                            fit: BoxFit.fitWidth,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tobehonest/style.dart';
import 'package:tobehonest/login_page/sigun_up.dart';
import 'package:tobehonest/main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

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
        onPressed: () {
          print('Login Button Pressed');
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => MyHomePage(),
              transitionDuration:
                  Duration.zero, // Set transition duration to zero
            ),
          );
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
          onTap: () {
            // 여기에 네이버 로그인 로직 추가!
            print('Naver Button Clicked!');
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
          onTap: () {
            // 여기에 카카오 로그인 로직 추가!
            print('Kakao Button Clicked!');
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
                          Text(
                            '원하는 선물을 받고!\n원하는 만큼 펀딩하자!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0, // Adjust the font size as needed
                              fontFamily:
                                  'YourFontFamily', // Specify your desired font family
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
                              height: 30.0,
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
                        '--------------------------- 또는 ---------------------------',
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

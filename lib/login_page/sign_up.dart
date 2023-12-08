  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
import 'package:get/get.dart';
  import 'package:tobehonest/style.dart';
  import 'package:tobehonest/login_page/login.dart';

  import '../services/login_service.dart';


  class SignupScreen extends StatefulWidget {
    @override
    _LoginScreenState createState() => _LoginScreenState();
  }

  class _LoginScreenState extends State<SignupScreen> {
    bool _rememberMe = false;
    TextEditingController _nameController = TextEditingController();
    TextEditingController _birthdayController = TextEditingController();
    TextEditingController _phoneNumberController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _password2Controller = TextEditingController();


    User user = User(
      name: '',
      birthdate: '',
      phoneNumber: '',
      email: '',
      passWord: '',
    );

    Widget _buildNameTF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '이름',
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
              keyboardType: TextInputType.name,
              controller: _nameController,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),

              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                hintText: '이름을 입력해주세요',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildBirthdayTF() {

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '생일',
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
              controller: _birthdayController,

              maxLength: 8,
              keyboardType: TextInputType.number, // Set keyboard type to numeric
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),

              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp('[^0-9]')),
                LengthLimitingTextInputFormatter(8),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.cake,
                  color: Colors.black,
                ),
                hintText: '생년월일 8자리를 입력해주세요',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                counterText: '', // Hide the character count indicator
              ),
            ),
          ),
        ],
      );
    }



    Widget _buildPhoneTF() {

      String formatPhoneNumber(String input) {
        if (input.length == 3 || input.length == 8) {
          return '$input-';
        }
        return input;
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '전화번호',
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
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              maxLength: 13, // Set max length to 13
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              onChanged: (value) {
                _phoneNumberController.value = _phoneNumberController.value.copyWith(
                  text: formatPhoneNumber(value),
                  selection: TextSelection.collapsed(offset: formatPhoneNumber(value).length),
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                hintText: '전화번호를 입력해주세요',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
                counterText: '', // Hide the character count indicator
              ),
            ),
          ),
        ],
      );
    }



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
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              onChanged: (value) {
                _emailController.value = _emailController.value.copyWith(
                  text: (value),
                  selection: TextSelection.collapsed(offset: (value).length),
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: 'email@example.com',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
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
            decoration:  BoxDecoration(
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
              controller: _passwordController,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              onChanged: (value) {
                _passwordController.value = _passwordController.value.copyWith(
                  text: (value),
                  selection: TextSelection.collapsed(offset: (value).length),
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: '8자리 이상 입력해주세요',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildPassword2TF() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration:  BoxDecoration(
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
              controller: _password2Controller,
              obscureText: true,
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans',
              ),
              onChanged: (value) {
                _password2Controller.value = _password2Controller.value.copyWith(
                  text: (value),
                  selection: TextSelection.collapsed(offset: (value).length),
                );
              },
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                hintText: '비밀번호를 다시 입력해주세요',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ],
      );
    }


    Widget _buildLoginBtn() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            // Get user information from text controllers
            String name = _nameController.text;
            String birthDate = _birthdayController.text;
            String phoneNumber = _phoneNumberController.text;
            String email = _emailController.text;
            String passWord = _passwordController.text;
            String passwordConfirmation = _password2Controller.text;

            // Print the values for debugging
            print('Name: $name');
            print('birthDate: $birthDate');
            print('PhoneNumber: $phoneNumber');
            print('Email: $email');
            print('passWord: $passWord');
            print('PasswordConfirmation: $passwordConfirmation');

            // Check if any field is empty
            if (name.isEmpty ||
                birthDate.isEmpty ||
                phoneNumber.isEmpty ||
                email.isEmpty ||
                passWord.isEmpty ||
                passwordConfirmation.isEmpty ||
                passWord != passwordConfirmation
            ) {
              // One or more fields are empty, show Snackbar
              final snackBar = SnackBar(
                content: Text('다시 한 번 확인해주세요.'),
                action: SnackBarAction(
                  label: '닫기',
                  onPressed: () {
                    // Perform some action to close the Snackbar if needed
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return; // Stop the further execution of the method
            }

            // Check if passwords match
            if (passWord != passwordConfirmation) {
              // Passwords don't match, show Snackbar
              final snackBar = SnackBar(
                content: Text('비밀번호가 일치하지 않습니다.'),
                action: SnackBarAction(
                  label: '닫기',
                  onPressed: () {
                    // Perform some action to close the Snackbar if needed
                  },
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              return; // Stop the further execution of the method
            }

            // Construct user information map
            Map<String, dynamic> user = {
              'name': name,
              'birthDate': birthDate,
              'phoneNumber': phoneNumber,
              'email': email,
              'passWord': passWord,
            };

            // Call the signup method
            bool signupSuccess = await signup(user);

            // Check if signup was successful
            if (signupSuccess) {
              Get.snackbar("알림", "회원가입이 완료되었습니다.", snackPosition: SnackPosition.TOP);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else {
              Get.snackbar("알림", "회원가입에 실패했습니다.", snackPosition: SnackPosition.TOP);
              return;
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
            '회원가입',
            style: TextStyle(
              color: Color(0xFFF25C54),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      );
    }



    Widget _buildSignupBtn() {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '계정이 이미 있다면?  ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: '로그인하기',
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

    @override
    Widget build(BuildContext context) {
      TextEditingController _nameController = TextEditingController();
      TextEditingController _birthdayController = TextEditingController();
      TextEditingController _phoneNumberController = TextEditingController();
      TextEditingController _emailController = TextEditingController();
      TextEditingController _passwordController = TextEditingController();
      TextEditingController _password2Controller = TextEditingController();

      @override
      void dispose() {
        // Dispose of the controllers to free up resources
        _nameController.dispose();
        _birthdayController.dispose();
        _phoneNumberController.dispose();
        _emailController.dispose();
        _passwordController.dispose();
        _password2Controller.dispose();
        super.dispose();
      }

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
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Colors.white54,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 30.0),
                                _buildNameTF(),
                                SizedBox(height: 10.0),
                                _buildBirthdayTF(),
                                SizedBox(height: 10.0),
                                _buildPhoneTF(),
                                SizedBox(height: 10.0),
                                _buildEmailTF(),
                                SizedBox(height: 10.0),
                                _buildPasswordTF(),
                                SizedBox(height: 10.0),
                                _buildPassword2TF(),
                                SizedBox(height: 30.0),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                          ),
                          child: _buildLoginBtn(),
                        ),
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

  class User {
    String name;
    String birthdate;
    String phoneNumber;
    String email;
    String passWord;

    User({
      required this.name,
      required this.birthdate,
      required this.phoneNumber,
      required this.email,
      required this.passWord,
    });
  }

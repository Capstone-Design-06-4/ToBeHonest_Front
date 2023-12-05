import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

void main() {
  KakaoSdk.init(nativeAppKey: '07150a42df86d834d5deb4c2cffbb9e9');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            color: Colors.white,
            child: Center(
                child: ElevatedButton(
                    child: Text("카카오 로그인"),
                    onPressed: () async {
                      await kakaoLogin();
                    }))));
  }
}

Future<String> kakaoLogin() async {
  var encodedToken = "";
  var result = "";
  if (await isKakaoTalkInstalled()) {
    try {
      var oAuthToken = await UserApi.instance.loginWithKakaoTalk();
      encodedToken = Uri.encodeComponent(oAuthToken.accessToken.toString());
      var url = Uri.parse(
          'http://52.78.37.19:8080/oauth/kakao?accessToken=$encodedToken');
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
// 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        var oAuthToken = await UserApi.instance.loginWithKakaoAccount();
        encodedToken = Uri.encodeComponent(oAuthToken.accessToken.toString());
        var url = Uri.parse(
            'http://52.78.37.19:8080/oauth/kakao?accessToken=$encodedToken');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      var oAuthToken = await UserApi.instance.loginWithKakaoAccount();
      encodedToken = Uri.encodeComponent(oAuthToken.accessToken.toString());

      print('카카오계정으로 로그인 성공');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
  if (encodedToken != ""){


  }
  print(result);
  return result;
}

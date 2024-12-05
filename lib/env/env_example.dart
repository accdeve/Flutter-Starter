// const BASE_URL_API = "https://api-lpmukp.adslink.id";
// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const BASE_URL_API = "hoho";
const TQUIZ_KEY = "hoho juga";

String COOKIE = "";

Future getCookie() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? cookieValue = prefs.getString('cookie');
  if (cookieValue != null) {
    COOKIE = cookieValue;
  }
  return COOKIE;
}

Future<void> updateCookie(String? newCookie) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('cookie', newCookie!);

  COOKIE = newCookie;
}

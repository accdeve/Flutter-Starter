import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:t_quiz/utils/routes.dart' as app_route;

void backToRoot(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
}

void popUntilRoot(context) {
  Navigator.popUntil(context, ModalRoute.withName('/'));
}

void backToMain(context) {
  Navigator.pushNamedAndRemoveUntil(context, '/main', (_) => false);
}

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void popScreen(BuildContext context, [dynamic data]) {
  Navigator.pop(context, data);
}

enum RouteTransition { slide, dualSlide, fade, material, cupertino, slideUp }

Future pushScreen(BuildContext context, Widget buildScreen,
    [RouteTransition routeTransition = RouteTransition.slide,
    Widget? fromScreen]) async {
  dynamic data;
  switch (routeTransition) {
    case RouteTransition.slide:
      data =
          await Navigator.push(context, app_route.SlideRoute(page: buildScreen));
      break;
    case RouteTransition.fade:
      data =
          await Navigator.push(context, app_route.FadeRoute(page: buildScreen));
      break;
    case RouteTransition.material:
      data = await Navigator.push(
          context, MaterialPageRoute(builder: (context) => buildScreen));
      break;
    case RouteTransition.dualSlide:
      data = await Navigator.push(
          context,
          app_route.DualSlideRoute(
              enterPage: buildScreen, exitPage: fromScreen ?? context.widget));
      break;
    case RouteTransition.cupertino:
      data = await Navigator.push(
          context,
          CupertinoPageRoute(
              fullscreenDialog: true, builder: (context) => buildScreen));
      break;
    case RouteTransition.slideUp:
      data = await Navigator.push(
          context, app_route.SlideUpRoute(page: buildScreen));
      break;
  }
  return data;
}

void pushAndRemoveScreen(BuildContext context,
    {required Widget pageRef, RouteTransition routeTransition = RouteTransition.material}) {
  Route route;

  switch (routeTransition) {
    case RouteTransition.slide:
      route = app_route.SlideRoute(page: pageRef);
      break;
    case RouteTransition.fade:
      route = app_route.FadeRoute(page: pageRef);
      break;
    case RouteTransition.material:
      route = MaterialPageRoute(builder: (context) => pageRef);
      break;
    case RouteTransition.dualSlide:
      route = app_route.DualSlideRoute(
          enterPage: pageRef, exitPage: context.widget);
      break;
    case RouteTransition.cupertino:
      route = CupertinoPageRoute(
          fullscreenDialog: true, builder: (context) => pageRef);
      break;
    case RouteTransition.slideUp:
      route = app_route.SlideUpRoute(page: pageRef);
      break;
  }

  Navigator.pushAndRemoveUntil(
    context,
    route,
    (Route<dynamic> route) => false,
  );
}


String toRupiah(int number) {
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  return currencyFormatter.format(number);
}

String shortCurr(int number) {
  return number < 1000000 ? toRupiah(number) : convCurr(number);
}

String convCurr(int number) {
  final currencyFormatter = NumberFormat.compact(locale: 'ID');
  return currencyFormatter.format(number);
}

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String hours = twoDigits(duration.inHours);
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$hours:$minutes:$seconds";
}

String formatedDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(date);
}

void handleCopy(BuildContext context, String text, String message) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        margin: EdgeInsets.zero,
        duration: const Duration(seconds: 2),
        content: Text(message),
        backgroundColor: Colors.grey[900],
        behavior: SnackBarBehavior.floating,
      ),
    );
}

/// Formats a DateTime object into a human-readable string in Indonesian format,
/// including day of the week, day of the month, month name, and year.
///
/// Returns:
///   `day` `day(int)` `month` `year`
///ex: Senin 2 Agustus 2022
String formatDate(DateTime dateTime) {
  final formatter = DateFormat('EEEE d MMMM yyyy', 'id');
  return formatter.format(dateTime);
}

Future<File> getTemporaryFileFromAsset(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final tempDir = await getTemporaryDirectory();
  final tempFile = File('${tempDir.path}/${assetPath.split('/').last}');
  return await tempFile.writeAsBytes(byteData.buffer.asUint8List());
}
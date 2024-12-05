import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

MaterialBanner createCustomMaterialBanner({
  double elevation = 0,
  Color backgroundColor = Colors.transparent,
  String title = 'Default Title',
  String message = 'Default message for material banner',
  ContentType? contentType,
  bool forceActionsBelow = true,
}) {
  return MaterialBanner(
    elevation: elevation,
    backgroundColor: backgroundColor,
    forceActionsBelow: forceActionsBelow,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType ?? ContentType.help,
      inMaterialBanner: true,
    ),
    actions: const [SizedBox.shrink()],
  );
}

SnackBar createCustomSnackBar({
  double elevation = 0,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  Color backgroundColor = Colors.transparent,
  String title = 'Yeay',
  String message = 'Kamu berhasil',
  ContentType? contentType,
}) {
  return SnackBar(
    elevation: elevation,
    behavior: behavior,
    backgroundColor: backgroundColor,
    content: AwesomeSnackbarContent(
      title: title,
      message: message,
      contentType: contentType ?? ContentType.success, // Berikan default di sini
    ),
  );
}

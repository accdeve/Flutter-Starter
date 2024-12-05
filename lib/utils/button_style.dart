import "package:flutter/material.dart";

final ButtonStyle primaryElevatedButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xff1276BB),
  minimumSize: const Size(100, 40),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);


final ButtonStyle primaryElevatedButtonEmptyTextStyle = ElevatedButton.styleFrom(
  backgroundColor: const Color(0xffD1D5DB),
  minimumSize: const Size(double.infinity, 40),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

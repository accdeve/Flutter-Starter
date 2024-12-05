import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:t_quiz/utils/typography.dart';

class CustomTitleInput extends StatelessWidget {
  final String titleText;
  final bool isRequired;
  const CustomTitleInput({super.key, required this.titleText, this.isRequired = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          style: poppinsLight16,
          children: <TextSpan>[
            TextSpan(text: titleText),
            TextSpan(text: isRequired ? "*" : "", style: const TextStyle())
          ],
        ),
      ),
    );
  }
}

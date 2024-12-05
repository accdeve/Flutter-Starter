import 'package:flutter/material.dart';
import 'package:t_quiz/ui/widgets/button_widget.dart';
import 'package:t_quiz/utils/colors.dart';
import 'package:t_quiz/utils/typography.dart';

class PopUpExitWidget extends StatelessWidget {
  const PopUpExitWidget({super.key});

  static void showExitBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.only(right: 40,left: 40, top: 5, bottom: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(10),
                      )),
                  Text(
                    "Logout",
                    style: poppinsBold20.copyWith(color: const Color(0xffA52A2A).withOpacity(0.86)),
                  ),
                  Divider(
                    thickness: 2,
                    color: black.withOpacity(0.2),
                  ),
                  const Text('Are you sure want to log out?', style: poppinsSemiBold16),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          width: constraints.maxWidth / 3,
                          child: CustomButton.contained(
                            label: "Cancel",
                            onPressed: () {},
                            color: lightGrey6,
                            textColor: primary,
                            splashColor: black,
                            elevation: 10,
                          )),
                      SizedBox(width: constraints.maxWidth / 3, child: CustomButton.contained(label: "Yes, Exit", onPressed: () {})),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

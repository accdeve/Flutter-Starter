import 'package:flutter/material.dart';
import 'package:t_quiz/ui/widgets/button_widget.dart';
import 'package:t_quiz/utils/colors.dart';
import 'package:t_quiz/utils/typography.dart';

class PopUpConfirmationWidget extends StatelessWidget {
  final String title;
  final String description;
  final String cancelButtonLabel;
  final String confirmButtonLabel;
  final VoidCallback onCancelPressed;
  final VoidCallback onConfirmPressed;

  const PopUpConfirmationWidget({
    super.key,
    required this.title,
    required this.description,
    required this.cancelButtonLabel,
    required this.confirmButtonLabel,
    required this.onCancelPressed,
    required this.onConfirmPressed,
  });

  static void showConfirmationBottomSheet(
    BuildContext context, {
    required String title,
    required String description,
    required String cancelButtonLabel,
    required String confirmButtonLabel,
    required VoidCallback onCancelPressed,
    required VoidCallback onConfirmPressed,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.only(right: 40, left: 40, top: 5, bottom: 20),
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
                    ),
                  ),
                  Text(
                    title,
                    style: poppinsBold20.copyWith(color: const Color(0xffA52A2A).withOpacity(0.86)),
                  ),
                  Divider(
                    thickness: 2,
                    color: black.withOpacity(0.2),
                  ),
                  Text(description, style: poppinsSemiBold16),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: constraints.maxWidth / 3,
                        child: CustomButton.contained(
                          label: cancelButtonLabel,
                          onPressed: onCancelPressed,
                          color: lightGrey6,
                          textColor: primary,
                          splashColor: black,
                          elevation: 10,
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth / 3,
                        child: CustomButton.contained(
                          label: confirmButtonLabel,
                          onPressed: onConfirmPressed,
                        ),
                      ),
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

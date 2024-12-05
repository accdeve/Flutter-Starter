import 'package:flutter/material.dart';
import 'package:t_quiz/utils/utils_barrel.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final Color? color;
  final bool disabled;
  final bool isUpperCase;
  final Widget? leading;
  final bool _isContained;
  final Color? textColor;
  final double? elevation;
  final bool isCompact;
  final bool isSmall;
  final bool isLoading;
  final Color? hoverColor;
  final Color? splashColor;
  final Color? highlightColor;
  final double? borderRadius;

  const CustomButton.contained({
    super.key,
    @required this.label,
    @required this.onPressed,
    this.color,
    this.disabled = false,
    this.isUpperCase = false,
    this.leading,
    this.textColor,
    this.elevation = 4,
    this.isCompact = false,
    this.isSmall = false,
    this.isLoading = false,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
    this.borderRadius = 20,
  }) : _isContained = true;

  const CustomButton.outlined({
    super.key,
    @required this.label,
    @required this.onPressed,
    this.color,
    this.disabled = false,
    this.isUpperCase = false,
    this.leading,
    this.textColor,
    this.elevation,
    this.isCompact = false,
    this.isSmall = false,
    this.isLoading = false,
    this.hoverColor,
    this.splashColor,
    this.highlightColor,
    this.borderRadius = 20,
  }) : _isContained = false;

  @override
  Widget build(BuildContext context) {
    final Color buildColor = color ?? Theme.of(context).primaryColor;

    return _isContained ? buildContained(buildColor) : buildOutlined(buildColor, leading);
  }

  ElevatedButton buildContained(Color buildColor) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return roundedButtonDisabled;
            }
            return buildColor;
          },
        ),
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) return hoverColor;
            if (states.contains(MaterialState.pressed)) return splashColor;
            return null;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return textSecondary;
            return textColor;
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!)),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(0.0),
        ),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) {
            return Colors.black38;
          },
        ),
        elevation: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return 0;
            if (states.contains(MaterialState.pressed)) return 1;
            return elevation;
          },
        ),
      ),
      onPressed: disabled || isLoading ? null : onPressed,
      child: Container(
        margin: isCompact ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10) : const EdgeInsets.all(16),
        child: !isLoading
            ? Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  leading ?? const SizedBox.shrink(),
                  leading != null
                      ? const SizedBox(
                          width: 6,
                        )
                      : const SizedBox.shrink(),
                  Text(
                    isUpperCase ? label!.toUpperCase() : label!,
                    style: TextStyle(color: disabled ? gray : textColor ?? white, letterSpacing: isUpperCase ? 1.25 : 0, fontSize: isSmall ? 12 : 16, fontWeight: disabled || onPressed == null ? FontWeight.w500 : FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(buildColor),
                ),
              ),
      ),
    );
  }

  Widget buildOutlined(Color buildColor, Widget? leading) {
    var text = Text(
      isUpperCase ? label!.toUpperCase() : label!,
      style: TextStyle(
        color: disabled || onPressed == null ? Colors.grey[400] : textColor ?? buildColor,
        fontSize: isSmall ? 12 : 15,
        fontWeight: disabled || onPressed == null ? FontWeight.w500 : FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
    return OutlinedButton(
      onPressed: disabled ? null : onPressed,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.hovered)) return hoverColor;
            if (states.contains(MaterialState.pressed)) return splashColor;
            return Colors.transparent;
          },
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return textSecondary;
            return textColor;
          },
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius!)),
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(0.0),
        ),
        shadowColor: MaterialStateProperty.resolveWith(
          (states) {
            return Colors.black38;
          },
        ),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return const BorderSide(color: roundedButtonDisabled, width: 2);
          }
          return BorderSide(color: buildColor, width: 1);
        }),
        elevation: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.disabled)) return 0;
            if (states.contains(MaterialState.pressed)) return 1;
            return elevation;
          },
        ),
      ),
      child: Stack(
        children: [
          Container(
            margin: isCompact ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10) : const EdgeInsets.all(12),
            child: Center(
              child: !isLoading
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        leading ?? const SizedBox.shrink(),
                        leading != null
                            ? const SizedBox(
                                width: 6,
                              )
                            : const SizedBox.shrink(),
                        text,
                      ],
                    )
                  : Opacity(opacity: 0, child: text),
            ),
          ),
          Positioned.fill(
            child: isLoading
                ? Center(
                    child: SizedBox(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(buildColor),
                      ),
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}

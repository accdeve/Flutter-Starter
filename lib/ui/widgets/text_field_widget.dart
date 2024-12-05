import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:t_quiz/utils/colors.dart';
import 'package:t_quiz/utils/typography.dart';

enum InputType { text, password, search, field, phone, number, option, price, date, page, benefit, email }

class CustomTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final InputType inputType;
  final TextEditingController? controller;
  final Function(String val)? onChanged;
  final Function(String val)? onFieldSubmitted;
  final String? Function(String? val)? validator;
  final AutovalidateMode? autoValidateMode;
  final TextInputType? keyboardType;
  final String? prefixText;
  final TextAlign? textAlign;
  final bool enabled;
  final Color fillColor;
  final void Function()? onTap;
  final bool? isLoading;
  final bool? autofocus;
  final bool? readOnly;
  final bool? isDense;
  final bool? isHint;
  final Widget? prefixIcons;
  final Widget? suffixIcons;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.inputType = InputType.text,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.prefixText,
    this.textAlign,
    this.enabled = true,
    this.fillColor = textPrimaryInverted,
    this.onTap,
    this.isLoading = false,
    this.autofocus = false,
    this.readOnly = false,
    this.isDense = false,
    this.isHint,
    this.padding,
    this.textStyle,
    this.maxLength,
    this.inputFormatter,
    this.onFieldSubmitted,
    this.initialValue,
    this.focusNode,
    this.validator,
    this.prefixIcons,
    this.suffixIcons,
    this.autoValidateMode = AutovalidateMode.disabled,
  });

  @override
  State<CustomTextField> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<CustomTextField> {
  bool? _obscureText;
  final FocusNode _focus = FocusNode();
  bool _showEmailError = false; 

  @override
  void initState() {
    super.initState();
    _obscureText = widget.inputType == InputType.password ? true : false;
  }

  void _handleEmailValidation(String value) {
    setState(() {
      if (widget.inputType == InputType.email && !value.contains('@')) {
        _showEmailError = true; // Tampilkan error jika tidak ada tanda "@"
      } else {
        _showEmailError = false; // Sembunyikan error jika valid
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          inputFormatters: widget.inputFormatter,
          autofocus: widget.autofocus!,
          onTap: widget.onTap,
          readOnly: widget.inputType == InputType.option || widget.readOnly == true,
          focusNode: _focus,
          textAlign: TextAlign.start,
          maxLength: widget.maxLength,
          maxLines: widget.inputType == InputType.field
              ? 5
              : widget.inputType == InputType.benefit
                  ? 2
                  : 1,
          keyboardType: widget.keyboardType,
          onChanged: (value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            _handleEmailValidation(value); // Panggil validasi email
          },
          autovalidateMode: widget.autoValidateMode,
          onFieldSubmitted: widget.onFieldSubmitted,
          validator: widget.validator,
          initialValue: widget.initialValue,
          controller: widget.controller,
          style: widget.textStyle != null
              ? widget.enabled
                  ? widget.textStyle!.copyWith(color: Colors.black)
                  : widget.textStyle!.copyWith(color: Colors.grey)
              : widget.enabled
                  ? const TextStyle()
                  : const TextStyle(),
          obscureText: _obscureText!,
          decoration: InputDecoration(
            counter: const SizedBox.shrink(),
            isDense: widget.isDense,
            errorMaxLines: 2,
            prefixIcon: widget.prefixIcons,
            contentPadding: EdgeInsets.fromLTRB(
                10, 14, widget.inputType == InputType.password || widget.inputType == InputType.option || widget.inputType == InputType.search ? 4 : 20, 14),
            hintText: widget.inputType == InputType.phone && _focus.hasFocus ? null : widget.hintText,
            hintStyle: widget.isHint == false ? null : poppinsLight16.copyWith(color: black.withOpacity(0.5)),
            filled: true,
            fillColor: widget.enabled ? widget.fillColor : const Color(0xFFF6F7F9),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: black.withOpacity(0.5), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: _showEmailError ? Colors.red : black.withOpacity(0.5), width: 2), // Ubah warna border jika error
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: _showEmailError ? Colors.red : black.withOpacity(0.5), width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: danger, width: 2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: danger, width: 2),
            ),
            suffixIcon: widget.isLoading!
                ? const SizedBox(
                    width: 0,
                    height: 0,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: CircularProgressIndicator(color: primary),
                    ))
                : widget.inputType == InputType.password || widget.inputType == InputType.option
                    ? Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: GestureDetector(
                          onTap: widget.inputType == InputType.password ? () => setState(() => _obscureText = !_obscureText!) : null,
                          child: widget.inputType == InputType.password
                              ? Icon(
                                  _obscureText! ? Icons.visibility : Icons.visibility_off,
                                  color: editTextIcon,
                                )
                              : widget.inputType == InputType.option
                                  ? const Icon(
                                      Icons.arrow_drop_down,
                                      color: editTextIcon,
                                    )
                                  : const SizedBox.shrink(),
                        ),
                      )
                    : widget.inputType == InputType.search
                        ? const Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 22,
                          )
                        : widget.inputType == InputType.date
                            ? const Icon(
                                Icons.calendar_month,
                                color: editTextIcon,
                              )
                            : widget.suffixIcons,
          ),
        ),
        if (_showEmailError)
          Text(
            'Email harus mengandung tanda @',
            style: poppinsLight12.copyWith(color: red),
          ), // Tampilkan pesan peringatan jika tidak ada tanda @
      ],
    );
  }
}

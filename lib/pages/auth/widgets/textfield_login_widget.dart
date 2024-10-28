import 'package:flutter/material.dart';

class TextfieldLoginWidget extends StatefulWidget {
  const TextfieldLoginWidget({
    super.key,
    required this.lable,
    this.obscure = false,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon = false,
    required this.controller,
    this.validator,
    this.maxLines,
  });
  final TextEditingController controller;
  final String lable;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool suffixIcon;
  final String? Function(String?)? validator;
  final int? maxLines;

  @override
  State<TextfieldLoginWidget> createState() => _TextfieldLoginWidgetState();
}

class _TextfieldLoginWidgetState extends State<TextfieldLoginWidget> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscure;
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: _isObscured,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
          suffixIcon: widget.suffixIcon
              ? IconButton(
                  onPressed: _togglePasswordVisibility,
                  icon: Icon(
                    _isObscured
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                )
              : null,
          label: Text(
            widget.lable,
            style: const TextStyle(color: Color(0xffafafaf), fontSize: 14),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Color(0xff78c6e7),
              ))),
    );
  }
}

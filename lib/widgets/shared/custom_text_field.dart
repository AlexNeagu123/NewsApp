import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final double? verticalPadding;
  final String hintText;
  final Widget? prefix;
  final bool? obscureText;
  final String? Function(String? value) validator;
  final void Function(String? value)? onSaved, onChanged;

  const CustomTextField({
    super.key,
    this.prefix,
    this.obscureText,
    this.verticalPadding,
    this.onSaved,
    this.onChanged,
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.validator,
  });

  @override
  CustomTextFieldState createState() => CustomTextFieldState();
}

class CustomTextFieldState extends State<CustomTextField> {
  String? errorText;
  bool get hasError => errorText != null;

  void _onSaved(String? value) {
    value = value!.trim();
    widget.controller.text = value;
    widget.onSaved?.call(value);
  }

  void _onChanged(String value) {
    if (widget.onChanged != null) {
      _runValidator(value);
      widget.onChanged!(value);
    }
  }

  String? _runValidator(String? value) {
    final error = widget.validator(value!.trim());
    setState(() {
      errorText = error;
    });
    return error;
  }

  OutlineInputBorder _normalBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide.none,
    );
  }

  OutlineInputBorder _errorBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
          padding:
              EdgeInsets.symmetric(vertical: widget.verticalPadding ?? 10.0),
          child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText ?? false,
              validator: _runValidator,
              onSaved: _onSaved,
              onChanged: _onChanged,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  prefixIcon: widget.prefix,
                  border: _normalBorder(),
                  errorBorder: hasError ? _errorBorder() : null))),
      if (hasError) ...[
        const SizedBox(height: 5),
        Text(errorText!,
            style: const TextStyle(color: Colors.red, fontSize: 16))
      ]
    ]);
  }
}

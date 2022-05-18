import 'package:flutter/material.dart';

import '../../data/fonts.dart';

InputDecoration greyTransparentDecoration(String text) {
  return InputDecoration(
    hintText: text,
    hintStyle: h4Grey,
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
    ),
  );
}

import 'package:flutter/material.dart';

import '../../data/colors.dart';
import '../../data/fonts.dart';
import '../extra/rounded_containers.dart';

Widget _generateItem(double width, double height, String text) {
  return roundedContainer(
      Text(
        text,
        style: h3Black,
      ),
      null,
      0,
      cWh,
      cWh);
}

List<Widget> genresList() {
  List<Widget> items = [];
  List<String> genres = [
    "эссе",
    "поэма",
    "фэнтези",
    "роман",
    "трагедия",
    "исторические",
    "комедия",
    "философия",
    "рассказ",
    "фантастика"
  ];
  for (int i = 0; i < genres.length; i++) {
    items.add(_generateItem(90, 75, genres[i]),);
  }

  return items;
}

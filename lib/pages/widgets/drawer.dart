import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';

Widget leftPanel(BuildContext context) {
  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xffFFFAFF),
        border: Border.all(color: Color(0xffFFFAFF), width: 2.0),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(200.0),
          bottomRight: Radius.circular(200.0),
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 200,
            ),
            child: TextButton(
              onPressed: () {
                // TODO: to profile (context) implementation
              },
              child: Text(
                'Профиль',
                style: h2Black,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: TextButton(
              onPressed: () {
                // TODO: to list search (context) implementation
              },
              child: Text(
                'Поиск списков',
                style: h2Black,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: TextButton(
                onPressed: () {
                  // TODO: to books (context) implementation
                },
                child: Text('Книги', style: h2Black),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

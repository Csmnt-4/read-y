import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../router.dart';

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
              onPressed: () {},
              child: Text(
                'Профиль',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Color(0xff292931),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 20,
            ),
            child: TextButton(
              onPressed: () {
                toListsPage(context);
              },
              child: Text(
                'Списки',
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Color(0xff292931),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Книги',
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Color(0xff292931),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

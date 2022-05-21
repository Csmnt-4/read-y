import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/extra/clippers.dart';

import '../../data/colors.dart';

Widget leftPanel(BuildContext context) {
  return Drawer(
    elevation: 150,
    backgroundColor: Colors.transparent,

    child: Container(
      color: Colors.transparent,
      child: ClipPath(
        clipper: DrawerShapeBorder(),
        child: Container(
          color: cWh,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 200,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: toProfile(uid, nick, context)
                  },
                  child: Text(
                    'Профиль',
                    style: h2Black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: toListSearch (uid, nick, context)
                  },
                  child: Text(
                    'Поиск списков',
                    style: h2Black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: toMyBooks (context) implementation
                  },
                  child: Text('Книги', style: h2Black),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

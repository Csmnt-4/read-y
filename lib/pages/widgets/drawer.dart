import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/extra/clippers.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: toProfile(uid, nick, context)
                  },
                  child: roundedContainer(
                    Text(
                      'профиль',
                      style: h2Black,
                    ),
                    null,
                    4,
                    cWh,
                    cBl,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: toListSearch (uid, nick, context)
                  },
                  child: roundedContainer(
                    Text(
                      'поиск списков',
                      style: h2Black,
                    ),
                    null,
                    4,
                    cWh,
                    cBl,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: toAddBook (context) implementation
                  },
                  child: roundedContainer(
                    Text(
                      'предложить кн..',
                      style: h2Black,
                    ),
                    null,
                    4,
                    cWh,
                    cBl,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  top: 20,
                ),
                child: TextButton(
                  onPressed: () {
                    // TODO: toMyBooks (context) implementation
                  },
                  child: roundedContainer(
                    Text(
                      'мои книги',
                      style: h2Black,
                    ),
                    null,
                    4,
                    cWh,
                    cBl,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

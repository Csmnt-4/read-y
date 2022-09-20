import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/books/all_books.dart';
import 'package:read_y/pages/extra/clippers.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';
import 'package:read_y/pages/list/all_lists.dart';

import '../../data/colors.dart';

Widget leftPanel(BuildContext context, uid, nick) {
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
                      style: h2BlackLowOp,
                    ),
                    null,
                    4,
                    cWh.withOpacity(0.5),
                    cBl.withOpacity(0.5),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AllAvailableLists(
                          uid: uid,
                          nick: nick,
                        ),
                      ),
                    );
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
                      style: h2BlackLowOp,
                    ),
                    null,
                    4,
                    cWh.withOpacity(0.5),
                    cBl.withOpacity(0.5),
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AllUserBooks(
                          uid: uid,
                          nick: nick,
                        ),
                      ),
                    );
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

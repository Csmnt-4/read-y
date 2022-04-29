import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:read_y/pages/router.dart';

import '../../models/requests/fetch.dart';
import '../widgets/loading_screen.dart';

Widget listPage(BuildContext context, String title, String listTitle) {
  return FutureBuilder(
    future: fetchList(listTitle),
    builder: (BuildContext context, AsyncSnapshot snap) {
      if (!snap.hasData) {
        print("snap: ");
        print(snap.data);
        return loadingScreen(context);
      } else {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xffFFFAFF),
              child: Center(
                child: Image.asset(
                  "assets/lists_bottom.png",
                  width: 420,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: snap.data['title'].length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = snap.data['title'][index];
                          return
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.only(left: 3, bottom: 3),
                                decoration: BoxDecoration(
                                  border:
                                  Border.all(color: Color(0xffFFFAFF), width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                                ),
                                child: Text(
                                  " " + item + " ",
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Color(0xffFFFAFF),
                                  ),
                                ),
                              ),
                            );
                        },),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    },
  );
}

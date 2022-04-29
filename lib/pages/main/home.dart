import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/requests/fetch.dart';
import '../widgets/loading_screen.dart';

Widget homePage(BuildContext context, String title) {
  return FutureBuilder(
    future: fetchHome("'0'"),
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
                  "assets/home_bottom.png",
                  width: 420,
                  fit: BoxFit.fitWidth,),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 200.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 97, top: 8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0xffFFFAFF), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: Text(
                          " списков: " + snap.data['lists'] + " ",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xffFFFAFF),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 70, top: 12.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0xffFFFAFF), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: Text(
                          " завершено: " + snap.data['complete'] + " ",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xffFFFAFF),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 60, top: 12.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                        decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0xffFFFAFF), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: Text(
                          " прочитано: " + snap.data['read'] + " ",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xffFFFAFF),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 60, top: 40.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                        decoration: BoxDecoration(
                          color: Color(0xffFFFAFF),
                          border:
                          Border.all(color: Color(0xffFFFAFF), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: Text(
                          "  в процессе:  ",
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff292931),
                          ),
                        ),
                      ),
                    ),
                    Container(alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 60),
                      child: Container(
                        padding: EdgeInsets.only(left: 2, right: 2, bottom: 3),
                        decoration: BoxDecoration(
                          color: Color(0xffFFFAFF),
                          border: Border.all(color: Color(0xffFFFAFF), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(40.0)),),
                        child: Text(
                          "  " + snap.data['next'],
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xff292931),
                          ),),
                        ),
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

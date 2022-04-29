import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/requests/fetch.dart';
import '../router.dart';
import '../widgets/loading_screen.dart';

int pressed = 0;
String genreHolder = '';

String yearHolder = '';

String diffHolder = '';

class GenreDropButtonWidget extends StatefulWidget {
  const GenreDropButtonWidget({Key? key}) : super(key: key);

  @override
  State<GenreDropButtonWidget> createState() => _GenreDropButtonWidgetState();
}

class _GenreDropButtonWidgetState extends State<GenreDropButtonWidget> {
  String genreValue = 'Жанр';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: genreValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: GoogleFonts.manrope(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color(0xff292931),
      ),
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
      onChanged: (String? newValue) {
        setState(() {
          genreValue = newValue!;
          genreHolder = genreValue;
        });
      },
      items: <String>[
        "Жанр",
        'Драма',
        'Повесть',
        'Поэмы',
        'Эпик',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class YearDropButtonWidget extends StatefulWidget {
  const YearDropButtonWidget({Key? key}) : super(key: key);

  @override
  State<YearDropButtonWidget> createState() => _YearDropButtonWidgetState();
}

class _YearDropButtonWidgetState extends State<YearDropButtonWidget> {
  String yearValue = 'Годы';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: yearValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: GoogleFonts.manrope(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color(0xff292931),
      ),
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
      onChanged: (String? newValue) {
        setState(() {
          yearValue = newValue!;
          yearHolder = yearValue;
        });
      },
      items: <String>[
        "Годы",
        '1900',
        '1920',
        '1940',
        '1960',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DiffDropButtonWidget extends StatefulWidget {
  const DiffDropButtonWidget({Key? key}) : super(key: key);

  @override
  State<DiffDropButtonWidget> createState() => _DiffDropButtonWidgetState();
}

class _DiffDropButtonWidgetState extends State<DiffDropButtonWidget> {
  String diffValue = 'Сложность';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: diffValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: GoogleFonts.manrope(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Color(0xff292931),
      ),
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
      onChanged: (String? newValue) {
        setState(() {
          diffValue = newValue!;
          diffHolder = diffValue;
        });
      },
      items: <String>[
        "Сложность",
        '1',
        '2',
        '3',
        '4',
        '5',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

Widget createPage(BuildContext context, String title) {
  return FutureBuilder(
    future: fetchNewList(genreHolder, yearHolder, diffHolder),
    builder: (BuildContext context, AsyncSnapshot snap) {
      if (!snap.hasData) {
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
                  "assets/create_bottom.png",
                  width: 420,
                  fit: BoxFit.fitWidth,
                  // margin: EdgeInsets.all(100.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(
                              top: 3, bottom: 3, right: 3, left: 10),
                          decoration: BoxDecoration(
                            color: Color(0xffFFFAFF),
                            border: Border.all(
                                color: Color(0xffFFFAFF), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0)),
                          ),
                          child: GenreDropButtonWidget()),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 3, bottom: 3, right: 3, left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFAFF),
                              border: Border.all(
                                  color: Color(0xffFFFAFF), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: YearDropButtonWidget()),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                            padding: EdgeInsets.only(
                                top: 3, bottom: 3, right: 3, left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFAFF),
                              border: Border.all(
                                  color: Color(0xffFFFAFF), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: DiffDropButtonWidget()),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            // print(genreHolder);
                            // print(yearHolder);
                            // print(diffHolder);
                            toNewList(
                                context, genreHolder, yearHolder, diffHolder);
                          },
                          child: Container(
                            padding:
                                EdgeInsets.only(bottom: 3, right: 3, left: 4),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffFFFAFF), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: Text(
                              " создать ",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xffFFFAFF),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            toNewList(context, '', '', '');
                          },
                          child: Container(
                            padding:
                                EdgeInsets.only(bottom: 3, right: 3, left: 4),
                            decoration: BoxDecoration(
                              color: Color(0xffFFFAFF),
                              border: Border.all(
                                  color: Color(0xffFFFAFF), width: 2.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0)),
                            ),
                            child: Text(
                              " сохранить ",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Color(0xff292931),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  snap.data['title'] != null
                      ? ListView.builder(
                        itemCount: snap.data['title'].length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = snap.data['title'][index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding:
                                  EdgeInsets.only(left: 3, bottom: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xffFFFAFF), width: 2.0),
                                borderRadius: BorderRadius.all(
                                    Radius.circular(40.0)),
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
                        },
                      )
                      : Text(""),
                ],
              ),
            ),
          ],
        );
      }
    },
  );
}

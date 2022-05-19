import 'package:flutter/material.dart';
import 'package:read_y/data/colors.dart';
import 'package:read_y/data/firebase_data_service.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';
import 'package:read_y/pages/extra/sliding.dart';

import '../list_view/new_list_raw.dart';

class NewList extends StatefulWidget {
  const NewList({Key? key, required this.uid, this.nick}) : super(key: key);

  final nick;
  final uid;

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  List<String> selectedGenres = [];
  List<String> selectedCentury = [];
  double count = 10.0;

  @override
  Widget build(BuildContext context) {
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

    List<String> century = [
      "XI",
      "XII",
      "XIII",
      "XIV",
      "XV",
      "XVI",
      "XVII",
      "XVIII",
      "XIX",
      "XX",
      "XXI"
    ];

    return Scaffold(
      backgroundColor: cWh,
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(125),
          //   bottomLeft: Radius.circular(125),
          // ),
          color: cBl,
          // shape:,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                15,
                20,
                0,
                0,
              ),
              child: Row(
                children: [
                  roundedContainer(
                    Text("жанры:", style: h2White),
                    null,
                    3,
                    cBl,
                    cWh,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                10,
                2,
                10,
                0,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 9,
                runSpacing: 0,
                children: genres
                    .map(
                      (e) =>
                      ElevatedButton(
                        onPressed: () {
                          if (selectedGenres.isEmpty) {
                            selectedGenres.add(e);
                          } else {
                            selectedGenres.contains(e)
                                ? selectedGenres.remove(e)
                                : selectedGenres.add(e);
                          }
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          primary: selectedGenres.contains(e) ? cPu : cWh,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: selectedGenres.contains(e) ? cPu : cWh),
                          ),
                        ),
                        child: Text(
                          e,
                          style: selectedGenres.contains(e) ? h4White : h4Black,
                        ),
                      ),
                )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
              child: Row(
                children: [
                  roundedContainer(
                      Text(
                        "век:",
                        style: h2White,
                      ),
                      null,
                      3,
                      cBl,
                      cWh),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 2, 10, 0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 9,
                runSpacing: 0,
                children: century
                    .map(
                      (e) =>
                      ElevatedButton(
                        onPressed: () {
                          setState(
                                () {
                              if (selectedCentury.isEmpty) {
                                selectedCentury.add(e);
                              } else if (selectedCentury.contains(e) &&
                                  selectedCentury.length == 1) {
                                selectedCentury.remove(e);
                              } else {
                                if (selectedCentury.contains(e)) {
                                  if (e == century[0] &&
                                      selectedCentury.length > 1) {
                                    if (selectedCentury.contains(
                                        century[century.indexOf(e) + 1])) {
                                      selectedCentury.remove(e);
                                    }
                                  } else if (e == century[10] &&
                                      selectedCentury.length > 1) {
                                    if (selectedCentury.contains(
                                        century[century.indexOf(e) - 1])) {
                                      selectedCentury.remove(e);
                                    }
                                  } else if (!selectedCentury.contains(
                                      century[century.indexOf(e) + 1]) &&
                                      selectedCentury.contains(
                                          century[century.indexOf(e) - 1])) {
                                    selectedCentury.remove(e);
                                  } else if (selectedCentury.contains(
                                      century[century.indexOf(e) + 1]) &&
                                      !selectedCentury.contains(
                                          century[century.indexOf(e) - 1])) {
                                    selectedCentury.remove(e);
                                  }
                                } else {
                                  if (e == century[0]) {
                                    if (selectedCentury.contains(
                                        century[century.indexOf(e) + 1])) {
                                      selectedCentury.add(e);
                                    }
                                  } else if (e == century[10] &&
                                      selectedCentury.contains(
                                          century[century.indexOf(e) - 1])) {
                                    selectedCentury.add(e);
                                  } else if (selectedCentury.contains(
                                      century[century.indexOf(e) + 1]) ||
                                      selectedCentury.contains(
                                          century[century.indexOf(e) - 1])) {
                                    selectedCentury.add(e);
                                  }
                                }
                              }
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: selectedCentury.contains(e) ? cPu : cWh,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(90.0),
                            side: BorderSide(
                                color: selectedCentury.contains(e) ? cPu : cWh),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: Text(
                            e,
                            style:
                            selectedCentury.contains(e) ? h4White : h4Black,
                          ),
                        ),
                      ),
                )
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                15,
                5,
                0,
                0,
              ),
              child: Row(
                children: [
                  roundedContainer(
                      Text(
                        "длина:",
                        style: h2White,
                      ),
                      null,
                      3,
                      cBl,
                      cWh),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: roundedContainer(
                Slider(
                  activeColor: cBl,
                  inactiveColor: cBl,
                  min: 10,
                  max: 100,
                  divisions: 90,
                  value: count,
                  label: count.round().toString(),
                  onChanged: (double value) {
                    setState(
                          () {
                        count = value;
                      },
                    );
                  },
                ),
                null,
                0,
                cWh,
                cWh,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100),
                    child: TextButton(
                      onPressed: () {
                        var trueCentury = [];
                        for (var element in selectedCentury) {
                          trueCentury.add(
                            getCentury(element),
                          );
                        }
                        selectedCentury.sort();
                        trueCentury.sort();
                        Navigator.of(context).push(
                          SlideRightRoute(
                            page: BookList(
                                nickname: widget.nick,
                                genres: selectedGenres,
                                trueCentury: trueCentury,
                                century: selectedCentury,
                                percent: count,
                                uid: widget.uid),
                          ),
                        );
                      },
                      child: roundedContainer(
                          Text(
                            "создать",
                            style: h2White,
                          ),
                          null,
                          3,
                          cPu,
                          cPu),
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.topRight,
                    child: TextButton(
                      onPressed: () =>
                      {
                        Navigator.of(context).pop(),
                      },
                      child: Text(
                        "<-",
                        style: h2Art,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

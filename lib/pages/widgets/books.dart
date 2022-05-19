import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';

import '../../data/colors.dart';
import '../extra/rounded_containers.dart';

String? getBookState(String key) {
  switch (key) {
    case "ns":
      return " ";
    case "ip":
      return "~";
    case "fi":
      return "v";
    case "ab":
      return "x";
  }
  return null;
}

class Books extends StatefulWidget {
  const Books({Key? key, required this.books}) : super(key: key);
  final books;

  @override
  State<Books> createState() => _BooksState();
}

class _BooksState extends State<Books> {
  List<String> states = [
    "ns",
    "ip",
    "fi",
    "ab",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        String key = widget.books.keys.elementAt(index);
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              roundedContainer(
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      "${widget.books[key]!["author"]} - $key",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: h3Black,
                    ),
                  ),
                  MediaQuery.of(context).size.width * 0.75,
                  0,
                  cWh,
                  cWh),
              ElevatedButton(
                onPressed: () => {
                  setState(() {
                    String bookState = widget.books[key]!["state"].toString();
                    if (bookState == "ab") {
                      widget.books[key]!["state"] = "ns";
                    } else {
                      widget.books[key]!["state"] =
                          states[states.indexOf(bookState) + 1];
                    }
                  })
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: cWh, // <-- Button color
                  // <-- Splash color
                ),
                child: Text(
                  getBookState(
                    widget.books[key]!["state"].toString(),
                  ).toString(),
                  style: h4Black,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class FilteredBooks extends StatefulWidget {
  const FilteredBooks({Key? key, required this.books}) : super(key: key);
  final Map<String, Map<String, String>> books;

  @override
  State<FilteredBooks> createState() => _FilteredBooksState();
}

class _FilteredBooksState extends State<FilteredBooks> {
  List<String> states = ["ns", "ip", "fi", "ab"];

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, String>> all =
        Map<String, Map<String, String>>.from(widget.books);
    Map<String, Map<String, String>> finished =
        Map<String, Map<String, String>>.from(widget.books);
    Map<String, Map<String, String>> abandoned =
        Map<String, Map<String, String>>.from(widget.books);
    finished.removeWhere((key, value) => value['state'] != "fi");
    abandoned.removeWhere((key, value) => value['state'] != "ab");
    all.removeWhere((key, value) => value['state'] == "fi");
    all.removeWhere((key, value) => value['state'] == "ab");
    log(
      all.toString(),
    );
    return ListView(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: all.length,
          itemBuilder: (context, index) {
            String key = all.keys.elementAt(index);
            return Padding(
              padding: const EdgeInsets.only(left:
                20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roundedContainer(
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        0,
                        5,
                        0,
                        5,
                      ),
                      child: Text(
                        "${all[key]!["author"]} - $key",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: h2Black,
                      ),
                    ),
                    MediaQuery.of(context).size.width * 0.75,
                    0,
                    cWh,
                    cWh,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      setState(
                        () {
                          String bookState = all[key]!["state"].toString();
                          if (bookState == "ab") {
                            widget.books[key]!["state"] = "ns";
                          } else {
                            widget.books[key]!["state"] =
                                states[states.indexOf(bookState) + 1];
                          }
                        },
                      )
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: cWh, // <-- Button color
                      // <-- Splash color
                    ),
                    child: Text(
                      getBookState(
                        all[key]!["state"].toString(),
                      ).toString(),
                      style: h4Black,
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Visibility(
          visible: abandoned.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              15,
              15,
              0,
              0,
            ),
            child: Row(
              children: [
                roundedContainer(
                  Text(
                    "отложены:",
                    style: h4White,
                  ),
                  null,
                  0,
                  cBl,
                  cWh,
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: abandoned.length,
          itemBuilder: (context, index) {
            String key = abandoned.keys.elementAt(index);
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                15,
                0,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roundedContainer(
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          0,
                          5,
                          0,
                          5,
                        ),
                        child: Text(
                          "${abandoned[key]!["author"]} - $key",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: p1Black,
                        ),
                      ),
                      MediaQuery.of(context).size.width * 0.75,
                      0,
                      cWh,
                      cWh),
                  ElevatedButton(
                    onPressed: () => {
                      setState(
                        () {
                          String bookState =
                              widget.books[key]!["state"].toString();
                          if (bookState == "ab") {
                            widget.books[key]!["state"] = "ns";
                          } else {
                            widget.books[key]!["state"] =
                                states[states.indexOf(bookState) + 1];
                          }
                        },
                      )
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: cWh,
                    ),
                    child: Text(
                      getBookState(
                        abandoned[key]!["state"].toString(),
                      ).toString(),
                      style: h4Black,
                    ),
                  )
                ],
              ),
            );
          },
        ),
        Visibility(
          visible: finished.isNotEmpty,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              15,
              15,
              0,
              0,
            ),
            child: Row(
              children: [
                roundedContainer(
                  Text(
                    "прочитаны:",
                    style: h4White,
                  ),
                  null,
                  0,
                  cBl,
                  cWh,
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: finished.length,
          itemBuilder: (context, index) {
            String key = finished.keys.elementAt(index);
            return Padding(
              padding: const EdgeInsets.fromLTRB(
                20,
                15,
                0,
                0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  roundedContainer(
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          0,
                          5,
                          0,
                          5,
                        ),
                        child: Text(
                          "${finished[key]!["author"]} - $key",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: p1Black,
                        ),
                      ),
                      MediaQuery.of(context).size.width * 0.75,
                      0,
                      cWh,
                      cWh),
                  ElevatedButton(
                    onPressed: () => {
                      setState(
                        () {
                          log(key);
                          String bookState =
                              widget.books[key]!["state"].toString();
                          if (bookState == "ab") {
                            widget.books[key]!["state"] = "ns";
                          } else {
                            widget.books[key]!["state"] =
                                states[states.indexOf(bookState) + 1];
                          }
                        },
                      )
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      primary: cWh, // <-- Button color
                      // <-- Splash color
                    ),
                    child: Text(
                      getBookState(
                        finished[key]!["state"].toString(),
                      ).toString(),
                      style: h4Black,
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

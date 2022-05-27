import 'package:flutter/material.dart';
import 'package:read_y/data/firebase_data_service.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/list/web_view/web.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    var bookList = widget.books['displayMap'];
    return ListView.builder(
      shrinkWrap: true,
      itemCount: bookList.length,
      itemBuilder: (context, index) {
        String key = bookList.keys.elementAt(index);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            roundedContainer(
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Text(
                    "${bookList[key]["author"]} - ${bookList[key]["title"]}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: h3Black,
                  ),
                ),
                MediaQuery.of(context).size.width * 0.75,
                0,
                cWh,
                cWh),
            TextButton(
                onPressed: () => {
                      setState(() {
                        String bookState = bookList[key]["state"].toString();
                        if (bookState == "ab") {
                          bookList[key]["state"] = "ns";
                        } else {
                          bookList[key]["state"] =
                              states[states.indexOf(bookState) + 1];
                        }
                      })
                    },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: cWh,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      getBookState(
                        bookList[key]["state"].toString(),
                      ).toString(),
                      style: h3Black,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ))
          ],
        );
      },
    );
  }
}

class FilteredBooks extends StatefulWidget {
  const FilteredBooks({Key? key, required this.books, this.uid})
      : super(key: key);
  final Map<String, dynamic> books;
  final uid;

  @override
  State<FilteredBooks> createState() => _FilteredBooksState();
}

class _FilteredBooksState extends State<FilteredBooks> {
  List<String> states = ["ns", "ip", "fi", "ab"];

  @override
  Widget build(BuildContext context) {
    var bookList = widget.books['displayMap'];
    Map<String, dynamic> all = Map<String, dynamic>.from(bookList!);
    Map<String, dynamic> finished = Map<String, dynamic>.from(bookList);
    Map<String, dynamic> abandoned = Map<String, dynamic>.from(bookList);

    finished.removeWhere((key, value) => value['state'] != "fi");
    abandoned.removeWhere((key, value) => value['state'] != "ab");

    all.removeWhere((key, value) => value['state'] == "fi");
    all.removeWhere((key, value) => value['state'] == "ab");

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: all.length,
            itemBuilder: (context, index) {
              String key = all.keys.elementAt(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WebPage(
                            nick: "",
                            url: bookList[key]['url'],
                          ),
                        ),
                      );
                      // to WebView(initialUrl: bookList[key]['url'],);
                    },
                    child: roundedContainer(
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text(
                            '${bookList[key]!["author"]} - ${bookList[key]!["title"]}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: h3Black,
                          ),
                        ),
                        MediaQuery.of(context).size.width * 0.75,
                        0,
                        cWh,
                        cWh),
                  ),
                  TextButton(
                      onPressed: () => {
                            setState(
                              () {
                                String bookState =
                                    bookList[key]["state"].toString();
                                if (bookState == "ab") {
                                  bookList[key]["state"] = "ns";
                                  setBookState(
                                      widget.uid, bookList[key]['id'], 'ns');
                                } else {
                                  bookList[key]["state"] =
                                      states[states.indexOf(bookState) + 1];
                                  setBookState(widget.uid, bookList[key]['id'],
                                      states[states.indexOf(bookState) + 1]);
                                }
                              },
                            )
                          },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: cWh,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            getBookState(
                              bookList[key]["state"].toString(),
                            ).toString(),
                            style: h3Black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                ],
              );
            },
          ),
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
                    style: h2White,
                  ),
                  null,
                  4,
                  cBl,
                  cWh,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: abandoned.length,
            itemBuilder: (context, index) {
              String key = abandoned.keys.elementAt(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: roundedContainer(
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          "${bookList[key]!["author"]} - ${bookList[key]!["title"]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: h3Black,
                        ),
                      ),
                      MediaQuery.of(context).size.width * 0.75,
                      0,
                      cWh,
                      cWh,
                    ),
                  ),
                  TextButton(
                      onPressed: () => {
                            setState(
                              () {
                                String bookState =
                                    bookList[key]!["state"].toString();
                                if (bookState == "ab") {
                                  bookList[key]["state"] = "ns";
                                  setBookState(
                                      widget.uid, bookList[key]['id'], 'ns');
                                } else {
                                  bookList[key]["state"] =
                                      states[states.indexOf(bookState) + 1];
                                  setBookState(widget.uid, bookList[key]['id'],
                                      states[states.indexOf(bookState) + 1]);
                                }
                              },
                            ),
                          },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: cWh,
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            getBookState(
                              bookList[key]!["state"].toString(),
                            ).toString(),
                            style: h3Black,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                ],
              );
            },
          ),
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
                    style: h2White,
                  ),
                  null,
                  4,
                  cBl,
                  cWh,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: finished.length,
            itemBuilder: (context, index) {
              String key = finished.keys.elementAt(index);
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: roundedContainer(
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          "${bookList[key]!["author"]} - ${bookList[key]!["title"]}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: h3Black,
                        ),
                      ),
                      MediaQuery.of(context).size.width * 0.75,
                      0,
                      cWh,
                      cWh,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {
                      setState(
                        () {
                          String bookState = bookList[key]!["state"].toString();
                          if (bookState == "ab") {
                            bookList[key]["state"] = "ns";
                            setBookState(widget.uid, bookList[key]['id'], 'ns');
                          } else {
                            bookList[key]["state"] =
                                states[states.indexOf(bookState) + 1];
                            setBookState(widget.uid, bookList[key]['id'],
                                states[states.indexOf(bookState) + 1]);
                          }
                        },
                      ),
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: cWh,
                        shape: BoxShape.circle,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          getBookState(
                            bookList[key]!["state"].toString(),
                          ).toString(),
                          style: h3Black,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

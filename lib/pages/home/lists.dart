import 'package:flutter/material.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';
import 'package:read_y/pages/list/list_view/list.dart';
import 'package:read_y/pages/widgets/loading_screen.dart';

import '../../../data/colors.dart';
import '../../../data/firebase_data_service.dart';
import '../../../data/fonts.dart';

String? getListState(String key) {
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

class ListsPage extends StatefulWidget {
  const ListsPage(BuildContext context,
      {Key? key, required this.userId, this.nick, this.animate})
      : super(key: key);

  // (, userId, nickname)
  final userId;
  final nick;
  final animate;

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  List<String> states = ["ns", "ip", "fi", "ab"];

  @override
  Widget build(BuildContext context) {
    final uid = widget.userId;
    return FutureBuilder(
      future: fetchUserLists(uid),
      builder: (BuildContext context, AsyncSnapshot snap) {
        if (!snap.hasData) {
          return loadingScreen(
            context,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          );
        } else {
          Map<String, dynamic> all = Map<String, dynamic>.from(snap.data);
          Map<String, dynamic> finished = Map<String, dynamic>.from(snap.data);
          Map<String, dynamic> abandoned = Map<String, dynamic>.from(snap.data);

          finished.removeWhere(
            (key, value) => value['state'] != "fi",
          );
          abandoned.removeWhere(
            (key, value) => value['state'] != "ab",
          );

          all.removeWhere(
            (key, value) => value['state'] == "fi",
          );
          all.removeWhere(
            (key, value) => value['state'] == "ab",
          );
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  30,
                  0,
                  0,
                ),
                child: Row(
                  children: [
                    roundedContainer(
                      Text(
                        "ваши списки:",
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
              (all.isEmpty && finished.isEmpty && abandoned.isEmpty)
                  ? Container(
                      height: MediaQuery.of(context).size.height - 170,
                      child: TextButton(
                        onPressed: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () {
                                widget.animate;
                              },
                              child: roundedContainer(
                                Text(
                                  "пока что тут пусто!",
                                  style: h2Black,
                                ),
                                null,
                                4,
                                cWh,
                                cBl,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView(
                      shrinkWrap: true,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                            left: 15,
                            right: 10,
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: all.length,
                            itemBuilder: (
                              context,
                              index,
                            ) {
                              String key = all.keys.elementAt(index);
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UserBookList(
                                            uid: uid,
                                            nick: widget.nick,
                                            listId: snap.data[key]['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: roundedContainer(
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          5,
                                        ),
                                        child: Text(
                                          snap.data[key]['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: h3Black,
                                        ),
                                      ),
                                      MediaQuery.of(context).size.width * 0.7,
                                      0,
                                      cWh,
                                      cBl,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      setState(
                                        () {
                                          String listState = snap
                                              .data[key]!["state"]
                                              .toString();
                                          if (listState == "ab") {
                                            snap.data[key]!["state"] = "ns";
                                            setListState(uid,
                                                snap.data[key]['id'], 'ns');
                                          } else {
                                            snap.data[key]!["state"] = states[
                                                states.indexOf(listState) + 1];
                                            setListState(
                                              uid,
                                              snap.data[key]['id'],
                                              states[states.indexOf(listState) +
                                                  1],
                                            );
                                          }
                                        },
                                      )
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cBl,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(90),
                                          topRight: Radius.circular(90),
                                          bottomLeft: Radius.circular(90),
                                          bottomRight: Radius.circular(90),
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          top: 1,
                                          left: 1,
                                          bottom: 1,
                                          right: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: cWh,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(90),
                                            topRight: Radius.circular(90),
                                            bottomLeft: Radius.circular(90),
                                            bottomRight: Radius.circular(90),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            snap.data[key]!["state"]
                                                        .toString() ==
                                                    'ns'
                                                ? '       '
                                                : "${getListState(
                                                    snap.data[key]!["state"]
                                                        .toString(),
                                                  )}    ",
                                            style: h3Black,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: abandoned.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              20,
                              10,
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
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: abandoned.length,
                            itemBuilder: (context, index) {
                              String key = abandoned.keys.elementAt(index);
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UserBookList(
                                            uid: uid,
                                            nick: widget.nick,
                                            listId: snap.data[key]['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: roundedContainer(
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          0,
                                          5,
                                          0,
                                          5,
                                        ),
                                        child: Text(
                                          snap.data[key]['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: h3Black,
                                        ),
                                      ),
                                      MediaQuery.of(context).size.width * 0.7,
                                      0,
                                      cWh,
                                      cBl,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      setState(
                                        () {
                                          String listState = snap
                                              .data[key]!["state"]
                                              .toString();
                                          if (listState == "ab") {
                                            snap.data[key]!["state"] = "ns";
                                            setListState(uid,
                                                snap.data[key]['id'], 'ns');
                                          } else {
                                            snap.data[key]!["state"] = states[
                                                states.indexOf(listState) + 1];
                                            setListState(
                                              uid,
                                              snap.data[key]['id'],
                                              states[states.indexOf(listState) +
                                                  1],
                                            );
                                          }
                                        },
                                      )
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cBl,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(90),
                                          topRight: Radius.circular(90),
                                          bottomLeft: Radius.circular(90),
                                          bottomRight: Radius.circular(90),
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          top: 1,
                                          left: 1,
                                          bottom: 1,
                                          right: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: cWh,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(90),
                                            topRight: Radius.circular(90),
                                            bottomLeft: Radius.circular(90),
                                            bottomRight: Radius.circular(90),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "${getListState(
                                              snap.data[key]!["state"]
                                                  .toString(),
                                            )}    ",
                                            style: h3Black,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: finished.isNotEmpty,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              20,
                              10,
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
                          padding: const EdgeInsets.only(left: 15, right: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: finished.length,
                            itemBuilder: (context, index) {
                              String key = finished.keys.elementAt(index);
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UserBookList(
                                            uid: uid,
                                            nick: widget.nick,
                                            listId: snap.data[key]['id'],
                                          ),
                                        ),
                                      );
                                    },
                                    child: roundedContainer(
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: Text(
                                          snap.data[key]['title'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: h3Black,
                                        ),
                                      ),
                                      MediaQuery.of(context).size.width * 0.7,
                                      0,
                                      cWh,
                                      cBl,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => {
                                      setState(
                                        () {
                                          String listState = snap
                                              .data[key]!["state"]
                                              .toString();
                                          if (listState == "ab") {
                                            snap.data[key]!["state"] = "ns";
                                            setListState(uid,
                                                snap.data[key]['id'], 'ns');
                                          } else {
                                            snap.data[key]!["state"] = states[
                                                states.indexOf(listState) + 1];
                                            setListState(
                                                uid,
                                                snap.data[key]['id'],
                                                states[
                                                    states.indexOf(listState) +
                                                        1]);
                                          }
                                        },
                                      )
                                    },
                                    // FIXME: Repetitive code
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: cBl,
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(90),
                                          topRight: Radius.circular(90),
                                          bottomLeft: Radius.circular(90),
                                          bottomRight: Radius.circular(90),
                                        ),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          top: 1,
                                          left: 1,
                                          bottom: 1,
                                          right: 1,
                                        ),
                                        decoration: BoxDecoration(
                                          color: cWh,
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(90),
                                            topRight: Radius.circular(90),
                                            bottomLeft: Radius.circular(90),
                                            bottomRight: Radius.circular(90),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "${getListState(
                                              snap.data[key]!["state"]
                                                  .toString(),
                                            )}    ",
                                            style: h3Black,
                                            textAlign: TextAlign.center,
                                          ),
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
                    ),
            ],
          );
        }
      },
    );
  }
}

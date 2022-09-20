import 'package:flutter/material.dart';
import 'package:read_y/data/firebase_data_service.dart';
import 'package:read_y/pages/home/main_page.dart';
import 'package:read_y/pages/widgets/loading_screen.dart';

import '../../../data/colors.dart';
import '../../../data/fonts.dart';
import '../../books/books.dart';
import '../../extra/rounded_containers.dart';

class ListInfo extends StatefulWidget {
  const ListInfo({
    Key? key,
    required this.listId,
    this.uid,
    this.nick,
    this.title,
    this.userId,
  }) : super(key: key);

  final title;
  final listId;
  final userId;
  final uid;
  final nick;
  @override
  State<ListInfo> createState() => _ListInfoState();
}

class _ListInfoState extends State<ListInfo> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: cBl,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 40, 0),
                            child: roundedContainer(
                              Text(widget.title,
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: h2White),
                              null,
                              8,
                              cBl,
                              cWh,
                            ),
                          ),
                          rotatedRoundedContainer(
                              Text("список", style: h4White), null, 10, cBl, cWh),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 40, 0),
                            child: roundedContainer(
                              Text(" Роман, трагедия",
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: h2White),
                              null,
                              8,
                              cBl,
                              cWh,
                            ),
                          ),
                          rotatedRoundedContainer(
                              Text("жанры", style: h4White), null, 10, cBl, cWh),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        roundedContainer(
                          Text(
                            "создано:               ",
                            style: h2White,
                          ),
                          null,
                          5,
                          cBl,
                          cWh,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 129, top: 2),
                          child: roundedContainer(
                            Text(
                              "vtor",
                              style: h2Black,
                            ),
                            null,
                            3,
                            cWh,
                            cBl,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        roundedContainer(
                          Text(
                            "века:                         ",
                            style: h2White,
                          ),
                          null,
                          5,
                          cBl,
                          cWh,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 88, top: 2),
                          child: roundedContainer(
                            Text(
                              "XIX - XX",
                              style: h2Black,
                            ),
                            null,
                            3,
                            cWh,
                            cBl,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: TextButton(
                  onPressed: () => {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MainPage(
                          context,
                          userId: widget.uid,
                          initialPage: 1,
                          nickname: widget.nick,
                        ),
                      ),
                    ),
                  },
                  child: Text(
                    "<-",
                    style: h2ArtWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

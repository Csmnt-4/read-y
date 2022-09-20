import 'package:flutter/material.dart';
import 'package:read_y/data/firebase_data_service.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';
import 'package:read_y/pages/home/main_page.dart';
import 'package:read_y/pages/widgets/appbar.dart';
import 'package:read_y/pages/widgets/loading_screen.dart';

import '../../../data/colors.dart';
import '../../../data/fonts.dart';
import 'list_view/list.dart';

class AllAvailableLists extends StatefulWidget {
  const AllAvailableLists({Key? key, required this.uid, this.nick})
      : super(key: key);
  final uid;
  final nick;

  @override
  State<AllAvailableLists> createState() => _AllAvailableListsState();
}

class _AllAvailableListsState extends State<AllAvailableLists> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          appBar(widget.nick, _scaffoldKey, MediaQuery.of(context).size.width),
      body: Container(
        decoration: BoxDecoration(
          color: cBl,
        ),
        child: Column(
          children: [
            FutureBuilder(
              future: fetchAllLists(),
              builder: (BuildContext context, AsyncSnapshot snap) {
                if (!snap.hasData) {
                  return loadingScreen(
                    context,
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  );
                } else {
                  Map<String, dynamic> all =
                      Map<String, dynamic>.from(snap.data);
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
                                "доступные списки:",
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
                      all.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              child: TextButton(
                                onPressed: () {},
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // widget.animate;
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
                                                  builder: (context) =>
                                                      UserBookList(
                                                    uid: widget.uid,
                                                    nick: widget.nick,
                                                    listId: snap.data[key]
                                                        ['id'],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: roundedContainer(
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                  0,
                                                  5,
                                                  0,
                                                  5,
                                                ),
                                                child: Text(
                                                  snap.data[key]['title'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: h3Black,
                                                ),
                                              ),
                                              MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              0,
                                              cWh,
                                              cBl,
                                            ),
                                          ),
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

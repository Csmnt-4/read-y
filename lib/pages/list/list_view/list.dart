import 'package:flutter/material.dart';
import 'package:read_y/data/firebase_data_service.dart';
import 'package:read_y/pages/home/main_page.dart';
import 'package:read_y/pages/widgets/loading_screen.dart';

import '../../../data/colors.dart';
import '../../../data/fonts.dart';
import '../../extra/rounded_containers.dart';
import '../../widgets/books.dart';

class UserBookList extends StatefulWidget {
  const UserBookList({
    Key? key,
    required this.listId,
    this.uid,
    this.nick,
  }) : super(key: key);
  final listId;
  final uid;
  final nick;

  @override
  State<UserBookList> createState() => _UserBookListState();
}

class _UserBookListState extends State<UserBookList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchList(widget.uid, widget.listId),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snap) {
        if (!snap.hasData) {
          return loadingScreen(context);
        } else {
          return Scaffold(
            body: Container(
              decoration: BoxDecoration(
                color: cBl,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(25, 0, 40, 0),
                                child: roundedContainer(
                                  Text(snap.data['title'],
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
                                  Text("????????????", style: h4White),
                                  null,
                                  10,
                                  cBl,
                                  cWh),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 10, 0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: cWh, shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        "i",
                                        textAlign: TextAlign.center,
                                        style: h3Black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      snap.data['books'] == null
                          ? const Text(
                              '??????-???? ?????????? ???? ??????...',
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.66,
                                child: FilteredBooks(
                                  books: {'displayMap': snap.data['books']},
                                  uid: widget.uid,
                                ),
                              ),
                            ),
                    ],
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
      },
    );
  }
}

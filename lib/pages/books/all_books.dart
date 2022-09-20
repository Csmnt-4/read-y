import 'package:flutter/material.dart';
import 'package:read_y/data/firebase_data_service.dart';
import 'package:read_y/pages/books/books.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';
import 'package:read_y/pages/home/main_page.dart';
import 'package:read_y/pages/widgets/appbar.dart';
import 'package:read_y/pages/widgets/loading_screen.dart';

import '../../../data/colors.dart';
import '../../../data/fonts.dart';

class AllUserBooks extends StatefulWidget {
  const AllUserBooks({Key? key, required this.uid, this.nick})
      : super(key: key);
  final uid;
  final nick;

  @override
  State<AllUserBooks> createState() => _AllUserBooksState();
}

class _AllUserBooksState extends State<AllUserBooks> {
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
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 25, 40, 0),
                  child: roundedContainer(
                    Text('ваши книги:',
                        textAlign: TextAlign.center,
                        softWrap: false,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: h2White),
                    null,
                    4,
                    cBl,
                    cWh,
                  ),
                ),
              ],
            ),
            FutureBuilder(
              future: fetchUserBooks(widget.uid),
              builder: (context, snap) {
                if (!snap.hasData) {
                  return loadingScreen(
                    context,
                    MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height,
                  );
                } else {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.64,
                    child: FilteredBooks(
                      books: {'displayMap': snap.data},
                      uid: widget.uid,
                    ),
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

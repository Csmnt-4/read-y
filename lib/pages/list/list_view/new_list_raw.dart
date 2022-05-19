import 'package:flutter/material.dart';
import 'package:read_y/data/colors.dart';
import 'package:read_y/data/firebase_data_service.dart';
import 'package:read_y/data/fonts.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';
import 'package:read_y/pages/list/list_view/book_list.dart';
import 'package:read_y/pages/widgets/appbar.dart';
import 'package:read_y/pages/widgets/books.dart';
import 'package:read_y/pages/widgets/loading_screen.dart';

class BookList extends StatefulWidget {
  const BookList(
      {Key? key,
      this.nickname,
      this.genres,
      this.century,
      this.trueCentury,
      this.percent,
      this.uid})
      : super(key: key);

  final nickname;
  final uid;
  final genres;
  final trueCentury;
  final century;
  final percent;

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return (widget.century != null && widget.genres != null)
        ? Scaffold(
            appBar: appBar(
                widget.nickname, widget.key, MediaQuery.of(context).size.width),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(125),
                    bottomRight: Radius.circular(125),
                  ),
                  color: cBl),
              child: ListView(
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
                                    Text(
                                        "${widget.century.first} - ${widget.century.last} столетие; Жанр: ${widget.genres[0]} и т.д.",
                                        textAlign: TextAlign.center,
                                        softWrap: false,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: h2White),
                                    null,
                                    8,
                                    cBl,
                                    cWh),
                              ),
                              rotatedRoundedContainer(
                                  Text("список", style: h4White),
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
                  FutureBuilder(
                    future: fetchBooks(widget.genres, widget.trueCentury,
                        widget.percent, widget.uid),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 100.0, bottom: 200.0),
                                child: Text(
                                  'Книг по вашим\nфильтрам нет...',
                                  style: h3White,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: cPu,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: cPu),
                                  ),
                                ),
                                child: Text(
                                  "к фильтрам!",
                                  style: h3White,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            ListView(
                              shrinkWrap: true,
                                children: [
                                  Books(
                                    books: snapshot.data,
                                  ),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      var books = snapshot.data;
                                      createList(widget.uid, books, null);
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => FilteredBookList(
                                              title:
                                                  "${widget.century.first} - ${widget.century.last} столетие; Жанр: ${widget.genres[0]} и т.д.",
                                              books: books)));
                                    },
                                    child: roundedContainer(
                                      Text(
                                        "сохранить",
                                        style: h1White,
                                      ),
                                      null,
                                      5,
                                      cPu,
                                      cPu,
                                    ),
                                  ),
                                  Align(
                                    alignment: FractionalOffset.topRight,
                                    child: TextButton(
                                      onPressed: () => {
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
                        );
                      }
                    },
                  ),
                ],
              ),
            ))
        : loadingScreen(context);
  }
}

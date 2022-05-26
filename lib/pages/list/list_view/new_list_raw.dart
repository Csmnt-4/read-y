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
    String listTitle;
    // TODO: Use different title: displayTitle!
    var displayTitle;
    var width = MediaQuery.of(context).size.width;

    widget.century.length >= 2
        ? {
            listTitle =
                '${widget.century.first} - ${widget.century.last} столетия; '
          }
        : listTitle = '${widget.century.first} век; ';

    widget.genres.length >= 2
        ? {listTitle += ' Жанры: ${widget.genres[0]} и т.д.'}
        : listTitle += ' Жанр: ${widget.genres[0]}';

    return (widget.century != null && widget.genres != null)
        ? Scaffold(
            appBar: appBar(
                widget.nickname, widget.key, MediaQuery.of(context).size.width),
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: cBl,
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
                                    Text(listTitle,
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
                                  'Книг по вашим\nфильтрам нет... пока!',
                                  style: h3White,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: roundedContainer(
                                  Text(
                                    "к фильтрам!",
                                    style: h2White,
                                  ),
                                  null,
                                  3,
                                  cPu,
                                  cPu,
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(25, 10, 5, 0),
                              child: Column(
                                children: <Books>[
                                  Books(
                                    books: snapshot.data,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      var books = snapshot.data;
                                      createList(widget.uid, books, listTitle);
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FilteredBookList(
                                            title:
                                                // FIXME: Actually, displayTitle...
                                                listTitle,
                                            books: books,
                                            uid: widget.uid,
                                            nick: widget.nickname,
                                          ),
                                        ),
                                      );
                                    },
                                    child: roundedContainer(
                                      Text(
                                        "сохранить",
                                        style: h2White,
                                      ),
                                      null,
                                      3,
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

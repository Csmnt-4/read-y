import 'package:flutter/material.dart';

import '../../../data/colors.dart';
import '../../../data/fonts.dart';
import '../../extra/rounded_containers.dart';
import '../../widgets/books.dart';

class FilteredBookList extends StatefulWidget {
  const FilteredBookList({Key? key, required this.books, this.title}) : super(key: key);
  final title;
  final books;

  @override
  State<FilteredBookList> createState() => _FilteredBookListState();
}

class _FilteredBookListState extends State<FilteredBookList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(125),
            bottomRight: Radius.circular(125),
          ),
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
                              Text(
                                  widget.title,
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
            StreamBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Text(
                    'Что-то пошло не так...',
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8057,
                      child: FilteredBooks(
                        books: widget.books,
                      ),
                    ),
                  );
                }
              },
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            //   child: Stack(
            //     children: [
            //       const Center(
            //         // child: ElevatedButton(
            //         //   onPressed: () {},
            //         //   style: ElevatedButton.styleFrom(
            //         //     primary: cPu,
            //         //     shape: RoundedRectangleBorder(
            //         //       borderRadius: BorderRadius.circular(18.0),
            //         //       side: BorderSide(color: cPu),
            //         //     ),
            //         //   ),
            //         //   child: Text(
            //         //     "сохранить",
            //         //     style: h3White,
            //         //   ),
            //         // ),
            //       ),
            //       Align(
            //         alignment: FractionalOffset.topRight,
            //         child: TextButton(
            //           onPressed: () => {
            //             Navigator.of(context).pop(),
            //           },
            //           child: Text(
            //             "<-",
            //             style: h2Art,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../data/colors.dart';
import '../../data/firebase_data_service.dart';
import '../../data/fonts.dart';
import '../widgets/loading_screen.dart';

Widget listsPage(BuildContext context, userId, nickname) {
  return FutureBuilder(
    future: fetchUserLists(userId),
    builder: (BuildContext context, AsyncSnapshot snap) {
      if (!snap.hasData) {
        return loadingScreen(context);
      } else {
        return Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: cWh,
              child: const Center(
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 20),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: cWh, width: 2.0),
                          borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            //
                            // Navigator.of(context).pushReplacement(
                            //     MaterialPageRoute(
                            //       builder: (context) => NewList(context, userId: userId, nickname: nickname,),
                            //     ),
                            // );
                            //
                          },
                          child: Text(
                            " новый список ",
                            style: p1White,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      //TODO: Redo for Firestore
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.builder(
                        itemCount: snap.data['title'].length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final item = snap.data['title'][index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: const EdgeInsets.only(left: 3, bottom: 3),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: cWh, width: 2.0),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(40.0)),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  //   Navigator.of(context).pushReplacement(
                                  //   MaterialPageRoute(
                                  //     builder: (context) => ReadList(context, userId: userId, nickname: nickname,),
                                  //   ),
                                  // );
                                },
                                child: Text(
                                  " $item ",
                                  style: p1White,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    },
  );
}

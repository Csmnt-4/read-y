import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:read_y/pages/extra/rounded_containers.dart';
import 'package:read_y/pages/list/list_create.dart';

import '../../../data/colors.dart';
import '../../../data/firebase_data_service.dart';
import '../../../data/fonts.dart';
import '../../widgets/loading_screen.dart';

Widget statisticsPage(BuildContext context, uid, nick) {
  return FutureBuilder(
    future: fetchStatistics(uid),
    builder: (BuildContext context, AsyncSnapshot snap) {
      if (!snap.hasData) {
        return loadingScreen(context);
      } else {
        return (Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: cWh,
            // shape: ,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  roundedContainer(
                    Text(
                      "списков: ${snap.data['lists']}",
                      style: h2White,
                    ),
                    null,
                    4,
                    cBl,
                    cWh,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ListCreate(
                            context,
                            nickname: nick,
                            userId: uid,
                          ),
                        ),
                      );
                    },
                    child: roundedContainer(
                      Text(
                        '+',
                        style: h3Black,
                      ),
                      null,
                      8,
                      cWh,
                      cBl,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: roundedContainer(
                  Text(
                    "завершено: ${snap.data['complete']}",
                    style: h2White,
                  ),
                  null,
                  3,
                  cBl,
                  cWh,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: roundedContainer(
                  Text(
                    "прочитано: ${snap.data['read']}",
                    style: h2White,
                  ),
                  null,
                  3,
                  cBl,
                  cWh,
                ),
              ),
              (snap.data['next']).length <= 6
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: roundedContainer(
                          Text(
                            "в процессе: ${snap.data['next']}",
                            style: h2Black,
                          ),
                          null,
                          3,
                          cWh,
                          cBl),
                    )
                  : Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Stack(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          roundedContainer(
                            Text(
                              "в процессе:\n",
                              style: h2White,
                            ),
                            null,
                            5,
                            cBl,
                            cWh,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 17, top: 39),
                            child: roundedContainer(
                              Text(
                                snap.data['next'],
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
              TextButton(
                onPressed: () async {
                  var snap = FirebaseFirestore.instance
                      .collection("lists")
                      .where("listId", isEqualTo: 'KmFOhbJ2CIgPXPfx2y2B');

                  var data = await snap.get().then((qSnap) => qSnap.docs);

                  Map<String, dynamic> lists = {};

                  data.forEach(
                    (e) {
                      lists = e.data()['books'];
                    },
                  );
                },
                child: roundedContainer(
                  Text(
                    '+',
                    style: h3Black,
                  ),
                  null,
                  8,
                  cWh,
                  cBl,
                ),
              ),
            ],
          ),
        ));
      }
    },
  );
}

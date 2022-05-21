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
                        style: h2Black,
                      ),
                      null,
                      4,
                      cWh,
                      cBl),
                  TextButton(
                    onPressed: () {
                      log('ListCreate.uid: $uid');
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
                    style: h2Black,
                  ),
                  null,
                  3,
                  cWh,
                  cBl,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: roundedContainer(
                  Text(
                    "прочитано: ${snap.data['read']}",
                    style: h2Black,
                  ),
                  null,
                  3,
                  cWh,
                  cBl,
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
                      child: roundedContainer(
                        Text(
                          "в процессе: ${snap.data['next']}",
                          style: h2Black,
                        ),
                        null,
                        3,
                        cWh,
                        cBl,
                      ),
                    ),
              TextButton(
                onPressed: () async {
                  // var ub = FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc('SIHKwohabjSF64GqsMhZxFqOzmG2');
                  // ub.collection('books').get().then((qSnap) => qSnap.docs[0],
                  //     onError: (e) => print("Something went wrong: $e"));
                  // log(ub.toString());

                  var snap = FirebaseFirestore.instance
                      .collection("users")
                      .where("id", isEqualTo: 'SIHKwohabjSF64GqsMhZxFqOzmG2');
                  // snap = snap.where('book', isEqualTo: true);
                  // snap = snap.where('state', isEqualTo: 'ip');

                  var data = await snap.get().then((qSnap) => qSnap.docs,
                      onError: (e) => print("Something went wrong: $e"));
                  //.where('state', isEqualTo: 'ip')
                  // ['books']
                  // log(data.toString());
                  // log(data['books'].toString());
                  data.forEach((e) {
                    log(e.toString());
                    log(e.data().toString());
                    // e.data().forEach((el) {
                    //   log(el.toString());
                    // });
                  });
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

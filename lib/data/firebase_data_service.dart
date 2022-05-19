import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, String>> fetchStatistics(userId) async {
  Map<String, String> map = {
    'lists': await fetchListCount(userId),
    'complete': await fetchCompleteListsCount(userId),
    'next': await fetchNextBook(userId),
    'read': await fetchReadBooksCount(userId),
  };
  return map;
}

Future<String> fetchListCount(userId) async {
  try {
    var snap = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId)
        .get()
        .then((qSnap) => qSnap.docs[0],
            onError: (e) => print("Something went wrong: $e"));
    var count = snap['lists'].length;
    // print(snap.length);
    return count.toString();
  } catch (e) {
    return '0';
  }
}

Future<String> fetchCompleteListsCount(userId) async {
  try {
    var snap = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId)
        .get()
        .then((qSnap) => qSnap.docs[0],
            onError: (e) => print("Something went wrong: $e"));

    var count = 0;
    snap['lists'].forEach((elem) {
      if (elem['state'] == 'ip') {
        count++;
      }
    });
    // print(snap.length);
    return count.toString();
  } catch (e) {
    return '0';
  }
}

Future<String> fetchReadBooksCount(userId) async {
  try {
    var snap = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId)
        .get()
        .then((qSnap) => qSnap.docs[0],
            onError: (e) => print("Something went wrong: $e"));

    var count = 0;
    snap['lists'].forEach((elem) {
      if (elem['state'] == 'fi') {
        count++;
      }
    });
    return count.toString();
  } catch (e) {
    return '0';
  }
}

Future<String> fetchNextBook(userId) async {
  try {
    var snap = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId)
        .get()
        .then((qSnap) => qSnap.docs[0],
            onError: (e) => print("Something went wrong: $e"));
    snap['books'].forEach((elem) {
      if (elem['state'] == 'ip') {
        return elem.toString();
      } else {return snap['books']['title'].toString();}
    });
    return 'Ничего';
  } catch (e) {
    return 'Ничего';
  }
}

Future<Map<String, List>> fetchLists(userId) async {
  return {
    'nothing': ['nothing'],
  };
}

Future<Map<String, Map<String, String>>?> fetchBooks(
    genres, centuries, percent, uid) async {
  Query<Map<String, dynamic>> conn = FirebaseFirestore.instance.collection("books");
  conn = conn.where("date", isGreaterThan: centuries[0]);
  conn = conn.where("date", isLessThan: centuries.last);

  var snap = await conn.get().then((qSnap) => qSnap.docs,
      onError: (e) => print("Something went wrong: $e"));
  List titles = [];
  List authors = [];
  List states = [];

  for (var element in snap) {
      // log('2');
    titles.add(
      element['title'],
    );
      // log('1');
    authors.add(
      element['author'],
    );
  }
  titles.forEach((element) async {
    var state = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: uid)
        .get()
        .then(
          (qSnap) => qSnap.docs[0],
          onError: (e) => print("Something went wrong: " + e),
        );
    print(state);
    states.add(state['books'][element]['state']);
  });

  Map<String, Map<String, String>> m = {};

  await Future<void>.delayed(
    const Duration(milliseconds: 500),
  );
  titles.forEach((element) async {
    if (titles.indexOf(element) < states.length) {
      m[element] = {
  'author': authors[titles.indexOf(element)],
  'state': states[titles.indexOf(element)],
  };} else {
  m[element] = {
  'author': authors[titles.indexOf(element)],
  'state': 'ns',
  };
    }
    },
  );
  if (m.isEmpty){
    return null;
  } else {
  return m;
  }
}

Future<Map<String, List>> fetchNewList(genre, year, diff) async {
  return {
    'title': ["No"],
    'state': ["Not started"],
  };
}

void createList() {}

void setList(userId, listId) {}

void setListState(userId, listId) {}

void setBookState() {}

int getCentury(String key) {
  switch (key) {
    case "XI":
      return 1000000;
    case "XII":
      return 11000000;
    case "XIII":
      return 12000000;
    case "XIV":
      return 13000000;
    case "XV":
      return 14000000;
    case "XVI":
      return 15000000;
    case "XVII":
      return 16000000;
    case "XVIII":
      return 17000000;
    case "XX":
      return 19000000;
    case "XXI":
      return 20000000;
    case "XIX":
    default:
      return 18000000;
  }
}

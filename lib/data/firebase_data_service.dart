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

Future<void> createList(userId, books, listTitle) async {
  try {
    var list = FirebaseFirestore.instance.collection('lists').doc();
    var user = FirebaseFirestore.instance.collection('users').doc(userId);
    Map<String, dynamic> filteredBooks = {};
    var listId = list.id;
    var bookMap = books['listMap'];
    var displayedMap = books['displayMap'];

    for (var book in bookMap.keys) {
      if (displayedMap[book]['state'].toString() == 'ns') {
        var bookState = {
          "books.${bookMap[book]['id']}": {
            'title': bookMap[book]['title'],
            'author': bookMap[book]['author'],
            'url': bookMap[book]['url'],
            'state': 'ns',
          },
        };
        user.update(bookState);
      }
    }

    var bookList = {
      'listId': listId,
      'title': listTitle,
      'creatorId': userId,
      'books': bookMap,
      'public': false,
    };

    // TODO: If at least one book's state is 'ip' -> state 'ip'
    // Maybe a new parameter of the function..

    var userList = {
      'lists.$listId': {
        'id': listId,
        'title': listTitle,
        'list': true,
        'state': 'ip',
      },
    };

    list.set(bookList);
    user.update(userList);
  } on FirebaseException {
    // log("Ошибка записи в БД: $e");
  }
}

void setList(userId, listId) {}

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
    var snap = FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId);

    var data = await snap.get().then((qSnap) => qSnap.docs[0]);
    Map<String, dynamic> lists = Map<String, dynamic>.from(data['lists']);
    lists.removeWhere((key, value) => value['state'] != "fi");
    return lists.length.toString();
  } catch (e) {
    return '0';
  }
}

Future<Map<String, dynamic>> fetchUserLists(userId) async {
  var snap = FirebaseFirestore.instance
      .collection("users")
      .where("id", isEqualTo: userId);

  var data = await snap.get().then((qSnap) => qSnap.docs);

  Map<String, dynamic> lists = {};

  data.forEach(
    (e) {
      lists = e.data()['lists'];
    },
  );

  return lists;
}

Future<Map<String, dynamic>> fetchAllLists() async {
  var snap = FirebaseFirestore.instance
      .collection("lists")
      .where("public", isEqualTo: true);

  var data = await snap.get().then((qSnap) => qSnap.docs);

  Map<String, dynamic> lists = {};

  data.forEach(
        (e) {
      lists[e.data()['listId']] = e.data();
      log(e.data().toString());
    },
  );

  return lists;
}

Future<Map<String, dynamic>> fetchList(userId, listId) async {
  var state = await FirebaseFirestore.instance
      .collection("users")
      .where("id", isEqualTo: userId)
      .get()
      .then((qSnap) => qSnap.docs[0]);

  var snap = FirebaseFirestore.instance
      .collection("lists")
      .where("listId", isEqualTo: listId);

  var data = await snap.get().then((qSnap) => qSnap.docs);
  var title;
  var bookData;
  var creator;
  Map<String, dynamic> books = {};

  data.forEach(
    (e) {
      title = e.data()['title'];
      creator = e.data()['creatorId'];
      bookData = e.data()['books'];
    },
  );

  bookData.forEach(
    (key, value) {
      books[key] = {
        'id': value['id'],
        'title': value['title'],
        'author': value['author'],
        'genres': value['genres'],
        'year': value['year'],
        'trusted': value['trusted'],
        'state': state['books'][value['id']].toString() != 'null'
            ? state['books'][value['id']]['state']
            : 'ns',
        'url': state['books'][value['id']].toString() != 'null'
            ? state['books'][value['id']]['url']
            : '',
      };
      log(state['books'][value['id']].toString());
    },
  );

  return {
    'title': title,
    'books': books,
    'creatorId' : creator,
    'listId' : listId
  };
}

void setListState(String userId, String listId, String state) {
  var user = FirebaseFirestore.instance.collection('users').doc(userId);

  var listState = {
    "lists.$listId.state": state,
  };

  user.update(listState);
}
//TODO: Use .set(data, SetOptions(merge: true,) where possible (?)

void setBook(String userId, String bookId, String state) {
  var ub = FirebaseFirestore.instance.collection('users').doc(userId);
  ub.set({'state': state}).onError(
    (e, _) => print("Error writing document: $e"),
  );
}

void setBookState(String userId, String bookId, String state) {
  var user = FirebaseFirestore.instance.collection('users').doc(userId);

  var bookState = {
    "books.$bookId.state": state,
  };

  user.update(bookState);
}

Future<String> fetchReadBooksCount(userId) async {
  try {
    var snap = FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId);

    var data = await snap.get().then((qSnap) => qSnap.docs[0]);
    Map<String, dynamic> books = Map<String, dynamic>.from(data['books']);
    books.removeWhere((key, value) => value['state'] != "fi");
    return books.length.toString();
  } catch (e) {
    return '0';
  }
}

Future<Map<String, Map<String, dynamic>>?> fetchBooks(
    genres, centuries, percent, uid) async {
  Query<Map<String, dynamic>> query =
      FirebaseFirestore.instance.collection("books");
  query = query.where("date", isGreaterThan: centuries[0]);
  query = query.where("date", isLessThan: centuries.last + 10 ^ 6);
  var snap = await query.get().then((qSnap) => qSnap.docs);
  var state = await FirebaseFirestore.instance
      .collection("users")
      .where("id", isEqualTo: uid)
      .get()
      .then((qSnap) => qSnap.docs[0]);

  Map<String, dynamic> listMap = {};
  Map<String, dynamic> displayMap = {};

  //TODO: Adjust length of a list accordingly

  log(percent.toString());
  var len = 0;
  snap.forEach(
    (element) {
      if (len <= percent) {
        List contain = [];
        for (var genre in genres) {
          contain.add(element['genres']![getGenre(genre)] == true);
        }
        if (contain.contains(true)) {
          displayMap[element.id] = {
            'id': element.id,
            'title': element['title'],
            'author': element['author'],
            'year': element['date'].toString().substring(0, 4),
            'state': state['books'][element['title']].toString() != 'null'
                ? state['books'][element['title']]['state']
                : 'ns',
          };

          log(len.toString());
          listMap[element.id] = {
            'id': element.id,
            'title': element['title'],
            'author': element['author'],
            'year': element['date'].toString().substring(0, 4),
            'genres': element['genres'],
            'trusted': true,
            'url': element['url'],
          };
        }
      }
      len++;
    },
  );

  Map<String, Map<String, dynamic>> m = {
    "displayMap": displayMap,
    "listMap": listMap,
  };

  if (m.isEmpty) {
    return null;
  } else {
    return m;
  }
}

Future<Map<String, dynamic>> fetchUserBooks(userId) async {
  var snap = FirebaseFirestore.instance
      .collection("users")
      .where("id", isEqualTo: userId);

  var data = await snap.get().then((qSnap) => qSnap.docs);

  Map<String, dynamic> books = {};

  data.forEach(
    (e) {
      books = e.data()['books'];
    },
  );

  return books;
}

Future<String> fetchNextBook(userId) async {
  try {
    var snap = FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: userId);

    var data = await snap.get().then((qSnap) => qSnap.docs[0],
        onError: (e) => print("Something went wrong: $e"));
    Map<String, dynamic> books = Map<String, dynamic>.from(data['books']);
    books.removeWhere((key, value) => value['state'] != "ip");
    return "${books[books.keys.elementAt(0)]['author']} - ${books[books.keys.elementAt(0)]['title']}";
  } catch (e) {
    return 'ничего';
  }
}

int getCentury(String key) {
  switch (key) {
    case "XI":
      return 10000000;
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

String getGenre(String key) {
  switch (key) {
    case "рассказ":
      return 'story';
    case "эссе":
      return 'essay';
    case "поэма":
      return 'poem';
    case "фэнтези":
      return 'fantasy';
    case "роман":
      return 'novel';
    case "трагедия":
      return 'tragedy';
    case "исторические":
      return 'historical';
    case "комедия":
      return 'comedy';
    case "философия":
      return 'philosophical';
    case "фантастика":
      return 'scifi';
    default:
      return "";
  }
}

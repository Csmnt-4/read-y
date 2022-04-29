import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../pages/list/list.dart';

Future<Map<String, String>> fetchHome(id) async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "local_test.db");
  var exists = await databaseExists(path);

  if (!exists) {
    print("Creating new copy from asset");

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets", "readydb.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }
// open the database
  Database db = await openDatabase(path, readOnly: true);

  Map<String, String> map = {
    'lists': await fetchListCount(id, db),
    'complete': await fetchCompleteListsCount(id, db),
    'next': await fetchNextBook(id, db),
    'read': await fetchReadBooksCount(id, db),
  };
  db.close();
  return map;
}

Future<String> fetchListCount(String id, Database db) async {
  String count = "";
  var res = await db.rawQuery(
    '''SELECT COUNT(ruserlist.listid)
  FROM ruserlist
  WHERE
  ruserlist.userid = '0';''',
  );
  List<Object> list = res.isNotEmpty ? res.toList() : [];
  // var list = res.toString();
  count = list[0].toString().substring(25, 27);
  return count;
}

Future<String> fetchCompleteListsCount(String id, Database db) async {
  String count = "";
  var res = await db.rawQuery(
    '''SELECT COUNT(ruserlist.listid)
  FROM ruserlist
  WHERE
  ruserlist.userid = '0' AND
  ruserlist.liststate = 'fi';''',
  );
  List<Object> list = res.isNotEmpty ? res.toList() : [];
  // var list = res.toString();
  count = list[0].toString().substring(25, 27);
  return count;
}

Future<String> fetchReadBooksCount(String id, Database db) async {
  String count = "";
  var res = await db.rawQuery(
    '''SELECT COUNT(ruserbook.bookid)
  FROM ruserbook
  WHERE
  ruserbook.userid = '0' AND
  ruserbook.bookstate = 'fi';''',
  );
  List<Object> list = res.isNotEmpty ? res.toList() : [];
  // var list = res.toString();
  count = list[0].toString().substring(25, 27);
  return count;
}

Future<String> fetchNextBook(String id, Database db) async {
  String book = "Book";
  var res = await db.rawQuery(
    '''SELECT cbook.booktitle
  FROM clist
  INNER JOIN ruserlist ON clist.listid = ruserlist.listid
  INNER JOIN rbooklist ON clist.listid = rbooklist.listid
  INNER JOIN cbook ON cbook.bookid = rbooklist.bookid
  INNER JOIN ruserbook ON ruserbook.bookid = cbook.bookid
  WHERE
  ruserbook.userid = '0' AND
  ruserbook.bookstate = 'ip'
      LIMIT 1;''',
  );
  List<Object> list = res.isNotEmpty ? res.toList() : [];
  // var list = res.toString();
  book = list[0].toString().substring(12, 29);
  return book;
}

Future<Map<String, List>> fetchLists(id) async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "local_test.db");
  var exists = await databaseExists(path);

  if (!exists) {
    print("Creating new copy from asset");

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets", "readydb.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }
// open the database
  Database db = await openDatabase(path);
  Map<String, String> list = {};

  var res = await db.rawQuery(
    '''SELECT clist.listtitle, ruserlist.liststate
  FROM ruserlist
  INNER JOIN clist
  ON clist.listid = ruserlist.listid
  WHERE
  ruserlist.userid = '0'
  '''
  );

  List<String> x = [];
  List<String> y = [];

  for (var i = 0; i < res.length; i++) {
    var str = res[i];
    x.add(str.toString().substring(12, 61));
    y.add(str.toString().substring(75, 77));
  }
  print(list);
  if (x.isEmpty) {
    return ({
      'title': ["Похоже, у вас нет списков!"],
      'state': ["ns"],
    });
  }
  return ({
    'title': x,
    'state': y,
  });
}

Future<Map<String, List>> fetchList(title) async {

  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "local_test.db");
  var exists = await databaseExists(path);

  if (!exists) {
    print("Creating new copy from asset");

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets", "readydb.db"));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }
  title = "Romance";
  Database db = await openDatabase(path);
  String sql = "SELECT listid FROM clist WHERE listtitle = 'Romance!                                          '";
  var res = await db.rawQuery(sql);
  print('res: ');
  print(res);
  List<String> x = [];

  for (var i = 0; i < res.length; i++) {
    var str = res[i];
    x.add(str.toString().substring(9));
  }

  if (x.isEmpty) {
    return ({
      'title': ["Похоже, тут нет книг"
          ""],
      'state': ["ns"],
    });
  }
  return ({
    'title': x,
  });
}

  Future<Map<String, List>> fetchNewList(genre, year, diff) async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "local_test.db");
    var exists = await databaseExists(path);

    if (!exists) {
      print("Creating new copy from asset");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "readydb.db"));
      List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

// Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
// open the database
    Database db = await openDatabase(path);
    Map<String, String> list = {};
    if (genre == '') {
      return ({
        'title': ["No"],
        'state': ["ns"],
      });
    }
    var g = 52;
    if (genre == 'Драма') {
      g = 51;
    } else if (genre == 'Поэмы') {
      g = 53;
    } else if (genre == 'Эссе'){
      g = 48;
    }
    print("yes");
    var res = await db.query('cbook',
        columns: ['booktitle'],
        where: '"genreid" = ? AND "bookdate" > ?',
        whereArgs: [g, year+'01.01']);

    print(res);
    List<String> x = [];

    for (var i = 0; i < res.length; i++) {
      var str = res[i];
      x.add(str.toString().substring(12, 40));
    }

    print(x);
    if (x.isEmpty) {
      return ({
        'title': ["Похоже, у вас нет списков!"],
        'state': ["ns"],
      });
    }
    return ({
      'title': x,
    });
  }
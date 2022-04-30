import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../pages/list/list.dart';

Future<Map<String, String>> fetchHome(id) async {
  Map<String, String> map = {
    'lists': await fetchListCount(id),
    'complete': await fetchCompleteListsCount(id),
    'next': await fetchNextBook(id),
    'read': await fetchReadBooksCount(id),
  };
  return map;
}

Future<String> fetchListCount(id) async {
  return 'count';
}

Future<String> fetchCompleteListsCount(id) async {
  return 'count';
}

Future<String> fetchReadBooksCount(id) async {
  return 'count';
}

Future<String> fetchNextBook(id) async {
  return 'book';
}

Future<Map<String, List>> fetchLists(id) async {
  return {
    'nothing' : ['nothing'],
  };
}

Future<Map<String, List>> fetchList(String title) async {
  return {
    'title' : ['title'],
  };
}

  Future<Map<String, List>> fetchNewList(genre, year, diff) async {
    return {
      'title': ["No"],
      'state': ["Not started"],
    };
  }
  // }
  //
  //   switch (genre) {
  //     case 'Детская проза':
  //       genre = 0;
  //       break;
  //     case 'Эпик':
  //       genre = 1;
  //       break;
  //     case 'Фольклор':
  //       genre = 2;
  //       break;
  //     case 'Историческая':
  //       genre = 3;
  //       break;
  //     case 'Абсурд':
  //       genre = 7;
  //       break;
  //     case 'Философская':
  //       genre = 9;
  //       break;
  //     case 'Поп':
  //       genre = 10;
  //       break;
  //     case 'Религиозная':
  //       genre = 11;
  //       break;
  //     case 'Сатира':
  //       genre = 12;
  //       break
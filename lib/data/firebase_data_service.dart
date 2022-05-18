Future<Map<String, String>> fetchHome(userId) async {
  Map<String, String> map = {
    'lists': await fetchListCount(userId),
    'complete': await fetchCompleteListsCount(userId),
    'next': await fetchNextBook(userId),
    'read': await fetchReadBooksCount(userId),
  };
  return map;
}

Future<String> fetchListCount(userId) async {
  return 'count';
}

Future<String> fetchCompleteListsCount(userId) async {
  return 'count';
}

Future<String> fetchReadBooksCount(userId) async {
  return 'count';
}

Future<String> fetchNextBook(userId) async {
  return 'book';
}

Future<Map<String, List>> fetchLists(userId) async {
  return {
    'nothing': ['nothing'],
  };
}

Future<Map<String, List>> fetchList(String listTitle) async {
  return {
    'title': ['title'],
  };
}

Future<Map<String, List>> fetchNewList(genre, year, diff) async {
  //   switch (genre) {
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
  return {
    'title': ["No"],
    'state': ["Not started"],
  };
}

void createList() {}

void setList(userId, listId) {}

void setListState(userId, listId) {}

void setBookState() {}

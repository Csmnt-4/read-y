import 'package:flutter/material.dart';
import 'package:read_y/pages/main/create.dart';

import 'list/list.dart';
import 'main.dart';

// toLoginPage(context) async {
//   await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const LoginPage()
//       )
//   );
// }

// toRegistrationPage(context) async {
//   return await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const RegistrationPage()
//       )
//   );
// }

// toFavouritesPage(context, String type) async {
//   print(type);
//   await Navigator.push(
//     context,
//     MaterialPageRoute(
//         builder: (context) => UserListsPage(type: type)
//     )
//   );
// }

// void toBookPage(BuildContext context, String id) async {
//   await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => ReleasePage(id: id)
//       )
//   );
// }

void toListsPage(BuildContext context) async {
  Navigator.pop(context);
  Navigator.pop(context);
  initialPage = 1;
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MainPage(context, title: 'Read-y App',),
      ),
  );
}

void toListPage(BuildContext context, String title) async {
  initialPage = 0;
  Key? key;
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ListPage(context, key, title,),
    ),
  );
}

void toNewList(BuildContext context, g, y, d) async {
  Navigator.pop(context);
  genreHolder = g;
  yearHolder = y;
  diffHolder = d;
  initialPage = 2;
  await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MainPage(context, title: 'Read-y App',),
    ),
  );
}

// toSettingsPage(context) async {
//   return await Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => const SettingsPage()
//     )
//   );
// }

// toUserPage(context, String id) async {
//   return await Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => UserPage(id: id)
//     )
//   );
// }

// toResetPage(context) async {
//   return await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const ResetPage()
//       )
//   );
// }

// toVkPage(context) async {
//   if (!await launch(
//       'https://vk.com/')) throw 'Не удается запустить страницу';
// }

// void toSearchPage(BuildContext context) async {
//   await Navigator.push(
//       context,
//       MaterialPageRoute(
//           builder: (context) => const SearchPage()
//       )
//   );
// }
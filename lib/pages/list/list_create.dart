import 'package:flutter/material.dart';

import 'package:read_y/pages/list/list_creation/new_list.dart';
import 'package:read_y/pages/widgets/appbar.dart';

class ListCreate extends StatefulWidget {
  const ListCreate(BuildContext context,
      {Key? key, this.initialPage, this.userId, this.nickname})
      : super(key: key);
  final initialPage;
  final userId;
  final nickname;

  @override
  State<StatefulWidget> createState() => _ListCreateState();
}

class _ListCreateState extends State<ListCreate> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(
      initialPage: 0,
    );

    final String nickname = widget.nickname.toString();
    final String uid = widget.userId.toString();

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(nickname, _scaffoldKey, MediaQuery.of(context).size.width),
      body: NewList(uid: uid, nick: nickname,),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_y/data/colors.dart';
import 'package:read_y/pages/home/lists.dart';
import 'package:read_y/pages/home/statisitics.dart';
import 'package:read_y/pages/widgets/appbar.dart';
import 'package:read_y/pages/widgets/drawer.dart';

import '../list/list_creation/new_list.dart';

class MainPage extends StatefulWidget {
  const MainPage(BuildContext context,
      {Key? key, required this.initialPage, this.userId, this.nickname})
      : super(key: key);
  final int initialPage;
  final userId;
  final nickname;

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    int init = widget.initialPage;
    final PageController _controller = PageController(
      initialPage: init,
    );
    double? currentPageValue = 0.0;

    _controller.addListener(() {
      setState(() {
        currentPageValue = _controller.page;
      });
    });

    final String nickname = widget.nickname.toString();
    final String uid = widget.userId;

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    void animateToListCreate() {
      _controller.animateToPage(
        2,
        curve: Curves.easeInOutCubic,
        duration: Duration(seconds: 1),
      );
    }

    return Scaffold(
      backgroundColor: cWh,
      key: _scaffoldKey,
      appBar: appBar(nickname, _scaffoldKey, MediaQuery.of(context).size.width),
      drawer: leftPanel(context, uid, nickname),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          statisticsPage(
            context,
            uid,
            nickname,
          ),
          ListsPage(
            context,
            userId: uid,
            nick: nickname,
            animate: animateToListCreate,
          ),
          NewList(
            uid: uid,
            nick: nickname,
          ),
        ],
      ),
    );
  }
}

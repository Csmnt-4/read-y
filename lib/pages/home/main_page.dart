import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:read_y/data/colors.dart';
import 'package:read_y/pages/home/pages/statisitics.dart';
import 'package:read_y/pages/widgets/appbar.dart';

class MainPage extends StatefulWidget {
  const MainPage(BuildContext context,
      {Key? key, required this.initialPage, this.userId, this.nickname})
      : super(key: key);
  final String initialPage;
  final userId;
  final nickname;

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController(
      initialPage: 0,
    );

    final String nickname = widget.nickname.toString();
    final String uid = widget.userId.toString();

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    return Scaffold(
      backgroundColor: cWh,
      key: _scaffoldKey,
      appBar: appBar(nickname, _scaffoldKey, MediaQuery.of(context).size.width),
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: [
          statisticsPage(context, uid,nickname),
          // listsPage(context, "Lists"),
        ],
      ),
    );
  }
}

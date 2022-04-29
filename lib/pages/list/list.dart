import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../widgets/drawer.dart';
import 'list_page.dart';
String title = '';
class ListPage extends StatefulWidget {
  ListPage(BuildContext context, Key? key, String listTitle) : super(key: key) {
    title = listTitle;
  }

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final PageController _controller = PageController(
    initialPage: initialPage,
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int indexTest = 1;
  double width = 0;
  double height = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(title);
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: leftPanel(context),
      ),
      appBar: AppBar(
        title: Text(
          "nickname", //TODO: User.nickname
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color(0xfffffaff),),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8.0),
          child: IconButton(
            icon: const Icon(Icons.dehaze),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            color: Color(0xfffffaff),
          ),
        ),
        backgroundColor: const Color(0xff0c101b),
        shadowColor: Colors.white,
      ),
      body: PageView(
        controller: _controller,
        children: [
          listPage(context, "Home", title),
          // aboutPage(context, "Lists"),
        ],
      ),
    );
  }
}


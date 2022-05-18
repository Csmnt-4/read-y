import 'package:flutter/material.dart';
import 'package:read_y/data/fonts.dart';

import '../../data/colors.dart';

class ListCreate extends StatefulWidget {
  const ListCreate(BuildContext context, {Key? key, this.initialPage, this.userId, this.nickname})
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
    final PageController _controller = PageController(
      initialPage: 0,
    );

    final String nickname = widget.nickname.toString();

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // TODO: Implement proper appbar
        title: Text(
          nickname.toString().toLowerCase(),
          style: p1White,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12, top: 8.0),
          child: IconButton(
            icon: const Icon(Icons.dehaze),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            color: whitey,
          ),
        ),
        backgroundColor: const Color(0xff0c101b),
        shadowColor: whitey,
      ),
      body: PageView(
        controller: _controller,
        // TODO: Lend controller to children (to make smooth transitions!)
        scrollDirection: Axis.horizontal,
        children: [
          Text('Genres, years, length, etc.')
          // formListPage(context, "Lists"),
          // newListPage(context, "Create"),
        ],
      ),
    );
  }
}

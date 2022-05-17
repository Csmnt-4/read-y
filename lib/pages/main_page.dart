import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage(BuildContext context, {Key? key, required this.initialPage, this.userId, this.nickname})
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
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Color(0xfffffaff),
          ),
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
        // TODO: Lend controller to children (to make smooth transitions!)
        scrollDirection: Axis.horizontal,
        children: [
          Text('data')
          // homePage(context, "Home"),
          // listsPage(context, "Lists"),
          // createPage(context, "Create"),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

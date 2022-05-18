import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // TODO?: Implement more maquette-like appbar
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
        // TODO: Lend controller to children (Smooth transitions)
        scrollDirection: Axis.horizontal,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    try {
                      var test = await FirebaseFirestore.instance
                          .collection("users")
                          .where("nick", isEqualTo: '')
                          .get()
                          .then((qSnap) => qSnap.docs,
                              onError: (e) =>
                                  print("Something went wrong: " + e));
                      print("\n");
                      print(test.toString());
                      print("\n");
                      if(test.isEmpty){
                        print('empty');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('data'))
            ],
          )

          // homePage(context, "Home"),
          // listsPage(context, "Lists"),
          // createPage(context, "Create"),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/drawer.dart';

int pressed = 0;

class NewList extends StatefulWidget {
  const NewList({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NewList> createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: leftPanel(context)),
      appBar: AppBar(
        title: Text("nickname_here", style: GoogleFonts.artifika(),),
        leading: IconButton(
          icon: const Icon(Icons.dehaze),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       // _toSearchPage(context);
          //     },
          //     icon: const Icon(Icons.search))
        ],
        backgroundColor: const Color(0xff0c101b),
        shadowColor: Colors.white,
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Color(0xffFFFAFF),
            child: Center(
              child: Image.asset(
                "assets/top.png",
                width: 420,
                fit: BoxFit.fitWidth,
                // margin: EdgeInsets.all(100.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border:
                        Border.all(color: Color(0xffFFFAFF), width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      ),
                      child: Text(
                        " Drama list ",
                        style: GoogleFonts.artifika(
                          fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color(0xffFFFAFF),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Woe from Wit\nLittle Tragedies\nDead Souls\n", style: GoogleFonts.artifika(fontWeight: FontWeight.normal,
                          fontSize: 30,
                          color: Color(0xffFFFAFF),),),)],
                    ),
                  ),
          )],
              ),
            );
  }
}

class DropButtonWidget extends StatefulWidget {
  const DropButtonWidget({Key? key}) : super(key: key);

  @override
  State<DropButtonWidget> createState() => _DropButtonWidgetState();
}

class _DropButtonWidgetState extends State<DropButtonWidget> {
  String dropdownValue = 'Genre';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: GoogleFonts.artifika(color: Colors.black, fontSize: 20),
      borderRadius: BorderRadius.all(Radius.circular(40.0)),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>["Genre", 'drama', 'romance', 'comedy', 'epic', 'ballade', 'myth']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


import 'package:flutter/material.dart';
import 'my_main_menu_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gdg_roma_flutter_app/events/event_record.dart';
import 'package:gdg_roma_flutter_app/event_row.dart';
import 'package:gdg_roma_flutter_app/diagonal_clipper.dart';
import 'package:gdg_roma_flutter_app/chi_siamo/chi_siamo_page.dart';
import 'package:gdg_roma_flutter_app/dove_siamo/dove_siamo_page.dart';
import 'package:date_format/date_format.dart';

class MyMainMenuPageState extends State<MyMainMenuPage> {
  final double _imageHeight = 256.0;
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  String convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    return (formatDate(todayDate, [dd, '/', mm, '/', yyyy, '  ',hh, ':', mm ]));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Google Developers Group Roma'),
      ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the Drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Menu Principale',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Chi siamo'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChiSiamoPage()),
                  );

                },
              ),
              ListTile(
                title: Text('Dove siamo'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DoveSiamoPage()),
                  );
                },
              ),
            ],
          ),
        ),

        body: _buildStack(context),
    );
  }

  Widget _buildStack(BuildContext context) {
    return new Stack(
      children: <Widget>[
        _buildTimeline(),
        _buildImage(),

        _buildBottomPart(context),

      ],
    );
  }

  Widget _buildImage() {
    return new ClipPath(
      clipper: new DiagonalClipper(),
      child: new Image.asset(
        'images/header.jpg',
        fit: BoxFit.cover,
        height: _imageHeight,
      ),
    );
  }



  Widget _buildBottomPart(context) {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMyTasksHeader(),
          _buildTasksList(context),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return new Positioned(
      top: 0.0,
      bottom: 0.0,
      left: 32.0,
      child: new Container(
        width: 1.0,
        color: Colors.grey[300],
      ),
    );
  }

  Widget _buildTasksList(context) {
    return new Expanded(
      child: _buildBody(context),
    );
  }


  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('events').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(

      children: snapshot.map((data) =>_buildListItem(context, data) ).toList(),
    );
  }


  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = EventRecord.fromSnapshot(data);
      return new EventRow(task:record);

  }

Widget _buildMyTasksHeader() {
  return new Padding(
    padding: new EdgeInsets.only(left: 64.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          'Prossimi eventi',
          style: new TextStyle(fontSize: 34.0),
        ),
        new Text(
            convertDateFromString(DateTime.now().toString()),
          style: new TextStyle(color: Colors.grey, fontSize: 12.0),
        ),
      ],
    ),
  );
}

}
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:gdg_roma_flutter_app/events/event_record.dart';
import 'package:gdg_roma_flutter_app/events/event_page.dart';

final textColor = Colors.blueGrey;
final subtitleColor = Colors.deepOrange[900];
final iconColor = Colors.cyan[600];

String convertDateFromString(String strDate) {
  DateTime todayDate = DateTime.parse(strDate);
  return (formatDate(todayDate, [hh, ':', mm, '  ', dd, '/', mm, '/', yyyy]));
}

class EventsRoute extends StatefulWidget {
  @override
  _EventsRouteState createState() {
    return _EventsRouteState();
  }
}

class _EventsRouteState extends State<EventsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Events')),
      body: _buildBody(context),
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
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = EventRecord.fromSnapshot(data);
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        //decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 5.0),
            child: Icon(Icons.event_available, color: iconColor, size: 50.0),
          ),
          title: Text(
            record.title.toString(),
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            children: <Widget>[
              Row(
                children: [
                  Icon(Icons.access_time, color: subtitleColor),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 200.0,
                    child: new Text(convertDateFromString(record.start_date),
                        style: TextStyle(color: subtitleColor)),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.location_on, color: subtitleColor),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    width: 200.0,
                    child: new Text(record.address.toString(),
                        style: TextStyle(color: subtitleColor)),
                  ),
                ],
              )
            ],
          ),
          trailing: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventPage(eventRecord:record)),
                );
              },
              child: Icon(
                Icons.keyboard_arrow_right,
                color: textColor,
                size: 30.0,
              )),
        ),
      ),
    );
  }
}

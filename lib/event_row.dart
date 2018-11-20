import 'package:flutter/material.dart';
import 'package:gdg_roma_flutter_app/events/event_record.dart';
import 'package:share/share.dart';
import 'package:gdg_roma_flutter_app/events/event_page.dart';
import 'package:date_format/date_format.dart';

class EventRow extends StatefulWidget {
  final EventRecord task;
  final double dotSize = 12.0;

  const EventRow({Key key, this.task}) : super(key: key);

  @override
  EventRowState createState() => new EventRowState();
}

class EventRowState extends State<EventRow> {

  String convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    return (formatDate(todayDate, [dd, '/', mm, '/', yyyy, '  ',hh, ':', mm ]));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EventPage(eventRecord:widget.task)),
        );
        },
    child: new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: new Row(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 32.0 - widget.dotSize / 2),
            child: new Container(
              height: widget.dotSize,
              width: widget.dotSize,
              decoration: new BoxDecoration(shape: BoxShape.circle, color: (Colors.blue)),

            ),
          ),
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  widget.task.title,
                  style: new TextStyle(fontSize: 18.0),
                ),
                new Text(
                  convertDateFromString(widget.task.start_date),
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                )
              ],
            ),
          ),
           new Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: new Icon(Icons.favorite_border),
          ),
        ],
      ),
    ),
    );
  }


  GestureDetector buildButtonColumn(IconData icon, String label,callback) {
    Color color = Theme
        .of(context)
        .primaryColor;

    return GestureDetector(
      onTap: (){ callback(); },
      child:Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
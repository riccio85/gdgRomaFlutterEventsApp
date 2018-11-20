import 'package:flutter/material.dart';
import 'package:gdg_roma_flutter_app/events/event_record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class EventPage extends StatelessWidget {

  EventRecord eventRecord;

  EventPage({Key key, @required this.eventRecord}) : super(key: key);

  _launchMaps() async {
    var url =  this.eventRecord.map_url;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Maps';
    }
  }

  _shareEvent() async {
    Share.share('check out my blog https://blog.gdg.roma.it');
  }

  @override
  Widget build(BuildContext context) {
    Widget titleSection = Container(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${eventRecord.title}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector (
            onTap: (){  print('save likes'); },
            child: Icon(
            Icons.favorite,
            color: Colors.red[500]
          )),
          Text('${eventRecord.like_count}'),
        ],
      ),
    );

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

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(Icons.near_me, 'ROUTE',_launchMaps),
          buildButtonColumn(Icons.share, 'SHARE',_shareEvent),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const
      EdgeInsets.all(32.0),
      child: Text('${eventRecord.description}', softWrap: true,
      ),
    );

    return MaterialApp(
      title: 'GDG Rome Demo',
      home: Scaffold(
        appBar: AppBar(
            title: Text('${eventRecord.title}'),
                leading: new IconButton(icon: new Icon(Icons.arrow_back),
            onPressed:
                () {
              Navigator.pop(context, true);
            }
        ),
      ),
      body: ListView(
        children: [
          Image.network(
              '${eventRecord.image_url}'
          ),
          titleSection,
          buttonSection,
          textSection,
        ]
        ,
      )
      ,
    ),);
  }
}

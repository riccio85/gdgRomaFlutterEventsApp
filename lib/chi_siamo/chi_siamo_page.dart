import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChiSiamoPage extends StatelessWidget {
  ChiSiamoPage({Key key}) : super(key: key);

  final double _imageHeight = 256.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Google Developers Group Roma'),
      ),
      body:
          ListView(padding: EdgeInsets.zero, children: [_buildStack(context)]),
    );
  }

  Widget _buildStack(BuildContext context) {
    return new Stack(
      children: <Widget>[
        _buildImage(),
        _buildBottomPart(context),
      ],
    );
  }

  Widget _buildImage() {
    return new Padding(
      //padding: new EdgeInsets.only(left: 34.0),
        padding: EdgeInsets.zero,
        child: new Image.asset(
          'images/big_data.png',
          fit: BoxFit.cover,
          height: _imageHeight,
        ));
  }

  Widget _buildHeader() {
    return new Padding(
      padding: new EdgeInsets.only(left: 20.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            'Chi Siamo',
            style: new TextStyle(fontSize: 34.0),
          )
        ],
      ),
    );
  }

  Widget _buildText() {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20.0),
      children: <Widget>[
        const Text(
            "La community è costituita da specialisti ed appassionati di tecnologie web, "
            "mobile ed IT ed in particolare degli strumenti e servizi Google. "
            "Siamo il gruppo di Roma ma cooperiamo nell'ecosistema Google Dev Group nazionale (GDG Italia) e mondiale."),
        const Text("I Google Developer Group sono community indipendenti "
            "ma organizzate e supportate da ufficialemente da Google."),
        const Text(""),
        new RichText(
            text: new TextSpan(children: [
          TextSpan(
            text: 'https://developers.google.com/groups/directory/',
            style: TextStyle(color: Colors.blue),
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                _launchUrl('https://developers.google.com/groups/directory/');
              },
          ),
        ])),
        new RichText(
            text: new TextSpan(children: [
              TextSpan(
                text: 'https://developers.google.com/groups/',
                style: TextStyle(color: Colors.blue),
                recognizer: new TapGestureRecognizer()
                  ..onTap = () {
                    _launchUrl('https://developers.google.com/groups/');
                  },
              ),
            ])),

        const Text(""),
        _buttonSection(),
      ],
    );
  }

  Widget _buttonSection() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
            new IconButton(
            // Use the FontAwesomeIcons class for the IconData
            icon: new Icon(FontAwesomeIcons.slack),
              onPressed: () { _launchUrl("https://goo.gl/RFtD9L"); }
          ),
            new IconButton(
              // Use the FontAwesomeIcons class for the IconData
                icon: new Icon(FontAwesomeIcons.facebook),
                onPressed: () { _launchUrl("https://www.facebook.com/groups/gugt.roma/") ; }
            ),
            new IconButton(
              // Use the FontAwesomeIcons class for the IconData
                icon: new Icon(FontAwesomeIcons.googlePlus),
                onPressed: () { _launchUrl("https://plus.google.com/u/0/b/110676501469531199993/communities/115263653461939871399") ; }
            )

        ],
      ),
    );
  }




  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Url';
    }
  }

  Widget _buildBottomPart(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.only(top: _imageHeight),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[_buildHeader(), _buildText()],
      ),
    );
  }
}

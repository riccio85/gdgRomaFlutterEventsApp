import 'package:flutter/material.dart';

class DoveSiamoPage extends StatelessWidget {
  DoveSiamoPage({Key key}) : super(key: key);

  final double _imageHeight = 256.0;
  final double _dotSize = 12.0;
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
          'images/dove_siamo.jpeg',
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
            'Dove siamo',
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
        GestureDetector(
          onTap: () {},
          child: new Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: new Row(
              children: <Widget>[
                new Icon(Icons.place),
                new Padding(
                    padding: new EdgeInsets.symmetric(horizontal: _dotSize)),
                new Expanded(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text(
                        "Information Design office",
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      new Text(
                        "Via Anna Foà, 41 - Roma",
                        style:
                            new TextStyle(fontSize: 12.0, color: Colors.grey),
                      )
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: new Icon(Icons.navigation),
                ),
              ],
            ),
          ),
        )
        //const Text("Information Design office"),
        //const Text("Via Anna Foà, 41 - Roma"),
      ],
    );
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

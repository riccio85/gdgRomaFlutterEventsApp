import 'package:cloud_firestore/cloud_firestore.dart';

class EventRecord {
  final String title;
  final String description;
  final String start_date;
  final String address;
  final String image_url;
  final String latitude;
  final String longitude;
  final String map_url;
  final int like_count;

  final DocumentReference reference;

  EventRecord.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        title = map['title'],
        description = map['description'],
        start_date = map['start_date'],
        address = map['address'],
        image_url = map['image_url'],
        latitude = map['lat'],
        longitude = map['long'],
        map_url = map['map_url'],
        like_count = map['like_count'];

  EventRecord.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "EventRecord<$title:$description>";
}

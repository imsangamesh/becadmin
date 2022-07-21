import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? eid;
  String? title;
  String? date;
  List? images;
  String? description;

  EventModel({
    required this.eid,
    required this.title,
    required this.date,
    required this.images,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'eid': eid,
      'title': title,
      'date': date,
      'images': images,
      'description': description,
    };
  }

  static EventModel fromSnapShot(DocumentSnapshot snapshot) {
    final snapData = snapshot.data() as Map<String, dynamic>;

    return EventModel(
      eid: snapData['eid'],
      title: snapData['title'],
      date: snapData['date'],
      images: snapData['images'],
      description: snapData['description'],
    );
  }

  EventModel.fromMap(Map<String, dynamic> map) {
    eid = map['eid'];
    title = map['title'];
    date = map['date'];
    images = map['images'];
    description = map['description'];
  }
}

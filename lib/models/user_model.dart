import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? phone;
  bool isprofilecomplete = false;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.isprofilecomplete,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'isprofilecomplete': isprofilecomplete,
    };
  }

  static UserModel fromSnapShot(DocumentSnapshot snapshot) {
    final snapData = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: snapData['uid'],
      name: snapData['name'],
      email: snapData['email'],
      phone: snapData['phone'],
      isprofilecomplete: snapData['isprofilecomplete'],
    );
  }
}

// enum Department { aiml, au, bt, cs, cv, ece, ee, eie, ip, ise, me }

// enum Semester { pc, cc, s3, s4, s5, s6, s7, s8 }

// UserModel.fromMap(Map<String, dynamic> map) {
//   uid = map['uid'];
//   name = map['name'];
//   email = map['email'];
//   phone = map['phone'];
//   isprofilecomplete = map['isprofilecomplete'];
// }
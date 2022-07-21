class NotesModel {
  String? id;
  String? chapterName;
  String? dept;
  String? sem;
  String? sub;
  String? link;
  String? date;

  NotesModel({
    required this.id,
    required this.chapterName,
    required this.dept,
    required this.sem,
    required this.sub,
    required this.link,
    required this.date,
  });

  NotesModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    chapterName = map['chapterName'];
    dept = map['dept'];
    sem = map['sem'];
    sub = map['sub'];
    link = map['link'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chapterName': chapterName,
      'dept': dept,
      'sem': sem,
      'sub': sub,
      'link': link,
      'date': date,
    };
  }
}

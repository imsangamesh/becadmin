class QuestionModel {
  String? id;
  String? dept;
  String? sem;
  String? sub;
  String? testNo;
  String? year;
  String? link;
  String? date;
  String? tag;

  QuestionModel({
    required this.id,
    required this.dept,
    required this.sem,
    required this.sub,
    required this.testNo,
    required this.year,
    required this.link,
    required this.date,
    required this.tag,
  });

  QuestionModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    dept = map['dept'];
    sem = map['sem'];
    sub = map['sub'];
    testNo = map['testNo'];
    year = map['year'];
    link = map['link'];
    date = map['date'];
    tag = map['tag'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dept': dept,
      'sem': sem,
      'sub': sub,
      'testNo': testNo,
      'year': year,
      'link': link,
      'date': date,
      'tag': tag,
    };
  }
}

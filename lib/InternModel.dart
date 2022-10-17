class InternModel {
  String? userId;
  String? email;
  String? name;
  String? classroom;
  String? years;
  List? comments;
  InternModel({this.userId, this.email, this.name, this.classroom, this.years, this.comments});
  factory InternModel.fromMap(map) {
    return InternModel(
      userId: map['userId'],
      email: map['email'],
      name: map['name'],
      classroom: map['classroom'],
      years: map['years'],
      comments: map['comments'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'classroom': classroom,
      'years': years,
      'comments': comments,
    };
  }
}



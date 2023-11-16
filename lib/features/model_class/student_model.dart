class StudentModel {
  String id;
  String title;
  String description;
  StudentModel(
      {required this.id, required this.title, required this.description});

  factory StudentModel.fromJson(json) {
    return StudentModel(
        id: json['_id'],
        title: json['title'],
        description: json['description']);
  }
}

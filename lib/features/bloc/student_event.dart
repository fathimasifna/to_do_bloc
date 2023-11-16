part of 'student_bloc.dart';

abstract class StudentEvent {}

class AddsucessfullEvent extends StudentEvent {
  String title;
  String description;
  AddsucessfullEvent({required this.title, required this.description});
}

class FetchSucessEvent extends StudentEvent {}

class UpdateSucessfullEvent extends StudentEvent {
  String id;
  String title;
  String description;
  UpdateSucessfullEvent(
      {required this.id, required this.title, required this.description});
}

class DeleteSucessfullEvetn extends StudentEvent {
  String id;
  DeleteSucessfullEvetn({required this.id});
}

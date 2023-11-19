part of 'student_bloc.dart';

abstract class StudentState {}

abstract class StudetActionState extends StudentState {}

final class  StudentInitial extends StudentState {}

final class FetchloadingState extends StudentState {}

final class FetchSucessSatate extends StudentState {
  List<StudentModel> list = [];
  FetchSucessSatate({required this.list});
}

final class StudentAddedMessageState extends StudetActionState {}

final class StudentDeleteMessageState extends StudetActionState {}

final class ErrorState extends StudentState {}

final class UpdateSucessMessageState extends StudetActionState {}

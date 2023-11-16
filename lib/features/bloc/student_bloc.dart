// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_block/features/model_class/student_model.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  StudentBloc() : super(StudentInitial()) {
    on<FetchSucessEvent>(fetchSucessEvent);
    on<AddsucessfullEvent>(addsucessfullEvent);
    on<DeleteSucessfullEvetn>(deleteSucessfullEvetn);
    on<UpdateSucessfullEvent>(updateSucessfullEvent);
  }

  FutureOr<void> fetchSucessEvent(
      FetchSucessEvent event, Emitter<StudentState> emit) async {
    const url = 'https://api.nstack.in/v1/todos?page=1&limit=10';
    emit(FetchloadingState());
    try {
      final uri = Uri.parse(url);
      final respones = await http.get(uri);

      if (respones.statusCode == 200) {
        final json = jsonDecode(respones.body);

        final result = json['items'] as List;
        final data = result.map((e) => StudentModel.fromJson(e)).toList();
        emit(FetchSucessSatate(list: data));
      } else {
        emit(ErrorState());
      }
    } on SocketException {
      emit(ErrorState());
    } catch (e) {
      emit(ErrorState());
    }
  }

  FutureOr<void> addsucessfullEvent(
      AddsucessfullEvent event, Emitter<StudentState> emit) async {
    String title = event.title;
    String description = event.description;
    final body = {
      "title": title,
      "description": description,
      "is_completed": false
    };
    const url = 'https://api.nstack.in/v1/todos';
    final uri = Uri.parse(url);
    final respone = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );
    emit(StudentAddedMessageState());
  }

  FutureOr<void> deleteSucessfullEvetn(
      DeleteSucessfullEvetn event, Emitter<StudentState> emit) async {
    String id = event.id;
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
    final response =
        await http.delete(uri, headers: {'accept': 'application/json'});
    emit(StudentDeleteMessageState());
  }

  FutureOr<void> updateSucessfullEvent(
      UpdateSucessfullEvent event, Emitter<StudentState> emit) async {
    String title = event.title;
    String description = event.description;
    String id = event.id;
    final body = {
      "title": title,
      "description": description,
      "is_completed": true
    };
    final url = 'https://api.nstack.in/v1/todos/$id';
    final uri = Uri.parse(url);
  
    final respone = http.put(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});
    emit(UpdateSucessMessageState());
  }
}

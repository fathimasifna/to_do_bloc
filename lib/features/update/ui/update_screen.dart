import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_block/features/bloc/student_bloc.dart';

class EditScreen extends StatelessWidget {
  EditScreen({super.key, this.info});
  // ignore: prefer_typing_uninitialized_variables
  final info;
  final titleController = TextEditingController();
  final descroptionConroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    titleController.text = info.title;
    descroptionConroller.text = info.description;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Student',
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
      body: BlocListener<StudentBloc, StudentState>(
        listenWhen: (previous, current) => current is UpdateSucessMessageState,
        listener: (context, state) {
          if (state is UpdateSucessMessageState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              'Update sucessfully',
            )));
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text("Title"),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: descroptionConroller,
                decoration: const InputDecoration(
                  label: Text("Description"),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepOrange)),
                    onPressed: () async {
                      context.read<StudentBloc>().add(UpdateSucessfullEvent(
                          id: info.id,
                          title: titleController.text.trim(),
                          description: descroptionConroller.text.trim()));
                      context.read<StudentBloc>().add(FetchSucessEvent());
                    },
                    child: const Text('Edit')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

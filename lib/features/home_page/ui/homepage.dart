import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_block/features/add_student/addpage.dart';
import 'package:todo_block/features/bloc/student_bloc.dart';

import '../../update/ui/update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StudentBloc>().add(FetchSucessEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<StudentBloc>().add(FetchSucessEvent());
              },
              icon: const Icon(Icons.refresh,color:Colors.deepOrange,))
        ],
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.deepOrange),
        ),
      ),
      body: BlocConsumer<StudentBloc, StudentState>(
        listenWhen: (previous, current) => current is StudetActionState,
        buildWhen: (previous, current) => current is! StudetActionState,
        listener: (context, state) {
          if (state is StudentDeleteMessageState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
              'Deleted Sucessfully',
            )));
          }
        },
        builder: (context, state) {
          if (state is FetchSucessSatate) {
            return state.list.isEmpty
                ? const Center(
                    child: Text('No students'),
                  )
                : ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) {
                      final data = state.list[index];
                      return ListTile(
                        trailing: PopupMenuButton(
                          onSelected: (value) {
                            if (value == 'update') {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditScreen(info: data),
                              ));
                            } else if (value == 'delete') {
                              confirmSnacbar(context, data.id);
                            }
                          },
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                  value: 'update', child: Text('Update',style: TextStyle(color: Colors.deepOrange),)),
                              const PopupMenuItem(
                                  value: 'delete', child: Text('Delete',style: TextStyle(color: Colors.deepOrange)))
                            ];
                          },
                        ),
                        leading: CircleAvatar(child: Text('${index + 1}',style: const TextStyle(color: Colors.deepOrange),),),
                        title: Text(data.title),
                        subtitle: Text(data.description),
                      );
                    },
                  );
          } else if (state is FetchloadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return const Center(
              child: Text(
                'Network issue',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return AddScreen();
            },
          ));
        },
        child: const Icon(Icons.add,color: Color.fromARGB(255, 100, 100, 100),),
      ),
    );
  }

  confirmSnacbar(BuildContext context, id) {
    showDialog(
        barrierColor: const Color.fromARGB(169, 0, 0, 0),
        context: context,
        builder: (ctx1) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 100, 100, 100),
            title: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
            content: const Text('Are you sure',
                style: TextStyle(color: Colors.white)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white))),
              ElevatedButton(
                style: ButtonStyle(backgroundColor:  MaterialStateProperty.all(Colors.deepOrange)),
                  onPressed: () {
                    context
                        .read<StudentBloc>()
                         .add(DeleteSucessfullEvetn(id: id));
                    context.read<StudentBloc>().add(FetchSucessEvent());
                    Navigator.of(context).pop();
                  },
                  child:
                      const Text('Yes', style: TextStyle(color: Colors.white)))
            ],
          );
        });
  }
}

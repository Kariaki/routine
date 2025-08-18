import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routine/constants/app_constants.dart';
import 'package:routine/cubit/auth_cubit.dart';
import 'package:routine/di/injectable.dart';
import 'package:routine/dto/user_dto.dart';
import 'package:routine/entity/create_note_entity.dart';
import 'package:routine/repositories/note_repository.dart';
import 'package:routine/util/cubit_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _repo = getIt.get<NoteRepository>(
    instanceName: DependencyNames.firebase.name,
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthCubit, BaseState<UserModel>>(
        builder: (_, state) {
          final account = state.data;
          if (account == null) {
            return SizedBox();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('welcome back ${account.email}'),


              SizedBox(height: 20,),
              MaterialButton(
                color: Colors.black,
                onPressed: () {
                  _repo.createNote(
                    CreateNoteEntity(
                      title: 'First note',
                      task: ['task1', 'task 2', 'task 3', 'task 4'],
                    ),
                  );
                },
                child: Text('Create note', style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:routine/app/auth/presentation/cubit/auth_cubit.dart';
import 'package:routine/app/note/data/dto/note_dto.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/list_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';
import 'package:routine/app/note/presentation/cubit/note_cubit.dart';
import 'package:routine/core/asset/app_assets.dart';
import 'package:routine/src/theme/app_colors.dart';
import 'package:routine/src/widgets/base_scaffold.dart';
import 'package:routine/src/widgets/default_text_input_field.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key, this.note});

  final NoteDto? note;

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  List<TaskDto> _tasks = [];

  TextEditingController? _controller;

  late NoteDto _note;

  @override
  void initState() {
    super.initState();
    final currentUser = context.read<AuthCubit>().data;
    _note = widget.note ?? NoteDto(userId: currentUser?.userId ?? '');
    _controller = TextEditingController(text: widget.note?.title);
    _tasks = widget.note?.tasks ?? [];
  }

  bool delete = false;

  @override
  Widget build(BuildContext context) {
    var taskTextStyle = context.textTheme.bodyMedium?.copyWith(
      color: AppColors.grey7D,
      fontWeight: FontWeight.w500,
    );
    return PopScope(
      onPopInvokedWithResult: (_, result) {
        if (delete) {
          return;
        }
        if (_controller?.text.isNotEmpty ?? false) {
          context.read<NoteCubit>().saveNote(_note);
        }
      },
      child: BaseScaffold.withAppBar(
        context,
        padding: 20,
        actions: [
          if (widget.note != null)
            IconButton(
              onPressed: () {
                setState(() {
                  delete = true;
                });
                context.read<NoteCubit>().deleteNoteById(widget.note!.id ?? '');
                context.pop();
              },
              icon: SvgPicture.asset(
                AppAsset.bin,
                color: context.isDarkMode ? AppColors.greyC8 : AppColors.grey55,
              ),
            ),
          10.width,
        ],
        child: Column(
          children: [
            10.height,
            InputField.borderLess(
              controller: _controller,
              hintText: 'Title',
              onChanged: (result) {
                setState(() {
                  _note = _note.copyWith(title: result);
                });
              },
              hintTextStyle: context.textTheme.titleLarge?.copyWith(
                color: context.isDarkMode ? AppColors.greyC8 : AppColors.grey55,
              ),
              textStyle: context.textTheme.titleLarge,
            ),
            20.height,
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: ListView(
                shrinkWrap: true,
                children: [
                  ..._tasks.mapWithIndex((item, index) {
                    if (item.completed) {
                      return SizedBox();
                    }
                    return TaskItemComponent(
                      initialText: item.title,
                      initialValue: item.completed,
                      onCancel: () {
                        setState(() {
                          _tasks.removeAt(index);
                          _note = _note.copyWith(tasks: _tasks);
                        });
                      },
                      onSubmit: (value) {
                        setState(() {
                          _tasks[index] = _tasks[index].copyWith(title: value);
                          _note = _note.copyWith(tasks: _tasks);
                        });
                      },
                      onCheckChange: (value) {
                        setState(() {
                          _tasks[index] = _tasks[index].copyWith(
                            completed: value,
                          );
                          _note = _note.copyWith(tasks: _tasks);
                        });
                      },
                    );
                  }),
                  10.height,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.width,
                      Icon(Icons.add, color: AppColors.grey7D),
                      10.width,
                      Expanded(
                        child: InputField.borderLess(
                          hintText: 'Add task',
                          onSubmit: (result) {
                            setState(() {
                              _tasks.add(TaskDto(title: result));
                              _note = _note.copyWith(tasks: _tasks);
                            });
                          },
                          hintTextStyle: taskTextStyle,
                          textStyle: taskTextStyle,
                        ),
                      ),
                    ],
                  ),
                  20.height,
                  ...List.generate(_tasks.length, (index) {
                    final item = _tasks[index];
                    if (!item.completed) {
                      return SizedBox();
                    }
                    return TaskItemComponent(
                      initialText: item.title,
                      initialValue: item.completed,
                      onCancel: () {
                        setState(() {
                          _tasks.removeAt(index);
                          _note = _note.copyWith(tasks: _tasks);
                        });
                      },
                      onSubmit: (value) {
                        setState(() {
                          _tasks[index] = _tasks[index].copyWith(title: value);
                          _note = _note.copyWith(tasks: _tasks);
                        });
                      },
                      onCheckChange: (value) {
                        setState(() {
                          _tasks[index] = _tasks[index].copyWith(
                            completed: value,
                          );
                          _note = _note.copyWith(tasks: _tasks);
                        });
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItemComponent extends StatefulWidget {
  const TaskItemComponent({
    super.key,
    this.initialValue,
    this.onSubmit,
    this.initialText,
    this.onCheckChange,
    this.onCancel,
  });

  final bool? initialValue;
  final void Function(String)? onSubmit;
  final void Function(bool?)? onCheckChange;
  final String? initialText;
  final VoidCallback? onCancel;

  @override
  State<TaskItemComponent> createState() => _TaskItemComponentState();
}

class _TaskItemComponentState extends State<TaskItemComponent> {
  bool value = false;

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue ?? false;
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    var taskTextStyle = context.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      decoration: value ? TextDecoration.lineThrough : null,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppAsset.rearrange,
          color: context.isDarkMode ? AppColors.greyC8 : AppColors.grey55,
        ),
        10.width,
        Checkbox(
          value: value,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          onChanged: (result) {
            setState(() {
              value = result ?? false;
              widget.onCheckChange?.call(result);
            });
          },
        ),
        10.width,
        Expanded(
          child: InputField.borderLess(
            hintText: 'Add task',
            controller: _controller,
            onSubmit: widget.onSubmit,
            onChanged: widget.onSubmit,
            hintTextStyle: taskTextStyle,
            textStyle: taskTextStyle,
          ),
        ),
        10.width,
        IconButton(onPressed: widget.onCancel, icon: Icon(Icons.close)),
      ],
    );
  }
}

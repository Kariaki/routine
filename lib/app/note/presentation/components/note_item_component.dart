import 'package:flutter/material.dart';
import 'package:routine/app/note/data/dto/note_dto.dart';
import 'package:routine/app/note/presentation/screens/create_note_screen.dart';
import 'package:routine/core/extensions/context_extension.dart';
import 'package:routine/core/extensions/num_extension.dart';

import '../../../../src/theme/app_colors.dart';

class NoteItemComponent extends StatelessWidget {
  const NoteItemComponent({super.key, required this.note});

  final NoteDto note;

  @override
  Widget build(BuildContext context) {
    List<TaskDto> pendingTask = note.tasks.where((e) => !e.completed).toList();
    if(pendingTask.length>3){
      pendingTask=pendingTask.sublist(0,3);
    }
    var tickedItemsCount = note.tasks.length - pendingTask.length;
    var taskTextStyle = context.textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
    );
    return GestureDetector(
      onTap: (){
        context.push(CreateNoteScreen(note: note,));
      },
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(
              width: 1,
              color: context.isDarkMode ? AppColors.grey55 : AppColors.greyC8,
            ),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.title, style: context.textTheme.titleMedium,maxLines: 3,),
            10.height,
            ...pendingTask.map(
                  (task) => Padding(padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width:20,
                      height: 20,
                      child: Checkbox(
                        value: false,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), onChanged: (bool? value) {  },
                      ),
                    ),
                    10.width,
                    Expanded(
                      child: Text(task.title,style: taskTextStyle,maxLines: 1,overflow: TextOverflow.ellipsis,),
                    ),
                  ],
                ),),
            ),
            10.height,
            if (pendingTask.length < note.tasks.length)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: AppColors.grey7D),
                  10.width,
                  Text(
                    '$tickedItemsCount ticked item${tickedItemsCount > 1 ? 's' : ''}',
                    style: context.textTheme.bodyMedium?.copyWith(color: AppColors.grey7D),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

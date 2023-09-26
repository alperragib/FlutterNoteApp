import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../modules/module_note/model/note_model.dart';

class SelectableCardWidget extends StatefulWidget {
  final NoteCategory initialNoteCategory;
  final ValueChanged<NoteCategory> onChangedNoteCategory;

  const SelectableCardWidget(
      {super.key,
      required this.onChangedNoteCategory,
      this.initialNoteCategory = NoteCategory.todo});

  @override
  State<SelectableCardWidget> createState() => _SelectableCardWidgetState();
}

class _SelectableCardWidgetState extends State<SelectableCardWidget> {
  var noteCategoryList = NoteCategory.values;
  var selectedNoteCategory = NoteCategory.todo;

  @override
  void initState() {
    selectedNoteCategory = widget.initialNoteCategory;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlignedGridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 6.w,
      crossAxisSpacing: 6.w,
      itemCount: noteCategoryList.length,
      itemBuilder: (context, index) {
        return CustomCard(
            isSelected:
                selectedNoteCategory.name == noteCategoryList[index].name,
            text: noteCategoryList[index].getName(),
            onPressed: () {
              if (selectedNoteCategory.name != noteCategoryList[index].name) {
                setState(() {
                  selectedNoteCategory = noteCategoryList[index];
                });
                widget.onChangedNoteCategory(selectedNoteCategory);
              }
            });
      },
    );
  }

  Widget CustomCard({
    required String text,
    VoidCallback? onPressed,
    bool isSelected = false,
  }) {
    return Card(
      color: isSelected ? Colors.black.withOpacity(0.75) : Colors.white,
      surfaceTintColor: isSelected ? Colors.black : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: const BorderSide(color: Colors.grey),
      ),
      margin: EdgeInsets.all(4.w),
      elevation: 0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10.r),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 12.w),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: isSelected ? Colors.white : Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}

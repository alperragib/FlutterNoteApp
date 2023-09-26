import 'package:code23_note_app/modules/module_note/model/note_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/services/notes_client.dart';
import '../../../../utils/ui/custom_button.dart';
import '../../../../utils/ui/custom_text_form_field.dart';
import '../../../../utils/ui/selectable_card_widget.dart';
import '../../viewmodel/notes_provider.dart';

class NoteUpdatePage extends ConsumerStatefulWidget {
  final Note note;

  const NoteUpdatePage({super.key, required this.note});

  @override
  ConsumerState<NoteUpdatePage> createState() => _NoteUpdatePageState();
}

class _NoteUpdatePageState extends ConsumerState<NoteUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  var _selectedNoteCategory = NoteCategory.todo;

  @override
  void initState() {
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content ?? '';
    _selectedNoteCategory = widget.note.category ?? NoteCategory.todo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notu Düzenle'),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: FaIcon(
            FontAwesomeIcons.angleLeft,
            size: 24.sp,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.grey.withOpacity(0.5),
        elevation: 3,
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(right: 12.w, left: 12.w, top: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      controller: _titleController,
                      hintText: 'Not başlığını giriniz.',
                      prefixIcon: FontAwesomeIcons.magnifyingGlass,
                      maxLength: 250,
                      maxLines: 2,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Bu alan boş bırakılamaz!';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    CustomTextFormField(
                      controller: _contentController,
                      hintText: 'Not içeriğini giriniz.',
                      prefixIcon: FontAwesomeIcons.pencil,
                      maxLines: 6,
                      maxLength: 2500,
                      keyboardType: TextInputType.multiline,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Bu alan boş bırakılamaz!';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: 4.w,
                    ),
                    SelectableCardWidget(
                      initialNoteCategory:
                          widget.note.category ?? NoteCategory.todo,
                      onChangedNoteCategory: (noteCategory) {
                        _selectedNoteCategory = noteCategory;
                      },
                    ),
                    SizedBox(
                      height: 24.w,
                    ),
                    CustomButton(
                      text: 'Notu Düzenle',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();

                          var note = Note(
                            id: widget.note.id,
                            title: _titleController.text.trim(),
                            content: _contentController.text.trim(),
                            category: _selectedNoteCategory,
                          );
                          if (await NotesClient().updateNote(note: note)) {
                            ref.invalidate(notesProvider);
                            if (!context.mounted) return;
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

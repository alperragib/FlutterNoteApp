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

class NoteAddPage extends ConsumerStatefulWidget {
  const NoteAddPage({super.key});

  @override
  ConsumerState<NoteAddPage> createState() => _NoteAddPageState();
}

class _NoteAddPageState extends ConsumerState<NoteAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  var _selectedNoteCategory = NoteCategory.todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yeni Not Oluştur'),
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
                      onChangedNoteCategory: (noteCategory) {
                        _selectedNoteCategory = noteCategory;
                      },
                    ),
                    SizedBox(
                      height: 24.w,
                    ),
                    CustomButton(
                      text: 'Notu Kaydet',
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();

                          var note = Note(
                            title: _titleController.text.trim(),
                            content: _contentController.text.trim(),
                            category: _selectedNoteCategory,
                          );
                          if (await NotesClient().addNote(note: note)) {
                            ref.invalidate(notesProvider);
                            if (!context.mounted) return;
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

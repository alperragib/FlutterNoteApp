import 'package:flutter/material.dart';
import '../../modules/module_note/model/note_model.dart';
import '../../modules/module_note/view/screens/note_add_page.dart';
import '../../modules/module_note/view/screens/note_detail_page.dart';
import '../../modules/module_note/view/screens/note_update_page.dart';

class NoteRoutes {
  BuildContext context;

  NoteRoutes(this.context);

  noteAddPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const NoteAddPage()));
  }

  noteUpdatePage({required Note note}) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NoteUpdatePage(note: note)));
  }

  noteDetailPage({required Note note}) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => NoteDetailPage(note: note)));
  }
}

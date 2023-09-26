import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:code23_note_app/utils/services/notes_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../config/routing/note_routes.dart';
import '../../../../utils/ui/custom_icon_button.dart';
import '../../../../utils/ui/note_properties_widget.dart';
import '../../model/note_model.dart';
import '../../viewmodel/notes_provider.dart';

class NoteDetailPage extends ConsumerStatefulWidget {
  final Note note;

  const NoteDetailPage({super.key, required this.note});

  @override
  ConsumerState<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends ConsumerState<NoteDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.note.user?.name ?? 'Kullanıcı'} Notu'),
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
        minimum: EdgeInsets.only(right: 8.w, left: 8.w, top: 16.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CardPropertiesWidget(
                      icon: FontAwesomeIcons.tags,
                      name: widget.note.category != null
                          ? widget.note.category!.getName()
                          : 'Diğer',
                    ),
                    CardPropertiesWidget(
                      icon: FontAwesomeIcons.solidClock,
                      name: widget.note.updatedAt != null
                          ? DateFormat('d MMMM HH:mm', 'tr')
                              .format(widget.note.updatedAt!)
                          : DateFormat('d MMMM HH:mm', 'tr')
                              .format(DateTime.now()),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.w,
              ),
              Text(
                widget.note.title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              if (widget.note.content != null &&
                  widget.note.content!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.w),
                  child: Text(
                    widget.note.content ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              SizedBox(
                height: 4.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    tooltip: 'Düzenle',
                    icon: FontAwesomeIcons.penToSquare,
                    onPressed: () {
                      NoteRoutes(context).noteUpdatePage(note: widget.note);
                    },
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  CustomIconButton(
                    tooltip: 'Sil',
                    icon: FontAwesomeIcons.trashCan,
                    padding:
                        EdgeInsets.symmetric(horizontal: 11.w, vertical: 10.w),
                    onPressed: () async {
                      final result = await showOkCancelAlertDialog(
                        context: context,
                        title: 'Notu silmek üzeresiniz.',
                        message: 'Bu notu silmek istediğinize emin misiniz?',
                        cancelLabel: 'Vazgeç',
                        okLabel: 'Evet',
                      );
                      if (result == OkCancelResult.ok) {
                        if (await NotesClient().deleteNote(note: widget.note)) {
                          ref.invalidate(notesProvider);
                          if (!context.mounted) return;
                          Navigator.of(context).pop();
                        }
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

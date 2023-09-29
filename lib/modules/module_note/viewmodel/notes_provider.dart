import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_infinite_scroll/riverpod_infinite_scroll.dart';

import '../../../utils/services/notes_client.dart';
import '../model/note_model.dart';

class NotesNotifier extends PagedNotifier<int, Note> {
  NotesNotifier()
      : super(
          load: (page, limit) =>
              NotesClient().getNotes(page: page, size: limit),
          nextPageKeyBuilder: NextPageKeyBuilderDefault.mysqlPagination,
        );

  void add(Note note) {
    state = state.copyWith(records: [note, ...(state.records ?? [])]);
  }

  void delete(Note note) {
    state = state.copyWith(records: [...(state.records ?? [])]..remove(note));
  }

  Future<void> search({required String searchKey}) async {
    var searchNotes = await NotesClient().searchNotes(searchKey: searchKey);
    state = state.copyWith(records: searchNotes, nextPageKey: null);
  }
}

var notesProvider = StateNotifierProvider<NotesNotifier, PagedState<int, Note>>(
    (_) => NotesNotifier());

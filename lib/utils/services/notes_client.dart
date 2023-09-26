import 'package:code23_note_app/constants/app_constants/api_constant.dart';
import 'package:dio/dio.dart';

import '../../modules/module_note/model/note_model.dart';
import '../helpers/user_message.dart';

class NotesClient {
  var dio = Dio();
  var headers = {
    'Content-type': 'application/json; charset=utf-8',
    'Accept': 'application/json; charset=utf-8'
  };

  Future<List<Note>> getNotes({int page = 1, int size = 15}) async {
    List<Note> notes = [];

    var response = await dio.get(
      '${ApiConstant.notesUrl}?size=$size&page=$page',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      var jsonNotes = response.data['data'] as List;
      notes = jsonNotes.map((tagJson) => Note.fromJson(tagJson)).toList();
    } else {
      UserMessage().noInternetMessage();
    }
    return notes;
  }

  Future<List<Note>> searchNotes(
      {required String searchKey, int page = 1, int size = 15}) async {
    List<Note> notes = [];

    var response = await dio.get(
      Uri.parse(
              '${ApiConstant.notesUrl}?title[search]=%$searchKey%&size=$size&page=$page')
          .toString(),
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      var jsonNotes = response.data['data'] as List;
      notes = jsonNotes.map((tagJson) => Note.fromJson(tagJson)).toList();
    } else {
      UserMessage().noInternetMessage();
    }
    return notes;
  }

  Future<bool> addNote({required Note note}) async {
    var response = await dio.post(
      ApiConstant.notesUrl,
      options: Options(headers: headers),
      data: note.toJson(),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      UserMessage().noInternetMessage();
    }
    return false;
  }

  Future<bool> updateNote({required Note note}) async {
    var response = await dio.put(
      '${ApiConstant.notesUrl}${note.id}',
      options: Options(headers: headers),
      data: note.toJson(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      UserMessage().noInternetMessage();
    }
    return false;
  }

  Future<bool> deleteNote({required Note note}) async {
    var response = await dio.delete(
      '${ApiConstant.notesUrl}${note.id}',
      options: Options(headers: headers),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      UserMessage().noInternetMessage();
    }
    return false;
  }
}

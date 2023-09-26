import '../../module_user/model/user_model.dart';

class Note {
  int? id;
  User? user;
  String title;
  String? content;
  NoteCategory? category;
  DateTime? createdAt;
  DateTime? updatedAt;

  Note({
    this.id,
    this.user,
    required this.title,
    this.content,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        id: int.tryParse(json["id"].toString()),
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        title: json["title"],
        content: json["content"],
        category: json["category"] != null
            ? NoteCategory.fromJson(json["category"])
            : NoteCategory.todo,
        createdAt: DateTime.tryParse(json["created_at"]),
        updatedAt: DateTime.tryParse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (user != null) "user_id": user?.id,
        if (title.isNotEmpty) "title": title,
        if (content != null) "content": content,
        if (category != null) "category": category?.name,
        if (createdAt != null) "created_at": createdAt?.toIso8601String(),
        if (updatedAt != null) "updated_at": updatedAt?.toIso8601String(),
      };
}

enum NoteCategory {
  todo,
  reminder,
  account,
  other;

  String getName() {
    switch (name) {
      case 'todo':
        return 'Yapılacaklar';
      case 'reminder':
        return 'Hatırlatmalar';
      case 'account':
        return 'Hesap Bilgileri';
      default:
        return 'Diğer';
    }
  }

  String toJson() => name;

  static NoteCategory fromJson(String json) => values.byName(json);
}

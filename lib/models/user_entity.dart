import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.nick,
    required this.about,
    required this.books,
    required this.lists,
  });

  final String id;
  final String nick;
  final String about;
  final Map books;
  final Map lists;

  UserEntity.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) :
        id = snapshot.data()?["id"],
        nick = snapshot.data()?["nick"],
        about = snapshot.data()?["about"],
        books =
        (snapshot.data()?["books"] as Map<dynamic, dynamic>),
  lists =
  (snapshot.data()?["lists"] as Map<dynamic, dynamic>);

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) "id": id,
      if (nick != null) "nick": nick,
      if (about != null) "about": about,
      if (books != null) "books": books,
      if (lists != null) "lists": lists,
    };
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        id: json['id'] ?? "",
        nick: json['nick'] ?? "",
        about: json['lastName'] ?? "",
        books: json['books'] ?? "",
        lists: json['lists'] ?? "",
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'nick': nick,
        'lastName': about,
        'books': books,
        'lists': lists,
      };

  factory UserEntity.empty() => const UserEntity(
        id: "",
        nick: "",
        about: "",
        books: <String, dynamic>{},
        lists: <String, dynamic>{},
      );

  @override
  List<Object?> get props => [id, nick, about, books, lists];
}

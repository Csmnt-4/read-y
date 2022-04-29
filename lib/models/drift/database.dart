// import 'dart:io';
//
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;
//
// part 'database.g.dart';
//
// @DataClassName('Book')
// class CBook extends Table {
//   IntColumn get bookId => integer().autoIncrement()();
//   TextColumn get bookTitle => text().withLength(max: 40)();
//   TextColumn get bookType => text().withLength(max: 10).nullable()();
//   IntColumn get bookReadTime => integer().nullable()();
//   IntColumn get bookReadValue => integer().nullable()();
//   IntColumn get citationQuantity => integer().nullable()();
//   DateTimeColumn get bookDate => dateTime()();
//   IntColumn get genreId => integer().nullable()();
//   TextColumn get author => text().withLength(max: 60)();
// }
//
// @DataClassName('Genre')
// class CGenre extends Table {
//   IntColumn get genreId => integer().autoIncrement()();
//   TextColumn get genreTitle => text().withLength(max: 30)();
//   IntColumn get popularity => integer()();
// }
//
// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'readydb.sqlite3'));
//
//     if (!await file.exists()) {
//       final blob = await rootBundle.load('assets/readydb.sqlite3');
//       final buffer = blob.buffer;
//       await file.writeAsBytes(buffer.asUint8List(blob.offsetInBytes, blob.lengthInBytes));
//     }
//     return NativeDatabase(file);
//   });
// }
//
// abstract class BookView extends View {
//   CBook get cBook;
//   CGenre get cGenre;
//
//   Expression<String> get title =>
//       cBook.bookTitle +
//           const Constant('(') +
//           cGenre.genreTitle +
//           const Constant(')');
//
//   @override
//   Query as() => select([cBook.bookId, title]).from(cBook).join([
//     innerJoin(
//         cGenre, cGenre.genreId.equalsExp(cBook.genreId))
//   ]);
// }
//
// @DriftDatabase(
//     tables: [CBook, CGenre],
//     views: [BookView]
// )
// class MyDatabase extends _$MyDatabase {
//
//   // we tell the database where to store the data with this constructor
//   MyDatabase() : super(_openConnection());
//
//   // you should bump this number whenever you change or add a table definition.
//   // Migrations are covered later in the documentation.
//   @override
//   int get schemaVersion => 1;
//
//   Stream<List<Book>> get allBookEntries => select(cBook).watch();
//   Future getLastBookToRead() {
//     return (select(cBook)..limit(1)).get();
//   }
//
//   // watches all to do entries in a given category. The stream will automatically
//   // emit new items whenever the underlying data changes.
//   Stream<List<Book>> watchEntriesInCategory(Genre g) {
//     return (select(cBook)..where((t) => t.genreId.equals(g.genreId))).watch();
//   }
// }
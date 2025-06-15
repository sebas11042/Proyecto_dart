import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

part 'db.g.dart';

class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
}

class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo => text()();
  TextColumn get descripcion => text().nullable()();
  TextColumn get estado => text().withDefault(const Constant('pendiente'))();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
}

@DriftDatabase(tables: [Usuarios, Tareas])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CRUD USUARIOS
  Future<List<Usuario>> obtenerUsuarios() => select(usuarios).get();
  Future<int> insertarUsuario(UsuariosCompanion entry) => into(usuarios).insert(entry);

  // CRUD TAREAS
  Future<List<Tarea>> obtenerTareas() => select(tareas).get();
  Future<int> insertarTarea(TareasCompanion entry) => into(tareas).insert(entry);
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = Directory.current;
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase(file);
  });
}

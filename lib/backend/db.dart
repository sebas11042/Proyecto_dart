import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;

part 'db.g.dart';

// Tabla Usuarios
class Usuarios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
}

// Tabla Tareas
class Tareas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get titulo => text()();
  TextColumn get descripcion => text()();
  TextColumn get estado => text()();
  DateTimeColumn get fechaVencimiento => dateTime()();
  TextColumn get prioridad => text()();
  TextColumn get lugar => text()();
  RealColumn get horas => real()();
  TextColumn get imagenRuta => text()();
  BoolColumn get finalizada => boolean().withDefault(Constant(false))();
  IntColumn get usuarioId => integer().references(Usuarios, #id)();
}

// Base de datos principal
@DriftDatabase(tables: [Usuarios, Tareas])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --------------------- USUARIOS ---------------------
  Future<List<Usuario>> obtenerUsuarios() => select(usuarios).get();

  Future<int> insertarUsuario(UsuariosCompanion usuario) =>
      into(usuarios).insert(usuario);

  Future<bool> actualizarUsuario(Usuario usuario) =>
      update(usuarios).replace(usuario);

  Future<int> eliminarUsuario(int id) =>
      (delete(usuarios)..where((u) => u.id.equals(id))).go();

  // --------------------- TAREAS ---------------------
  Future<List<Tarea>> obtenerTareas() => select(tareas).get();

  Future<int> insertarTarea(TareasCompanion tarea) =>
      into(tareas).insert(tarea);

  Future<bool> actualizarTarea(Tarea tarea) =>
      update(tareas).replace(tarea);

  Future<int> eliminarTarea(int id) =>
      (delete(tareas)..where((t) => t.id.equals(id))).go();

  /// ✅ Método personalizado para actualizar solo ciertos campos (usando Companion)
  Future<void> actualizarTareaPorId(int id, TareasCompanion tarea) {
    return (update(tareas)..where((t) => t.id.equals(id))).write(tarea);
  }
}

// --------------------- CONEXIÓN ---------------------
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = Directory.current;
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

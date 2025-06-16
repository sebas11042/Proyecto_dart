import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'package:backend_drift/db.dart';

final db = AppDatabase();

void main() async {
  
  final usuariosExistentes = await db.obtenerUsuarios();
  if (usuariosExistentes.isEmpty) {
    final idUsuario = await db.insertarUsuario(
      UsuariosCompanion(nombre: Value('Mariano')),
    );
    print('👤 Usuario demo creado con id $idUsuario');

    await db.insertarTarea(
      TareasCompanion(
        titulo: Value('Investigar Drift'),
        descripcion: Value('Revisar documentación oficial'),
        estado: Value('pendiente'),
        usuarioId: Value(idUsuario),
      ),
    );
    print('📌 Tarea demo creada para usuario $idUsuario');
  } else {
    print('ℹ️ Ya existen usuarios. No se insertó demo.');
  }

  final router = Router();

  // ======= USUARIOS =======

  router.get('/api/usuarios', (Request request) async {
    final usuarios = await db.obtenerUsuarios();
    final json = usuarios.map((u) => {'id': u.id, 'nombre': u.nombre}).toList();
    return Response.ok(jsonEncode(json), headers: {'Content-Type': 'application/json'});
  });

  router.post('/api/usuarios', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);
    final usuario = UsuariosCompanion(nombre: Value(data['nombre']));
    final id = await db.insertarUsuario(usuario);
    return Response.ok(jsonEncode({'id': id}), headers: {'Content-Type': 'application/json'});
  });

  router.put('/api/usuarios/<id>', (Request request, String id) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);
    final nombre = data['nombre'];

    final rowsUpdated = await (db.update(db.usuarios)..where((u) => u.id.equals(int.parse(id))))
        .write(UsuariosCompanion(nombre: Value(nombre)));

    return Response.ok(jsonEncode({'updated': rowsUpdated}));
  });

  router.delete('/api/usuarios/<id>', (Request request, String id) async {
    final rowsDeleted = await (db.delete(db.usuarios)..where((u) => u.id.equals(int.parse(id)))).go();
    return Response.ok(jsonEncode({'deleted': rowsDeleted}));
  });

  // ======= TAREAS =======

  router.get('/api/tareas', (Request request) async {
    final tareas = await db.obtenerTareas();
    final json = tareas
        .map((t) => {
              'id': t.id,
              'titulo': t.titulo,
              'descripcion': t.descripcion,
              'estado': t.estado,
              'usuarioId': t.usuarioId,
            })
        .toList();
    return Response.ok(jsonEncode(json), headers: {'Content-Type': 'application/json'});
  });

  router.post('/api/tareas', (Request request) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);
    final tarea = TareasCompanion(
      titulo: Value(data['titulo']),
      descripcion: Value(data['descripcion']),
      estado: Value(data['estado']),
      usuarioId: Value(data['usuarioId']),
    );
    final id = await db.insertarTarea(tarea);
    return Response.ok(jsonEncode({'id': id}), headers: {'Content-Type': 'application/json'});
  });

  router.put('/api/tareas/<id>', (Request request, String id) async {
    final body = await request.readAsString();
    final data = jsonDecode(body);

    final rowsUpdated = await (db.update(db.tareas)..where((t) => t.id.equals(int.parse(id)))).write(
      TareasCompanion(
        titulo: Value(data['titulo']),
        descripcion: Value(data['descripcion']),
        estado: Value(data['estado']),
      ),
    );

    return Response.ok(jsonEncode({'updated': rowsUpdated}));
  });

  router.delete('/api/tareas/<id>', (Request request, String id) async {
    final rowsDeleted = await (db.delete(db.tareas)..where((t) => t.id.equals(int.parse(id)))).go();
    return Response.ok(jsonEncode({'deleted': rowsDeleted}));
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addHandler(router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('🚀 Servidor Drift activo en http://${server.address.address}:${server.port}');
}

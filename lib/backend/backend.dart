import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart';
import 'package:mime/mime.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_multipart/multipart.dart';

import 'db.dart';

final db = AppDatabase();

void main() async {
  // Inserta demo si no existen usuarios
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
        fechaVencimiento: Value(DateTime.now().add(Duration(days: 5))),
        prioridad: Value('alta'),
        lugar: Value('Remoto'),
        horas: Value(3.5),
        imagenRuta: Value('img/demo.png'),
        finalizada: Value(false),
        usuarioId: Value(idUsuario),
      ),
    );
    print('📌 Tarea demo creada para usuario $idUsuario');
  } else {
    print('ℹ️ Ya existen usuarios. No se insertó demo.');
  }

  final router = Router();

  // =================== RUTAS PARA USUARIOS ===================

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

  // =================== RUTAS PARA TAREAS ===================

  router.get('/api/tareas', (Request request) async {
    final tareas = await db.obtenerTareas();
    final json = tareas
        .map((t) => {
              'id': t.id,
              'titulo': t.titulo,
              'descripcion': t.descripcion,
              'estado': t.estado,
              'fechaVencimiento': t.fechaVencimiento.toIso8601String(),
              'prioridad': t.prioridad,
              'lugar': t.lugar,
              'horas': t.horas,
              'imagenRuta': t.imagenRuta,
              'finalizada': t.finalizada,
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
      fechaVencimiento: Value(DateTime.parse(data['fechaVencimiento'])),
      prioridad: Value(data['prioridad']),
      lugar: Value(data['lugar']),
      horas: Value((data['horas'] as num).toDouble()),
      imagenRuta: Value(data['imagenRuta']),
      finalizada: Value(data['finalizada']),
      usuarioId: Value(data['usuarioId']),
    );
    final id = await db.insertarTarea(tarea);
    return Response.ok(jsonEncode({'id': id}), headers: {'Content-Type': 'application/json'});
  });

  // =================== SUBIDA DE IMAGEN ===================

  router.post('/api/imagen', (Request request) async {
    final boundary = request.headers['content-type']?.split("boundary=").last;
    if (boundary == null) {
      return Response(400, body: 'Missing boundary');
    }

    final transformer = MimeMultipartTransformer(boundary);
    final parts = await transformer.bind(request.read()).toList();

    for (final part in parts) {
      final contentDisposition = part.headers['content-disposition'];
      if (contentDisposition != null && contentDisposition.contains('filename=')) {
        final filename = RegExp(r'filename="([^"]*)"').firstMatch(contentDisposition)?.group(1);
        if (filename == null) continue;

        final directory = Directory('img');
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }

        final file = File('img/$filename');
        final sink = file.openWrite();
        await part.pipe(sink);
        await sink.close();

        return Response.ok(jsonEncode({'ruta': 'img/$filename'}), headers: {
          'Content-Type': 'application/json',
        });
      }
    }

    return Response(400, body: 'No se encontró archivo válido');
  });

  // =================== LANZAR SERVIDOR ===================

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsMiddleware()) // 👈 Importante para evitar error CORS
      .addHandler(router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('🚀 Servidor Drift activo en http://${server.address.address}:${server.port}');
}

// =================== MIDDLEWARE CORS ===================

Middleware corsMiddleware() {
  return (Handler handler) {
    return (Request request) async {
      if (request.method == 'OPTIONS') {
        return Response.ok('', headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
          'Access-Control-Allow-Headers': 'Origin, Content-Type',
        });
      }

      final response = await handler(request);
      return response.change(headers: {
        ...response.headers,
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type',
      });
    };
  };
}

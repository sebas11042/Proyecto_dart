import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:mysql1/mysql1.dart';

void main() async {
  final router = Router();

  final settings = ConnectionSettings(
    host: 'localhost',
    port: 3306,
    user: 'root',
    password: 'root',
    db: 'task_manager1',
  );

  // Ruta GET - Obtener tareas
  router.get('/api/tareas', (Request request) async {
    final conn = await MySqlConnection.connect(settings);
    var results = await conn.query('SELECT * FROM tareas');
    await conn.close();

    final tareas = results
        .map((row) => {
              'id': row[0],
              'titulo': row[1],
              'descripcion': row[2],
              'estado': row[3],
            })
        .toList();

    return Response.ok(jsonEncode(tareas), headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
  });

  // Ruta GET - Obtener usuarios
  router.get('/api/usuarios', (Request request) async {
    final conn = await MySqlConnection.connect(settings);
    var result = await conn.query('SELECT * FROM usuarios');
    await conn.close();

    final usuarios = result
        .map((row) => {
              'id': row[0],
              'nombre': row[1],
            })
        .toList();

    return Response.ok(jsonEncode(usuarios), headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    });
  });

  final handler = const Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router);

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('🚀 Servidor Dart activo en http://${server.address.address}:${server.port}');
}

// Middleware para CORS
Middleware corsHeaders() {
  return (Handler handler) {
    return (Request request) async {
      final response = await handler(request);
      return response.change(headers: {
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Origin, Content-Type'
      });
    };
  };
}

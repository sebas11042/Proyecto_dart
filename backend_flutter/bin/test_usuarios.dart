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

  router.get('/api/usuarios', (Request request) async {
    print('🌐 Recibida solicitud GET /api/usuarios');

    try {
      final conn = await MySqlConnection.connect(settings);
      print('✅ Conectado correctamente a MySQL');

      var result = await conn.query('SELECT * FROM usuarios');
      print('🧾 Total filas: ${result.length}');

      final usuarios = result.map((row) {
        print('✔ Fila recibida: id=${row[0]}, nombre=${row[1]}');
        return {'id': row[0], 'nombre': row[1]};
      }).toList();

      await conn.close();

      return Response.ok(jsonEncode(usuarios), headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*'
      });
    } catch (e) {
      print('❌ Error al conectar o consultar: $e');
      return Response.internalServerError(body: 'Error: $e');
    }
  });

  final handler = router;

  final server = await io.serve(handler, InternetAddress.anyIPv4, 8080);
  print('🧪 Servidor solo /api/usuarios activo en http://${server.address.address}:${server.port}');
}

import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:taller_flutter/backend/backend.dart';
import 'package:taller_flutter/backend/db.dart';
import 'crear_tarea_page.dart';

class TareasPage extends StatefulWidget {
  const TareasPage({super.key});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  late Future<List<Tarea>> _tareasFuture;
  late Future<List<Usuario>> _usuariosFuture;

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  void _cargarDatos() {
    _tareasFuture = db.obtenerTareas();
    _usuariosFuture = db.obtenerUsuarios();
  }

  void confirmarEliminacion(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Estás seguro?'),
        content: const Text('Esta acción eliminará la tarea permanentemente.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await db.eliminarTarea(id);
              setState(_cargarDatos);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Tarea eliminada correctamente")),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void abrirFormulario({Tarea? tarea}) async {
    final usuarios = await _usuariosFuture;

    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioTareaPage(
          tarea: tarea,
          usuarios: usuarios,
        ),
      ),
    );

    if (resultado != null && resultado is TareasCompanion) {
      if (resultado.id.present) {
        await db.actualizarTareaPorId(resultado.id.value, resultado);
      } else {
        await db.insertarTarea(resultado);
      }

      setState(_cargarDatos);
    }
  }

  Color prioridadColor(String prioridad) {
    switch (prioridad.toLowerCase()) {
      case 'alta':
        return Colors.redAccent;
      case 'media':
        return Colors.orange;
      case 'baja':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF8F3FF),
      appBar: AppBar(
        title: const Text('Lista de Tareas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<List<Tarea>>(
          future: _tareasFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay tareas registradas.'));
            }

            final tareas = snapshot.data!;
            return ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return InkWell(
                  onTap: () => abrirFormulario(tarea: tarea),
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.deepPurple.withOpacity(0.3),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  tarea.titulo,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(
                                tarea.finalizada ? Icons.check_circle : Icons.timelapse,
                                color: tarea.finalizada ? Colors.green : Colors.orange,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(tarea.descripcion),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Chip(
                                label: Text('Prioridad: ${tarea.prioridad}'),
                                backgroundColor: prioridadColor(tarea.prioridad).withOpacity(0.2),
                                labelStyle: TextStyle(
                                  color: prioridadColor(tarea.prioridad),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text("Lugar: ${tarea.lugar}"),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text("Vence: ${tarea.fechaVencimiento.toLocal().toString().split(' ')[0]}"),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                onPressed: () => abrirFormulario(tarea: tarea),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => confirmarEliminacion(tarea.id),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => abrirFormulario(),
        icon: const Icon(Icons.add),
        label: const Text('Nueva Tarea'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

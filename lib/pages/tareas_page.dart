import 'package:flutter/material.dart';
import 'crear_tarea_page.dart'; // Asegúrate de importar correctamente

class TareasPage extends StatefulWidget {
  const TareasPage({super.key});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  List<Map<String, dynamic>> tareas = [
    {
      'id': 1,
      'titulo': 'Diseñar Logo',
      'descripcion': 'Hacer logo para app',
      'fechaVencimiento': '2025-06-20',
      'prioridad': 'Alta',
      'lugar': 'Remoto',
      'estado': false,
      'usuarioId': 1,
      'imagen': '',
      'horas': 5
    },
    {
      'id': 2,
      'titulo': 'Crear Base de Datos',
      'descripcion': 'Modelo inicial y relaciones',
      'fechaVencimiento': '2025-06-18',
      'prioridad': 'Media',
      'lugar': 'UCR',
      'estado': true,
      'usuarioId': 2,
      'imagen': '',
      'horas': 3
    }
  ];

  List<Map<String, dynamic>> usuarios = [
    {'id': 1, 'nombre': 'Mariano'},
    {'id': 2, 'nombre': 'Valeria'},
    {'id': 3, 'nombre': 'Jeremy'},
  ];

  void eliminarTarea(int id) {
    setState(() {
      tareas.removeWhere((tarea) => tarea['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Tarea eliminada correctamente")),
    );
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
            onPressed: () {
              Navigator.pop(ctx);
              eliminarTarea(id);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void abrirFormulario({Map<String, dynamic>? tarea}) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioTareaPage(
          tarea: tarea,
          usuarios: usuarios,
        ),
      ),
    );

    if (resultado != null && resultado is Map<String, dynamic>) {
      setState(() {
        if (tarea != null) {
          // Actualizar
          final index = tareas.indexWhere((t) => t['id'] == tarea['id']);
          if (index != -1) tareas[index] = resultado;
        } else {
          // Crear nueva tarea
          final nueva = resultado;
          nueva['id'] = tareas.isEmpty ? 1 : tareas.last['id'] + 1;
          tareas.add(nueva);
        }
      });
    }
  }

  Color prioridadColor(String prioridad) {
    switch (prioridad) {
      case 'Alta':
        return Colors.redAccent;
      case 'Media':
        return Colors.orange;
      case 'Baja':
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
        child: ListView.builder(
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
                              tarea['titulo'],
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(
                            tarea['estado'] ? Icons.check_circle : Icons.timelapse,
                            color: tarea['estado'] ? Colors.green : Colors.orange,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(tarea['descripcion']),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Chip(
                            label: Text('Prioridad: ${tarea['prioridad']}'),
                            backgroundColor: prioridadColor(tarea['prioridad']).withOpacity(0.2),
                            labelStyle: TextStyle(
                              color: prioridadColor(tarea['prioridad']),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text("Lugar: ${tarea['lugar']}"),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text("Vence: ${tarea['fechaVencimiento']}"),
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
                            onPressed: () => confirmarEliminacion(tarea['id']),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
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

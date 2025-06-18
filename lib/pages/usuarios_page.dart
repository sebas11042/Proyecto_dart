
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:taller_flutter/backend/backend.dart';
import 'package:taller_flutter/backend/db.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  late Future<List<Usuario>> _usuariosFuture;

  @override
  void initState() {
    super.initState();
    _cargarUsuarios();
  }

  void _cargarUsuarios() {
    _usuariosFuture = db.obtenerUsuarios();
  }

  void confirmarEliminacion(int id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('¿Eliminar usuario?'),
        content: const Text('Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await db.eliminarUsuario(id);
              setState(_cargarUsuarios);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Usuario eliminado correctamente")),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void mostrarFormularioAgregarUsuario() {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _nombreController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Agregar Usuario'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _nombreController,
            decoration: const InputDecoration(labelText: 'Nombre'),
            validator: (value) => value == null || value.trim().isEmpty
                ? 'Ingrese un nombre'
                : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final nombre = _nombreController.text.trim();
                await db.insertarUsuario(UsuariosCompanion(nombre: Value(nombre)));
                Navigator.pop(ctx);
                setState(_cargarUsuarios);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Usuario agregado exitosamente')),
                );
              }
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F3FF),
      appBar: AppBar(
        title: const Text('Usuarios Registrados'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 80),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FutureBuilder<List<Usuario>>(
          future: _usuariosFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No hay usuarios registrados.'));
            }

            final usuarios = snapshot.data!;
            return ListView.builder(
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                final usuario = usuarios[index];
                return Card(
                  elevation: 8,
                  shadowColor: Colors.deepPurple.withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                    leading: const Icon(Icons.person, size: 30, color: Colors.deepPurple),
                    title: Text(
                      usuario.nombre,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => confirmarEliminacion(usuario.id),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: mostrarFormularioAgregarUsuario,
        icon: const Icon(Icons.add),
        label: const Text('Agregar Usuario'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

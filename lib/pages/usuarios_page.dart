import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  List<Map<String, dynamic>> usuarios = [
    {'id': 1, 'nombre': 'Mariano'},
    {'id': 2, 'nombre': 'Valeria'},
    {'id': 3, 'nombre': 'Jeremy'},
  ];

  void eliminarUsuario(int id) {
    setState(() {
      usuarios.removeWhere((usuario) => usuario['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Usuario eliminado correctamente")),
    );
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
            onPressed: () {
              Navigator.pop(ctx);
              eliminarUsuario(id);
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void editarUsuario({Map<String, dynamic>? usuario}) async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FormularioUsuarioPage(usuario: usuario),
      ),
    );

    if (resultado != null && resultado is Map<String, dynamic>) {
      setState(() {
        if (usuario != null) {
          // Actualizar
          final index = usuarios.indexWhere((u) => u['id'] == usuario['id']);
          if (index != -1) usuarios[index] = resultado;
        } else {
          // Crear nuevo
          usuarios.add({
            'id': usuarios.isEmpty ? 1 : usuarios.last['id'] + 1,
            'nombre': resultado['nombre'],
          });
        }
      });
    }
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
        child: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            final usuario = usuarios[index];
            return InkWell(
              onTap: () => editarUsuario(usuario: usuario),
              child: Card(
                elevation: 8,
                shadowColor: Colors.deepPurple.withOpacity(0.3),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
                  leading: const Icon(Icons.person, size: 30, color: Colors.deepPurple),
                  title: Text(
                    usuario['nombre'],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blueAccent),
                        onPressed: () => editarUsuario(usuario: usuario),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => confirmarEliminacion(usuario['id']),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => editarUsuario(),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Usuario'),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

class FormularioUsuarioPage extends StatefulWidget {
  final Map<String, dynamic>? usuario;
  const FormularioUsuarioPage({super.key, this.usuario});

  @override
  State<FormularioUsuarioPage> createState() => _FormularioUsuarioPageState();
}

class _FormularioUsuarioPageState extends State<FormularioUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreController;

  @override
  void initState() {
    super.initState();
    _nombreController =
        TextEditingController(text: widget.usuario?['nombre'] ?? '');
  }

  @override
  void dispose() {
    _nombreController.dispose();
    super.dispose();
  }

  void guardar() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, {
        'id': widget.usuario?['id'],
        'nombre': _nombreController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.usuario != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Usuario' : 'Nuevo Usuario'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del usuario',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor ingrese un nombre';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: guardar,
                icon: const Icon(Icons.save),
                label: Text(esEdicion ? 'Actualizar' : 'Guardar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  minimumSize: const Size(double.infinity, 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

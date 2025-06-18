import 'package:flutter/material.dart';
import 'package:drift/drift.dart' show Value;
import 'package:taller_flutter/backend/db.dart';

class FormularioTareaPage extends StatefulWidget {
  final Tarea? tarea;
  final List<Usuario> usuarios;

  const FormularioTareaPage({super.key, this.tarea, required this.usuarios});

  @override
  State<FormularioTareaPage> createState() => _FormularioTareaPageState();
}

class _FormularioTareaPageState extends State<FormularioTareaPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _descripcionController;
  late TextEditingController _lugarController;
  late TextEditingController _horasController;
  late TextEditingController _imagenController;

  DateTime? _fechaVencimiento;
  bool _estado = false;
  String? _prioridad;
  int? _usuarioId;

  @override
  void initState() {
    super.initState();
    final t = widget.tarea;
    _tituloController = TextEditingController(text: t?.titulo ?? '');
    _descripcionController = TextEditingController(text: t?.descripcion ?? '');
    _lugarController = TextEditingController(text: t?.lugar ?? '');
    _horasController = TextEditingController(text: t?.horas.toString() ?? '');
    _imagenController = TextEditingController(text: t?.imagenRuta ?? '');
    _fechaVencimiento = t?.fechaVencimiento;
    _estado = t?.estado == 'finalizada';
    _prioridad = t?.prioridad;
    _usuarioId = t?.usuarioId;
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descripcionController.dispose();
    _lugarController.dispose();
    _horasController.dispose();
    _imagenController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (_formKey.currentState!.validate() && _fechaVencimiento != null) {
      final nuevaTarea = TareasCompanion(
        id: widget.tarea != null ? Value(widget.tarea!.id) : const Value.absent(),
        titulo: Value(_tituloController.text.trim()),
        descripcion: Value(_descripcionController.text.trim()),
        fechaVencimiento: Value(_fechaVencimiento!),
        estado: Value(_estado ? 'finalizada' : 'pendiente'),
        prioridad: Value(_prioridad!),
        lugar: Value(_lugarController.text.trim()),
        horas: Value(double.tryParse(_horasController.text.trim()) ?? 0),
        imagenRuta: Value(_imagenController.text.trim()),
        finalizada: Value(_estado),
        usuarioId: Value(_usuarioId!),
      );

      Navigator.pop(context, nuevaTarea);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
    }
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaVencimiento ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => _fechaVencimiento = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final esEdicion = widget.tarea != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(esEdicion ? 'Editar Tarea' : 'Nueva Tarea'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => v!.trim().isEmpty ? 'Requerido' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _fechaVencimiento != null
                          ? "Fecha: ${_fechaVencimiento!.toLocal().toString().split(' ')[0]}"
                          : "Seleccione fecha de vencimiento",
                    ),
                  ),
                  TextButton(
                    onPressed: _seleccionarFecha,
                    child: const Text('Elegir Fecha'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SwitchListTile(
                value: _estado,
                onChanged: (v) => setState(() => _estado = v),
                title: const Text('¿Está finalizada?'),
              ),
              DropdownButtonFormField<String>(
                value: _prioridad,
                decoration: const InputDecoration(
                  labelText: 'Prioridad',
                  border: OutlineInputBorder(),
                ),
                items: [
                  DropdownMenuItem(value: 'alta', child: Text('Alta')),
                  DropdownMenuItem(value: 'media', child: Text('Media')),
                  DropdownMenuItem(value: 'baja', child: Text('Baja')),
                ],
                onChanged: (v) => setState(() => _prioridad = v),
                validator: (v) => v == null ? 'Seleccione prioridad' : null,
              ),

              const SizedBox(height: 12),
              TextFormField(
                controller: _lugarController,
                decoration: const InputDecoration(
                  labelText: 'Lugar',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _horasController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad de horas',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _imagenController,
                decoration: const InputDecoration(
                  labelText: 'Ruta de imagen',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<int>(
                value: _usuarioId,
                decoration: const InputDecoration(
                  labelText: 'Usuario Responsable',
                  border: OutlineInputBorder(),
                ),
                items: widget.usuarios
                    .map((u) => DropdownMenuItem<int>(
                          value: u.id,
                          child: Text(u.nombre),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _usuarioId = v),
                validator: (v) => v == null ? 'Seleccione un usuario' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _guardar,
                icon: const Icon(Icons.save),
                label: Text(esEdicion ? 'Actualizar' : 'Guardar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
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

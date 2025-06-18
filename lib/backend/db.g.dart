// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int id;
  final String nombre;
  const Usuario({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(id: Value(id), nombre: Value(nombre));
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Usuario copyWith({int? id, String? nombre}) =>
      Usuario(id: id ?? this.id, nombre: nombre ?? this.nombre);
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario && other.id == this.id && other.nombre == this.nombre);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> id;
  final Value<String> nombre;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Usuario> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  UsuariosCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return UsuariosCompanion(id: id ?? this.id, nombre: nombre ?? this.nombre);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $TareasTable extends Tareas with TableInfo<$TareasTable, Tarea> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TareasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tituloMeta = const VerificationMeta('titulo');
  @override
  late final GeneratedColumn<String> titulo = GeneratedColumn<String>(
    'titulo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaVencimientoMeta = const VerificationMeta(
    'fechaVencimiento',
  );
  @override
  late final GeneratedColumn<DateTime> fechaVencimiento =
      GeneratedColumn<DateTime>(
        'fecha_vencimiento',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _prioridadMeta = const VerificationMeta(
    'prioridad',
  );
  @override
  late final GeneratedColumn<String> prioridad = GeneratedColumn<String>(
    'prioridad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lugarMeta = const VerificationMeta('lugar');
  @override
  late final GeneratedColumn<String> lugar = GeneratedColumn<String>(
    'lugar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horasMeta = const VerificationMeta('horas');
  @override
  late final GeneratedColumn<double> horas = GeneratedColumn<double>(
    'horas',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagenRutaMeta = const VerificationMeta(
    'imagenRuta',
  );
  @override
  late final GeneratedColumn<String> imagenRuta = GeneratedColumn<String>(
    'imagen_ruta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finalizadaMeta = const VerificationMeta(
    'finalizada',
  );
  @override
  late final GeneratedColumn<bool> finalizada = GeneratedColumn<bool>(
    'finalizada',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("finalizada" IN (0, 1))',
    ),
    defaultValue: Constant(false),
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<int> usuarioId = GeneratedColumn<int>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    titulo,
    descripcion,
    estado,
    fechaVencimiento,
    prioridad,
    lugar,
    horas,
    imagenRuta,
    finalizada,
    usuarioId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tareas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarea> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('titulo')) {
      context.handle(
        _tituloMeta,
        titulo.isAcceptableOrUnknown(data['titulo']!, _tituloMeta),
      );
    } else if (isInserting) {
      context.missing(_tituloMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('fecha_vencimiento')) {
      context.handle(
        _fechaVencimientoMeta,
        fechaVencimiento.isAcceptableOrUnknown(
          data['fecha_vencimiento']!,
          _fechaVencimientoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaVencimientoMeta);
    }
    if (data.containsKey('prioridad')) {
      context.handle(
        _prioridadMeta,
        prioridad.isAcceptableOrUnknown(data['prioridad']!, _prioridadMeta),
      );
    } else if (isInserting) {
      context.missing(_prioridadMeta);
    }
    if (data.containsKey('lugar')) {
      context.handle(
        _lugarMeta,
        lugar.isAcceptableOrUnknown(data['lugar']!, _lugarMeta),
      );
    } else if (isInserting) {
      context.missing(_lugarMeta);
    }
    if (data.containsKey('horas')) {
      context.handle(
        _horasMeta,
        horas.isAcceptableOrUnknown(data['horas']!, _horasMeta),
      );
    } else if (isInserting) {
      context.missing(_horasMeta);
    }
    if (data.containsKey('imagen_ruta')) {
      context.handle(
        _imagenRutaMeta,
        imagenRuta.isAcceptableOrUnknown(data['imagen_ruta']!, _imagenRutaMeta),
      );
    } else if (isInserting) {
      context.missing(_imagenRutaMeta);
    }
    if (data.containsKey('finalizada')) {
      context.handle(
        _finalizadaMeta,
        finalizada.isAcceptableOrUnknown(data['finalizada']!, _finalizadaMeta),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarea map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarea(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      titulo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titulo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      fechaVencimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_vencimiento'],
      )!,
      prioridad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prioridad'],
      )!,
      lugar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lugar'],
      )!,
      horas: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}horas'],
      )!,
      imagenRuta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}imagen_ruta'],
      )!,
      finalizada: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}finalizada'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usuario_id'],
      )!,
    );
  }

  @override
  $TareasTable createAlias(String alias) {
    return $TareasTable(attachedDatabase, alias);
  }
}

class Tarea extends DataClass implements Insertable<Tarea> {
  final int id;
  final String titulo;
  final String descripcion;
  final String estado;
  final DateTime fechaVencimiento;
  final String prioridad;
  final String lugar;
  final double horas;
  final String imagenRuta;
  final bool finalizada;
  final int usuarioId;
  const Tarea({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.estado,
    required this.fechaVencimiento,
    required this.prioridad,
    required this.lugar,
    required this.horas,
    required this.imagenRuta,
    required this.finalizada,
    required this.usuarioId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['titulo'] = Variable<String>(titulo);
    map['descripcion'] = Variable<String>(descripcion);
    map['estado'] = Variable<String>(estado);
    map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento);
    map['prioridad'] = Variable<String>(prioridad);
    map['lugar'] = Variable<String>(lugar);
    map['horas'] = Variable<double>(horas);
    map['imagen_ruta'] = Variable<String>(imagenRuta);
    map['finalizada'] = Variable<bool>(finalizada);
    map['usuario_id'] = Variable<int>(usuarioId);
    return map;
  }

  TareasCompanion toCompanion(bool nullToAbsent) {
    return TareasCompanion(
      id: Value(id),
      titulo: Value(titulo),
      descripcion: Value(descripcion),
      estado: Value(estado),
      fechaVencimiento: Value(fechaVencimiento),
      prioridad: Value(prioridad),
      lugar: Value(lugar),
      horas: Value(horas),
      imagenRuta: Value(imagenRuta),
      finalizada: Value(finalizada),
      usuarioId: Value(usuarioId),
    );
  }

  factory Tarea.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarea(
      id: serializer.fromJson<int>(json['id']),
      titulo: serializer.fromJson<String>(json['titulo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      estado: serializer.fromJson<String>(json['estado']),
      fechaVencimiento: serializer.fromJson<DateTime>(json['fechaVencimiento']),
      prioridad: serializer.fromJson<String>(json['prioridad']),
      lugar: serializer.fromJson<String>(json['lugar']),
      horas: serializer.fromJson<double>(json['horas']),
      imagenRuta: serializer.fromJson<String>(json['imagenRuta']),
      finalizada: serializer.fromJson<bool>(json['finalizada']),
      usuarioId: serializer.fromJson<int>(json['usuarioId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'titulo': serializer.toJson<String>(titulo),
      'descripcion': serializer.toJson<String>(descripcion),
      'estado': serializer.toJson<String>(estado),
      'fechaVencimiento': serializer.toJson<DateTime>(fechaVencimiento),
      'prioridad': serializer.toJson<String>(prioridad),
      'lugar': serializer.toJson<String>(lugar),
      'horas': serializer.toJson<double>(horas),
      'imagenRuta': serializer.toJson<String>(imagenRuta),
      'finalizada': serializer.toJson<bool>(finalizada),
      'usuarioId': serializer.toJson<int>(usuarioId),
    };
  }

  Tarea copyWith({
    int? id,
    String? titulo,
    String? descripcion,
    String? estado,
    DateTime? fechaVencimiento,
    String? prioridad,
    String? lugar,
    double? horas,
    String? imagenRuta,
    bool? finalizada,
    int? usuarioId,
  }) => Tarea(
    id: id ?? this.id,
    titulo: titulo ?? this.titulo,
    descripcion: descripcion ?? this.descripcion,
    estado: estado ?? this.estado,
    fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
    prioridad: prioridad ?? this.prioridad,
    lugar: lugar ?? this.lugar,
    horas: horas ?? this.horas,
    imagenRuta: imagenRuta ?? this.imagenRuta,
    finalizada: finalizada ?? this.finalizada,
    usuarioId: usuarioId ?? this.usuarioId,
  );
  Tarea copyWithCompanion(TareasCompanion data) {
    return Tarea(
      id: data.id.present ? data.id.value : this.id,
      titulo: data.titulo.present ? data.titulo.value : this.titulo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      estado: data.estado.present ? data.estado.value : this.estado,
      fechaVencimiento: data.fechaVencimiento.present
          ? data.fechaVencimiento.value
          : this.fechaVencimiento,
      prioridad: data.prioridad.present ? data.prioridad.value : this.prioridad,
      lugar: data.lugar.present ? data.lugar.value : this.lugar,
      horas: data.horas.present ? data.horas.value : this.horas,
      imagenRuta: data.imagenRuta.present
          ? data.imagenRuta.value
          : this.imagenRuta,
      finalizada: data.finalizada.present
          ? data.finalizada.value
          : this.finalizada,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarea(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('estado: $estado, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('prioridad: $prioridad, ')
          ..write('lugar: $lugar, ')
          ..write('horas: $horas, ')
          ..write('imagenRuta: $imagenRuta, ')
          ..write('finalizada: $finalizada, ')
          ..write('usuarioId: $usuarioId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    titulo,
    descripcion,
    estado,
    fechaVencimiento,
    prioridad,
    lugar,
    horas,
    imagenRuta,
    finalizada,
    usuarioId,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarea &&
          other.id == this.id &&
          other.titulo == this.titulo &&
          other.descripcion == this.descripcion &&
          other.estado == this.estado &&
          other.fechaVencimiento == this.fechaVencimiento &&
          other.prioridad == this.prioridad &&
          other.lugar == this.lugar &&
          other.horas == this.horas &&
          other.imagenRuta == this.imagenRuta &&
          other.finalizada == this.finalizada &&
          other.usuarioId == this.usuarioId);
}

class TareasCompanion extends UpdateCompanion<Tarea> {
  final Value<int> id;
  final Value<String> titulo;
  final Value<String> descripcion;
  final Value<String> estado;
  final Value<DateTime> fechaVencimiento;
  final Value<String> prioridad;
  final Value<String> lugar;
  final Value<double> horas;
  final Value<String> imagenRuta;
  final Value<bool> finalizada;
  final Value<int> usuarioId;
  const TareasCompanion({
    this.id = const Value.absent(),
    this.titulo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.estado = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.prioridad = const Value.absent(),
    this.lugar = const Value.absent(),
    this.horas = const Value.absent(),
    this.imagenRuta = const Value.absent(),
    this.finalizada = const Value.absent(),
    this.usuarioId = const Value.absent(),
  });
  TareasCompanion.insert({
    this.id = const Value.absent(),
    required String titulo,
    required String descripcion,
    required String estado,
    required DateTime fechaVencimiento,
    required String prioridad,
    required String lugar,
    required double horas,
    required String imagenRuta,
    this.finalizada = const Value.absent(),
    required int usuarioId,
  }) : titulo = Value(titulo),
       descripcion = Value(descripcion),
       estado = Value(estado),
       fechaVencimiento = Value(fechaVencimiento),
       prioridad = Value(prioridad),
       lugar = Value(lugar),
       horas = Value(horas),
       imagenRuta = Value(imagenRuta),
       usuarioId = Value(usuarioId);
  static Insertable<Tarea> custom({
    Expression<int>? id,
    Expression<String>? titulo,
    Expression<String>? descripcion,
    Expression<String>? estado,
    Expression<DateTime>? fechaVencimiento,
    Expression<String>? prioridad,
    Expression<String>? lugar,
    Expression<double>? horas,
    Expression<String>? imagenRuta,
    Expression<bool>? finalizada,
    Expression<int>? usuarioId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (titulo != null) 'titulo': titulo,
      if (descripcion != null) 'descripcion': descripcion,
      if (estado != null) 'estado': estado,
      if (fechaVencimiento != null) 'fecha_vencimiento': fechaVencimiento,
      if (prioridad != null) 'prioridad': prioridad,
      if (lugar != null) 'lugar': lugar,
      if (horas != null) 'horas': horas,
      if (imagenRuta != null) 'imagen_ruta': imagenRuta,
      if (finalizada != null) 'finalizada': finalizada,
      if (usuarioId != null) 'usuario_id': usuarioId,
    });
  }

  TareasCompanion copyWith({
    Value<int>? id,
    Value<String>? titulo,
    Value<String>? descripcion,
    Value<String>? estado,
    Value<DateTime>? fechaVencimiento,
    Value<String>? prioridad,
    Value<String>? lugar,
    Value<double>? horas,
    Value<String>? imagenRuta,
    Value<bool>? finalizada,
    Value<int>? usuarioId,
  }) {
    return TareasCompanion(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      estado: estado ?? this.estado,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      prioridad: prioridad ?? this.prioridad,
      lugar: lugar ?? this.lugar,
      horas: horas ?? this.horas,
      imagenRuta: imagenRuta ?? this.imagenRuta,
      finalizada: finalizada ?? this.finalizada,
      usuarioId: usuarioId ?? this.usuarioId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (titulo.present) {
      map['titulo'] = Variable<String>(titulo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (fechaVencimiento.present) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento.value);
    }
    if (prioridad.present) {
      map['prioridad'] = Variable<String>(prioridad.value);
    }
    if (lugar.present) {
      map['lugar'] = Variable<String>(lugar.value);
    }
    if (horas.present) {
      map['horas'] = Variable<double>(horas.value);
    }
    if (imagenRuta.present) {
      map['imagen_ruta'] = Variable<String>(imagenRuta.value);
    }
    if (finalizada.present) {
      map['finalizada'] = Variable<bool>(finalizada.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<int>(usuarioId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TareasCompanion(')
          ..write('id: $id, ')
          ..write('titulo: $titulo, ')
          ..write('descripcion: $descripcion, ')
          ..write('estado: $estado, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('prioridad: $prioridad, ')
          ..write('lugar: $lugar, ')
          ..write('horas: $horas, ')
          ..write('imagenRuta: $imagenRuta, ')
          ..write('finalizada: $finalizada, ')
          ..write('usuarioId: $usuarioId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $TareasTable tareas = $TareasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [usuarios, tareas];
}

typedef $$UsuariosTableCreateCompanionBuilder =
    UsuariosCompanion Function({Value<int> id, required String nombre});
typedef $$UsuariosTableUpdateCompanionBuilder =
    UsuariosCompanion Function({Value<int> id, Value<String> nombre});

final class $$UsuariosTableReferences
    extends BaseReferences<_$AppDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$TareasTable, List<Tarea>> _tareasRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tareas,
    aliasName: $_aliasNameGenerator(db.usuarios.id, db.tareas.usuarioId),
  );

  $$TareasTableProcessedTableManager get tareasRefs {
    final manager = $$TareasTableTableManager(
      $_db,
      $_db.tareas,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_tareasRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> tareasRefs(
    Expression<bool> Function($$TareasTableFilterComposer f) f,
  ) {
    final $$TareasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TareasTableFilterComposer(
            $db: $db,
            $table: $db.tareas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> tareasRefs<T extends Object>(
    Expression<T> Function($$TareasTableAnnotationComposer a) f,
  ) {
    final $$TareasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tareas,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TareasTableAnnotationComposer(
            $db: $db,
            $table: $db.tareas,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({bool tareasRefs})
        > {
  $$UsuariosTableTableManager(_$AppDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
              }) => UsuariosCompanion(id: id, nombre: nombre),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
              }) => UsuariosCompanion.insert(id: id, nombre: nombre),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tareasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tareasRefs) db.tareas],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tareasRefs)
                    await $_getPrefetchedData<Usuario, $UsuariosTable, Tarea>(
                      currentTable: table,
                      referencedTable: $$UsuariosTableReferences
                          ._tareasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UsuariosTableReferences(db, table, p0).tareasRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.usuarioId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({bool tareasRefs})
    >;
typedef $$TareasTableCreateCompanionBuilder =
    TareasCompanion Function({
      Value<int> id,
      required String titulo,
      required String descripcion,
      required String estado,
      required DateTime fechaVencimiento,
      required String prioridad,
      required String lugar,
      required double horas,
      required String imagenRuta,
      Value<bool> finalizada,
      required int usuarioId,
    });
typedef $$TareasTableUpdateCompanionBuilder =
    TareasCompanion Function({
      Value<int> id,
      Value<String> titulo,
      Value<String> descripcion,
      Value<String> estado,
      Value<DateTime> fechaVencimiento,
      Value<String> prioridad,
      Value<String> lugar,
      Value<double> horas,
      Value<String> imagenRuta,
      Value<bool> finalizada,
      Value<int> usuarioId,
    });

final class $$TareasTableReferences
    extends BaseReferences<_$AppDatabase, $TareasTable, Tarea> {
  $$TareasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$AppDatabase db) => db.usuarios
      .createAlias($_aliasNameGenerator(db.tareas.usuarioId, db.usuarios.id));

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<int>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TareasTableFilterComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lugar => $composableBuilder(
    column: $table.lugar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get horas => $composableBuilder(
    column: $table.horas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagenRuta => $composableBuilder(
    column: $table.imagenRuta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableOrderingComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titulo => $composableBuilder(
    column: $table.titulo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prioridad => $composableBuilder(
    column: $table.prioridad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lugar => $composableBuilder(
    column: $table.lugar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get horas => $composableBuilder(
    column: $table.horas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagenRuta => $composableBuilder(
    column: $table.imagenRuta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TareasTable> {
  $$TareasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get titulo =>
      $composableBuilder(column: $table.titulo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get prioridad =>
      $composableBuilder(column: $table.prioridad, builder: (column) => column);

  GeneratedColumn<String> get lugar =>
      $composableBuilder(column: $table.lugar, builder: (column) => column);

  GeneratedColumn<double> get horas =>
      $composableBuilder(column: $table.horas, builder: (column) => column);

  GeneratedColumn<String> get imagenRuta => $composableBuilder(
    column: $table.imagenRuta,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get finalizada => $composableBuilder(
    column: $table.finalizada,
    builder: (column) => column,
  );

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TareasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TareasTable,
          Tarea,
          $$TareasTableFilterComposer,
          $$TareasTableOrderingComposer,
          $$TareasTableAnnotationComposer,
          $$TareasTableCreateCompanionBuilder,
          $$TareasTableUpdateCompanionBuilder,
          (Tarea, $$TareasTableReferences),
          Tarea,
          PrefetchHooks Function({bool usuarioId})
        > {
  $$TareasTableTableManager(_$AppDatabase db, $TareasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TareasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TareasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TareasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> titulo = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<DateTime> fechaVencimiento = const Value.absent(),
                Value<String> prioridad = const Value.absent(),
                Value<String> lugar = const Value.absent(),
                Value<double> horas = const Value.absent(),
                Value<String> imagenRuta = const Value.absent(),
                Value<bool> finalizada = const Value.absent(),
                Value<int> usuarioId = const Value.absent(),
              }) => TareasCompanion(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                estado: estado,
                fechaVencimiento: fechaVencimiento,
                prioridad: prioridad,
                lugar: lugar,
                horas: horas,
                imagenRuta: imagenRuta,
                finalizada: finalizada,
                usuarioId: usuarioId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String titulo,
                required String descripcion,
                required String estado,
                required DateTime fechaVencimiento,
                required String prioridad,
                required String lugar,
                required double horas,
                required String imagenRuta,
                Value<bool> finalizada = const Value.absent(),
                required int usuarioId,
              }) => TareasCompanion.insert(
                id: id,
                titulo: titulo,
                descripcion: descripcion,
                estado: estado,
                fechaVencimiento: fechaVencimiento,
                prioridad: prioridad,
                lugar: lugar,
                horas: horas,
                imagenRuta: imagenRuta,
                finalizada: finalizada,
                usuarioId: usuarioId,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TareasTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (usuarioId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.usuarioId,
                                referencedTable: $$TareasTableReferences
                                    ._usuarioIdTable(db),
                                referencedColumn: $$TareasTableReferences
                                    ._usuarioIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TareasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TareasTable,
      Tarea,
      $$TareasTableFilterComposer,
      $$TareasTableOrderingComposer,
      $$TareasTableAnnotationComposer,
      $$TareasTableCreateCompanionBuilder,
      $$TareasTableUpdateCompanionBuilder,
      (Tarea, $$TareasTableReferences),
      Tarea,
      PrefetchHooks Function({bool usuarioId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$TareasTableTableManager get tareas =>
      $$TareasTableTableManager(_db, _db.tareas);
}

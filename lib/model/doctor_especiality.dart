import 'package:flutter/material.dart';

final String doctorEspecialityTable = 'doctor_especiality';

class DoctorEspecialityFields {
  static final List<String> values = [
    id,
    name,
  ];

  static final String id = 'id';
  static final String name = 'name';
}
class DoctorEspeciality {
  final int id;
  final String name;

  const DoctorEspeciality({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  static DoctorEspeciality fromMap(Map map) {
    return DoctorEspeciality(
      id: map['id'],
      name: map['name'],
    );
  }

  @override
  String toString() {
    return 'DoctorEspeciality{id: $id, name: $name}';
  }
}
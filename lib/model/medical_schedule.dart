import 'package:flutter/material.dart';

final String medicalScheduleTable = 'medical_schedule';

class MedicalScheduleFields {
  static final List<String> values = [
    id,
    doctorId,
    patientId,
    date,
    startTime,
    endTime,
    status,
  ];

  static final String id = 'id';
  static final String doctorId = 'doctorId';
  static final String patientId = 'patientId';
  static final String date = 'date';
  static final String startTime = 'startTime';
  static final String endTime = 'endTime';
  static final String status = 'status';
}

class MedicalSchedule {
  final int id;
  final int doctorId;
  final int patientId;
  final String date;
  final String startTime;
  final String endTime;
  final String status;

  const MedicalSchedule({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
    };
  }

  static MedicalSchedule fromMap(Map map) {
    return MedicalSchedule(
      id: map['id'],
      doctorId: map['doctorId'],
      patientId: map['patientId'],
      date: map['date'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      status: map['status'],
    );
  }

  @override
  String toString() {
    return 'MedicalSchedule{id: $id, doctorId: $doctorId, patientId: $patientId, date: $date, startTime: $startTime, endTime: $endTime, status: $status}';
  }
}
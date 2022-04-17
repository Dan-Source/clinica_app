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

  const MedicalSchedule({
    required this.id,
    required this.doctorId,
    required this.patientId,
    required this.date,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'doctorId': doctorId,
      'patientId': patientId,
      'date': date,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  @override
  String toString() {
    return 'MedicalSchedule{id: $id, doctorId: $doctorId, patientId: $patientId, date: $date, startTime: $startTime, endTime: $endTime}';
  }
}
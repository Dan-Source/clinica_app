import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:clinica_app/model/doctor_especiality.dart';
import 'package:clinica_app/model/doctor.dart';
import 'package:clinica_app/model/medical_schedule.dart';
import 'package:clinica_app/model/patient.dart';


class ClinicaDatabase {
  static final ClinicaDatabase instance = ClinicaDatabase._init();

  static Database? _database;

  ClinicaDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase('clinica_teste4.db');
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final integerType = 'INTEGER NOT NULL';
    final integerTypeNull = 'INTEGER';

    await db.execute('''
      CREATE TABLE $doctorEspecialityTable (
        ${DoctorEspecialityFields.id} $idType,
        ${DoctorEspecialityFields.name} $textType
      )
    ''');
    await db.execute('''
      CREATE TABLE $doctorTable (
        ${DoctorFields.id} $idType,
        ${DoctorFields.name} $textType,
        ${DoctorFields.crm} $textType,
        ${DoctorFields.email} $textType,
        ${DoctorFields.phone} $textType,
        ${DoctorFields.especialityId} $integerType
      )
    ''',);
    await db.execute('''
      CREATE TABLE $medicalScheduleTable (
        ${MedicalScheduleFields.id} $idType,
        ${MedicalScheduleFields.doctorId} $integerType,
        ${MedicalScheduleFields.patientId} $integerTypeNull,
        ${MedicalScheduleFields.date} $textType,
        ${MedicalScheduleFields.startTime} $textType,
        ${MedicalScheduleFields.endTime} $textType,
        ${MedicalScheduleFields.status} $textType
      )
    ''');
    await db.execute('''
      CREATE TABLE $patientTable (
        ${PatientFields.id} $idType,
        ${PatientFields.name} $textType,
        ${PatientFields.cpf} $textType,
        ${PatientFields.email} $textType,
        ${PatientFields.phone} $textType
      )
    ''');
  }

  Future<void> insertDoctorEspeciality(DoctorEspeciality doctorEspeciality) async {
    final Database db = await instance.database;
    await db.insert(
      doctorEspecialityTable,
      doctorEspeciality.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDoctor(Doctor doctor) async {
    final Database db = await instance.database;
    await db.insert(
      'doctor',
      doctor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMedicalSchedule(MedicalSchedule medicalSchedule) async {
    final Database db = await instance.database;
    await db.insert(
      'medical_schedule',
      medicalSchedule.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertPatient(Patient patient) async {
    final Database db = await instance.database;
    await db.insert(
      'patient',
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DoctorEspeciality>> doctorEspecialities() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('doctor_especiality');
    return List.generate(maps.length, (i) {
      return DoctorEspeciality(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<List<Doctor>> doctors() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('doctor');
    return List.generate(maps.length, (i) {
      return Doctor(
        id: maps[i]['id'],
        name: maps[i]['name'],
        crm: maps[i]['crm'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
        especialityId: maps[i]['especialityId'],
      );
    });
  }

  Future<List<MedicalSchedule>> medicalSchedules() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('medical_schedule');
    return List.generate(maps.length, (i) {
      return MedicalSchedule(
        id: maps[i]['id'],
        doctorId: maps[i]['doctorId'],
        patientId: maps[i]['patientId'],
        date: maps[i]['date'],
        startTime: maps[i]['startTime'],
        endTime: maps[i]['endTime'],
      );
    });
  }

  Future<List<Patient>> patients() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('patient');
    return List.generate(maps.length, (i) {
      return Patient(
        id: maps[i]['id'],
        name: maps[i]['name'],
        cpf: maps[i]['cpf'],
        email: maps[i]['email'],
        phone: maps[i]['phone'],
      );
    });
  }

  Future<void> updateDoctorEspeciality(DoctorEspeciality doctorEspeciality) async {
    final db = await database;
    await db.update(
      'doctor_especiality',
      doctorEspeciality.toMap(),
      where: "id = ?",
      whereArgs: [doctorEspeciality.id],
    );
  }

  Future<void> deleteDoctorEspeciality(int id) async {
    final db = await database;
    await db.delete(
      'doctor_especiality',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
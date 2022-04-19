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
    final foreignKeyType = 'FOREIGN KEY';

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
        ${DoctorFields.especialityId} $integerType,
        $foreignKeyType (${DoctorFields.especialityId}, $doctorEspecialityTable(${DoctorFields.especialityId}))
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
      doctorTable,
      doctor.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMedicalSchedule(MedicalSchedule medicalSchedule) async {
    final Database db = await instance.database;
    await db.insert(
      medicalScheduleTable,
      medicalSchedule.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertPatient(Patient patient) async {
    final Database db = await instance.database;
    await db.insert(
      patientTable,
      patient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<DoctorEspeciality> fetchDoctorEspeciality(int id) async {
    final Database db = await instance.database;
    final List<Map> maps = await db.query(
      doctorEspecialityTable,
      where: '${DoctorEspecialityFields.id} = ?',
      whereArgs: [id],
    );
    DoctorEspeciality especiality = DoctorEspeciality.fromMap(maps[0]);
    return especiality;
  }

  Future<MedicalSchedule> fetchMedicalSchedule(int id) async {
    final Database db = await instance.database;
    final List<Map> maps = await db.query(
      medicalScheduleTable,
      where: '${MedicalScheduleFields.id} = ?',
      whereArgs: [id],
    );
    MedicalSchedule medicalSchedule = MedicalSchedule.fromMap(maps[0]);
    return medicalSchedule;
  }

  Future<List<DoctorEspeciality>> doctorEspecialities() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(doctorEspecialityTable);
    return List.generate(maps.length, (i) {
      return DoctorEspeciality(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<List<Doctor>> doctors() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(doctorTable);
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
    final List<Map<String, dynamic>> maps = await db.query(medicalScheduleTable);
    return List.generate(maps.length, (i) {
      return MedicalSchedule(
        id: maps[i]['id'],
        doctorId: maps[i]['doctorId'],
        patientId: maps[i]['patientId'],
        date: maps[i]['date'],
        startTime: maps[i]['startTime'],
        endTime: maps[i]['endTime'],
        status: maps[i]['status'],
      );
    });
  }

  Future<List<Patient>> patients() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(patientTable);
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

  Future<void> updateDoctor(Doctor doctor)  async {
    final db = await database;
    await db.update(
      'doctor',
      doctor.toMap(),
      where: "id = ?",
      whereArgs: [doctor.id],
    );
  }

  Future<void> updateMedicalSchedule(MedicalSchedule medicalSchedule) async {
    final db = await database;
    await db.update(
      'medical_schedule',
      medicalSchedule.toMap(),
      where: "id = ?",
      whereArgs: [medicalSchedule.id],
    );
  }

  Future<void> updatePatient(Patient patient) async {
    final db = await database;
    await db.update(
      'patient',
      patient.toMap(),
      where: "id = ?",
      whereArgs: [patient.id],
    );
  }

  Future<void> deleteDoctorEspeciality(int id) async {
    final db = await database;
    await db.delete(
      doctorEspecialityTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteDoctor(int id) async {
    final db = await database;
    await db.delete(
      doctorTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteMedicalSchedule(int id) async {
    final db = await database;
    await db.delete(
      medicalScheduleTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deletePatient(int id) async {
    final db = await database;
    await db.delete(
      patientTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:clinica_app/model/doctor_especiality.dart';
import 'package:clinica_app/model/doctor.dart';
import 'package:clinica_app/model/medical_schedule.dart';
import 'package:clinica_app/model/patient.dart';
import 'package:clinica_app/db/clinica_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 
  // Create a Doctor Especiality and insert in the table
  var cardiologia = const DoctorEspeciality(
      id: 1,
      name: 'Cardiologia',
  );
  var neurologia = const DoctorEspeciality(
      id: 2,
      name: 'Neurologia',
  );
  var dermatologia = const DoctorEspeciality(
      id: 3,
      name: 'Derma',
  );
  await ClinicaDatabase.instance.insertDoctorEspeciality(cardiologia);
  await ClinicaDatabase.instance.insertDoctorEspeciality(neurologia);
  await ClinicaDatabase.instance.insertDoctorEspeciality(dermatologia);

  print(await ClinicaDatabase.instance.doctorEspecialities());

  // Update a Doctor Especiality 
  var dermatologiaUpdated = const DoctorEspeciality(
      id: 3,
      name: 'Dermatologia Updated',
  );

  await ClinicaDatabase.instance.updateDoctorEspeciality(dermatologiaUpdated);

  print(await ClinicaDatabase.instance.doctorEspecialities());

  // Delete a Doctor Especiality
  await ClinicaDatabase.instance.deleteDoctorEspeciality(cardiologia.id);
  print(await ClinicaDatabase.instance.doctorEspecialities());

  var joao = const Doctor(
    id: 1,
    name: 'Dr. João',
    crm: '12345',
    email: 'joao@mail.com',
    phone: '11 99999-9999',
    especialityId: 3,
  );

  await ClinicaDatabase.instance.insertDoctor(joao);

  print(await ClinicaDatabase.instance.doctors());

  var maria = const Doctor(
    id: 2,
    name: 'Dr. Maria',
    crm: '54321',
    email: 'maria@mail.com',
    phone: '11 99999-9999',
    especialityId: 3,
  );

  await ClinicaDatabase.instance.insertDoctor(maria);
  print(await ClinicaDatabase.instance.doctors());

  var patient = const Patient(
    id: 1,
    name: 'João da Silva',
    cpf: '123.456.789-00',
    phone: '11 99999-9999',
    email: 'joao@mail.com',
  );

  var patient2 = const Patient(
    id: 2,
    name: 'Maria da Silva',
    cpf: '123.456.789-00',
    phone: '11 99999-9999',
    email: 'maria@mail.com',
  );

  await ClinicaDatabase.instance.insertPatient(patient);
  await ClinicaDatabase.instance.insertPatient(patient2);
  print(await ClinicaDatabase.instance.patients());

  var schedule = const MedicalSchedule(
    id: 1,
    doctorId: 1,
    patientId: 1,
    date: '10/10/2020',
    startTime: '09:00',
    endTime: '10:00',
    status: 'Pendente',
  );

  var schedule2 = const MedicalSchedule(
    id: 2,
    doctorId: 2,
    patientId: 2,
    date: '10/10/2020',
    startTime: '09:00',
    endTime: '10:00',
    status: 'Pendente',
  );

  await ClinicaDatabase.instance.insertMedicalSchedule(schedule);
  await ClinicaDatabase.instance.insertMedicalSchedule(schedule2);
  print(await ClinicaDatabase.instance.medicalSchedules());

}
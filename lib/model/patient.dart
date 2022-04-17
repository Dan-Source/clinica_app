final String patientTable = 'patient';

class PatientFields {
  static final List<String> values = [
    id,
    name,
    cpf,
    email,
    phone,
  ];

  static final String id = 'id';
  static final String name = 'name';
  static final String cpf = 'cpf';
  static final String email = 'email';
  static final String phone = 'phone';
}

class Patient {
  final int id;
  final String name;
  final String cpf;
  final String email;
  final String phone;

  const Patient({
    required this.id,
    required this.name,
    required this.cpf,
    required this.email,
    required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'email': email,
      'phone': phone,
    };
  }

  @override
  String toString() {
    return 'Patient{id: $id, name: $name, cpf: $cpf, email: $email, phone: $phone}';
  }
}
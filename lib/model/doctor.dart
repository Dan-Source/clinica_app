final String doctorTable = 'doctor';

class DoctorFields {
  static final List<String> values = [
    id,
    name,
    crm,
    email,
    phone,
    especialityId,
  ];

  static final String id = 'id';
  static final String name = 'name';
  static final String crm = 'crm';
  static final String email = 'email';
  static final String phone = 'phone';
  static final String especialityId = 'especialityId';
}

class Doctor {
  final int id;
  final String name;
  final String crm;
  final String email;
  final String phone;
  final int especialityId;

  const Doctor({
    required this.id,
    required this.name,
    required this.crm,
    required this.email,
    required this.phone,
    required this.especialityId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'crm': crm,
      'email': email,
      'phone': phone,
      'especialityId': especialityId,
    };
  }

  @override
  String toString() {
    return 'Doctor{id: $id, name: $name, crm: $crm, email: $email, phone: $phone, especialityId: $especialityId}';
  }
}
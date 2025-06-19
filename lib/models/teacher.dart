class Teacher {
  final int? id;
  final String name;
  final String subject;
  final String phone;
  final String status;

  Teacher({
    this.id,
    required this.name,
    required this.subject,
    required this.phone,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'subject': subject,
      'phone': phone,
      'status': status,
    };
  }

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      id: map['id'],
      name: map['name'],
      subject: map['subject'],
      phone: map['phone'],
      status: map['status'],
    );
  }
}

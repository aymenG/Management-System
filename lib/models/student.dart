class Student {
  final int? id;
  final String name;
  final String dob;
  final int classId;
  final String parentContact;
  final String status;

  Student({
    this.id,
    required this.name,
    required this.dob,
    required this.classId,
    required this.parentContact,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dob': dob,
      'class_id': classId,
      'parent_contact': parentContact,
      'status': status,
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      dob: map['dob'],
      classId: map['class_id'],
      parentContact: map['parent_contact'],
      status: map['status'],
    );
  }
}

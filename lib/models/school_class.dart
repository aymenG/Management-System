class SchoolClass {
  final int? id;
  final String name;
  final String level;
  final int teacherId;

  SchoolClass({
    this.id,
    required this.name,
    required this.level,
    required this.teacherId,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'level': level, 'teacher_id': teacherId};
  }

  factory SchoolClass.fromMap(Map<String, dynamic> map) {
    return SchoolClass(
      id: map['id'],
      name: map['name'],
      level: map['level'],
      teacherId: map['teacher_id'],
    );
  }
}

class User {
  final int? id;
  final String username;
  final String hashedPassword;

  User({
    this.id,
    required this.username,
    required this.hashedPassword,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'username': username, 'hashed_password': hashedPassword};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      hashedPassword: map['hashed_password'],
    );
  }
}

// This class represents a user in the system, with fields for ID, username, and hashed password.

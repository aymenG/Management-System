
import 'database_helper.dart';

class UserController {
  final dbHelper = DatabaseHelper();

  Future<void> registerUser(String username, String password) async {
    try {
      final hashedPassword = _hashPassword(password); // Assume a hashing function
      final id = await dbHelper.insertUser(username, hashedPassword);
      print('User inserted with ID: $id');
    } catch (e) {
      print('Insert error: $e');
    }
  }

  String _hashPassword(String password) {
    // This is just a placeholder. Use a real hash method in production!
    return password.hashCode.toString();
  }
}
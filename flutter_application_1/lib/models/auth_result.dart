import 'dummy_user.dart';

/// Status hasil autentikasi lokal
enum AuthStatus {
  success,
  emptyFields,
  emailNotFound,
  wrongPassword,
}

/// Objek hasil pemeriksaan autentikasi
class AuthResult {
  final AuthStatus status;
  final String message;
  final DummyUser? user;

  const AuthResult({
    required this.status,
    required this.message,
    this.user,
  });

  bool get isSuccess => status == AuthStatus.success;
}

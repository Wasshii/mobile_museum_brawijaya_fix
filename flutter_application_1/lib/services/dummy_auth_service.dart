import '../models/auth_result.dart';
import '../models/dummy_user.dart';

/// Layanan simulasi autentikasi lokal
/// Seluruh logika validasi terpusat di sini untuk menjamin konsistensi
class DummyAuthService {
  static final DummyAuthService _instance = DummyAuthService._internal();
  factory DummyAuthService() => _instance;
  DummyAuthService._internal();

  /// Daftar akun dummy lokal yang terdaftar dalam sistem
  final List<DummyUser> _registeredUsers = [
    const DummyUser(
      email: 'demo@museum.test',
      password: 'Museum123!',
      name: 'Alexandra',
    ),
    const DummyUser(
      email: 'budipramono21@gmail.com',
      password: 'Museum123!',
      name: 'Budi Pramono',
    ),
  ];

  DummyUser? _currentUser;
  DummyUser? get currentUser => _currentUser;

  /// Memeriksa apakah format email valid
  bool isValidEmailFormat(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email.trim());
  }

  /// Masking alamat email secara dinamis (contoh: bu**********21@gmail.com)
  String maskEmail(String email) {
    final trimmed = email.trim();
    final parts = trimmed.split('@');
    if (parts.length != 2) return trimmed;

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 2) {
      return '${username[0]}***@$domain';
    } else if (username.length <= 4) {
      return '${username[0]}****${username[username.length - 1]}@$domain';
    } else {
      final first = username.substring(0, 2);
      final last = username.substring(username.length - 2);
      final starCount = (username.length - 4).clamp(6, 12);
      final stars = '*' * starCount;
      return '$first$stars$last@$domain';
    }
  }

  /// Proses login dengan email dan kata sandi
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final trimmedEmail = email.trim();
    final trimmedPassword = password.trim();

    // Kondisi A — Email atau kata sandi kosong / tidak valid
    if (trimmedEmail.isEmpty || trimmedPassword.isEmpty) {
      return const AuthResult(
        status: AuthStatus.emptyFields,
        message: 'Email dan kata sandi wajib diisi',
      );
    }

    if (!isValidEmailFormat(trimmedEmail)) {
      return const AuthResult(
        status: AuthStatus.emptyFields,
        message: 'Format email tidak valid',
      );
    }

    // Cari user berdasarkan email
    final userIndex = _registeredUsers.indexWhere(
      (u) => u.email.toLowerCase() == trimmedEmail.toLowerCase(),
    );

    // Kondisi B — Email tidak terdaftar
    if (userIndex == -1) {
      return const AuthResult(
        status: AuthStatus.emailNotFound,
        message: 'Akun tidak terdaftar',
      );
    }

    final user = _registeredUsers[userIndex];

    // Kondisi C — Email terdaftar, tetapi password salah
    if (user.password != trimmedPassword) {
      return const AuthResult(
        status: AuthStatus.wrongPassword,
        message: 'Password salah',
      );
    }

    // Kondisi D — Email dan password benar
    _currentUser = user;
    return AuthResult(
      status: AuthStatus.success,
      message: 'Login berhasil',
      user: user,
    );
  }

  /// Memeriksa keberadaan email untuk alur reset kata sandi
  Future<bool> checkEmailExists(String email) async {
    final trimmedEmail = email.trim();
    return _registeredUsers.any(
      (u) => u.email.toLowerCase() == trimmedEmail.toLowerCase(),
    );
  }

  /// Simulasi login dengan akun Google
  Future<AuthResult> loginWithGoogle() async {
    const googleUser = DummyUser(
      email: 'alexandra@museum.test',
      password: '',
      name: 'Alexandra',
    );
    _currentUser = googleUser;
    return const AuthResult(
      status: AuthStatus.success,
      message: 'Login dengan Google berhasil (Mode Demo)',
      user: googleUser,
    );
  }

  /// Logout sesi saat ini
  void logout() {
    _currentUser = null;
  }
}

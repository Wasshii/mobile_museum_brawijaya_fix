/// Model data pengguna untuk keperluan simulasi autentikasi lokal
class DummyUser {
  final String email;
  final String password;
  final String name;

  const DummyUser({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  String toString() => 'DummyUser(email: $email, name: $name)';
}

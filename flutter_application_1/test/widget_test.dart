import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/models/auth_result.dart';
import 'package:flutter_application_1/models/ticket_order.dart';
import 'package:flutter_application_1/services/dummy_auth_service.dart';

void main() {
  group('DummyAuthService Unit Tests', () {
    late DummyAuthService authService;

    setUp(() {
      authService = DummyAuthService();
      authService.logout();
    });

    test('Validasi format email', () {
      expect(authService.isValidEmailFormat('demo@museum.test'), isTrue);
      expect(authService.isValidEmailFormat('budipramono21@gmail.com'), isTrue);
      expect(authService.isValidEmailFormat('invalid-email'), isFalse);
      expect(authService.isValidEmailFormat(''), isFalse);
    });

    test('Dinamis Masking Email', () {
      final masked1 = authService.maskEmail('budipramono21@gmail.com');
      expect(masked1.startsWith('bu'), isTrue);
      expect(masked1.endsWith('21@gmail.com'), isTrue);
      expect(masked1.contains('*'), isTrue);

      final maskedShort = authService.maskEmail('ab@gmail.com');
      expect(maskedShort.startsWith('a'), isTrue);
      expect(maskedShort.endsWith('@gmail.com'), isTrue);
    });

    test('Kondisi A: Field kosong ditolak', () async {
      final result = await authService.login(email: '', password: '');
      expect(result.status, AuthStatus.emptyFields);
      expect(result.isSuccess, isFalse);
    });

    test('Kondisi B: Email tidak terdaftar ditolak', () async {
      final result = await authService.login(
        email: 'tidakada@museum.test',
        password: 'Password123!',
      );
      expect(result.status, AuthStatus.emailNotFound);
      expect(result.message, 'Akun tidak terdaftar');
    });

    test('Kondisi C: Password salah ditolak', () async {
      final result = await authService.login(
        email: 'demo@museum.test',
        password: 'SalahPassword!',
      );
      expect(result.status, AuthStatus.wrongPassword);
      expect(result.message, 'Password salah');
    });

    test('Kondisi D: Kredensial demo berhasil login', () async {
      final result = await authService.login(
        email: 'demo@museum.test',
        password: 'Museum123!',
      );
      expect(result.status, AuthStatus.success);
      expect(result.isSuccess, isTrue);
      expect(result.user?.name, 'Alexandra');
    });

    test('Reset Password: Pengecekan keberadaan email', () async {
      expect(await authService.checkEmailExists('demo@museum.test'), isTrue);
      expect(await authService.checkEmailExists('budipramono21@gmail.com'),
          isTrue);
      expect(await authService.checkEmailExists('asing@test.com'), isFalse);
    });
  });

  group('TicketOrder Unit Tests & Perhitungan Harga', () {
    test('1 Tiket Mandiri = Rp10.000', () {
      final order = TicketOrder(
        id: TicketOrder.generateTransactionId(),
        ticketCount: 1,
        ticketType: TicketType.mandiri,
        paymentMethod: PaymentMethod.tunai,
        phoneNumber: '081234567890',
        createdAt: DateTime.now(),
      );
      expect(order.subtotal, 10000);
      expect(order.guideFee, 0);
      expect(order.total, 10000);
      expect(TicketOrder.formatRupiah(order.total), 'Rp. 10.000');
    });

    test('5 Tiket Mandiri = Rp50.000', () {
      final order = TicketOrder(
        id: TicketOrder.generateTransactionId(),
        ticketCount: 5,
        ticketType: TicketType.mandiri,
        paymentMethod: PaymentMethod.nonTunai,
        phoneNumber: '081234567890',
        createdAt: DateTime.now(),
      );
      expect(order.subtotal, 50000);
      expect(order.guideFee, 0);
      expect(order.total, 50000);
      expect(TicketOrder.formatRupiah(order.total), 'Rp. 50.000');
    });

    test('5 Tiket Dengan Guide = Rp100.000', () {
      final order = TicketOrder(
        id: TicketOrder.generateTransactionId(),
        ticketCount: 5,
        ticketType: TicketType.guide,
        paymentMethod: PaymentMethod.nonTunai,
        phoneNumber: '081234567890',
        createdAt: DateTime.now(),
      );
      expect(order.subtotal, 50000);
      expect(order.guideFee, 50000);
      expect(order.total, 100000);
      expect(TicketOrder.formatRupiah(order.total), 'Rp. 100.000');
    });

    test('Generator ID Transaksi menghasilkan ID unik 19 digit', () {
      final id1 = TicketOrder.generateTransactionId();
      final id2 = TicketOrder.generateTransactionId();
      expect(id1, isNotEmpty);
      expect(id2, isNotEmpty);
      expect(id1, isNot(equals(id2)));
      expect(id1.length, 19);
    });
  });
}

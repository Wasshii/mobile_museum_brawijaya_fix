import 'dart:math';

/// Pilihan jenis tiket Museum Brawijaya
enum TicketType {
  mandiri,
  guide,
}

/// Pilihan metode pembayaran
enum PaymentMethod {
  tunai,
  nonTunai,
}

/// Model transaksi pemesanan tiket Museum Brawijaya
class TicketOrder {
  final String id;
  final int ticketCount;
  final TicketType ticketType;
  final PaymentMethod paymentMethod;
  final String phoneNumber;
  final DateTime createdAt;

  // Tarif dasar
  static const int pricePerTicket = 10000;
  static const int guideFeePerOrder = 50000;

  const TicketOrder({
    required this.id,
    required this.ticketCount,
    required this.ticketType,
    required this.paymentMethod,
    required this.phoneNumber,
    required this.createdAt,
  });

  /// Hitung subtotal tiket: jumlah tiket x Rp10.000
  int get subtotal => ticketCount * pricePerTicket;

  /// Biaya pemandu: Rp50.000 jika Dengan Guide, Rp0 jika Mandiri
  int get guideFee => ticketType == TicketType.guide ? guideFeePerOrder : 0;

  /// Total pembayaran: subtotal + biaya pemandu
  int get total => subtotal + guideFee;

  /// Label teks jenis tiket untuk UI
  String get ticketTypeName =>
      ticketType == TicketType.mandiri ? 'Tiket Mandiri' : 'Tiket Dengan Guide';

  String get ticketTypeShortName =>
      ticketType == TicketType.mandiri ? 'Mandiri' : 'Guide';

  /// Label teks metode pembayaran untuk UI
  String get paymentMethodName =>
      paymentMethod == PaymentMethod.nonTunai ? 'Non Tunai' : 'Tunai';

  /// Format angka ke Rupiah rapi (contoh: Rp. 50.000 atau Rp. 100.000)
  static String formatRupiah(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    int count = 0;
    for (int i = str.length - 1; i >= 0; i--) {
      buffer.write(str[i]);
      count++;
      if (count % 3 == 0 && i > 0) {
        buffer.write('.');
      }
    }
    return 'Rp. ${buffer.toString().split('').reversed.join('')}';
  }

  /// Generator ID Transaksi acak unik (contoh: 1199281991009192837 atau MB-xxxx)
  static String generateTransactionId() {
    final random = Random();
    final buffer = StringBuffer();
    // Menghasilkan 19 digit angka acak sesuai gaya referensi Foto 5
    for (int i = 0; i < 19; i++) {
      buffer.write(random.nextInt(10).toString());
    }
    return buffer.toString();
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/ticket_order.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';
import 'booking_success_screen.dart';

/// Halaman Pembayaran Tiket (Foto 3) & Animasi Proses Pembayaran (Foto 4)
class PaymentScreen extends StatefulWidget {
  final TicketOrder order;

  const PaymentScreen({
    super.key,
    required this.order,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen>
    with SingleTickerProviderStateMixin {
  // Timer countdown pembayaran (contoh: 04.35)
  int _countdownMinutes = 4;
  int _countdownSeconds = 35;
  Timer? _countdownTimer;

  // Timer alur perpindahan demo: 8 detik di halaman pembayaran
  Timer? _pageHoldTimer;
  Timer? _processingHoldTimer;

  // Animasi proses pembayaran (Foto 4)
  late AnimationController _animController;
  late Animation<Offset> _slideAnimation;
  bool _isProcessingVisible = false;

  @override
  void initState() {
    super.initState();

    // Inisialisasi controller animasi slide-up untuk Foto 4
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0), // Mulai dari bawah layar
      end: Offset.zero, // Berhenti di posisi penuh tengah
    ).animate(
      CurvedAnimation(
        parent: _animController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Jalankan countdown waktu pembayaran (04.35)
    _startCountdownTimer();

    // 1. Tampilkan halaman pembayaran selama ~8 detik sebelum animasi Foto 4 dimulai
    _pageHoldTimer =
        Timer(const Duration(seconds: 8), _startProcessingAnimation);
  }

  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_countdownSeconds > 0) {
          _countdownSeconds--;
        } else if (_countdownMinutes > 0) {
          _countdownMinutes--;
          _countdownSeconds = 59;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void _startProcessingAnimation() {
    if (!mounted) return;

    setState(() {
      _isProcessingVisible = true;
    });

    // 2. Animasi bergerak dari bawah ke atas menuju tengah layar
    _animController.forward();

    // 3. Setelah animasi mencapai posisi akhir, bertahan selama ~5 detik
    _processingHoldTimer =
        Timer(const Duration(seconds: 5), _navigateToSuccess);
  }

  void _navigateToSuccess() {
    if (!mounted) return;

    // 4. Transisi menuju Halaman Pembayaran Berhasil (Foto 5)
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            BookingSuccessScreen(order: widget.order),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _pageHoldTimer?.cancel();
    _processingHoldTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: AmbientBackground(
        child: Stack(
          children: [
            // Konten Utama Halaman Pembayaran (Foto 3)
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 14.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tombol "<- Kembali"
                    InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E2220),
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(color: const Color(0xFF2A302C)),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Kembali',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // Kartu Utama Pembayaran Tiket (Foto 3)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF181B19),
                        borderRadius: BorderRadius.circular(32.0),
                        border: Border.all(
                          color: const Color(0xFF282E2A),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 26.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul Kartu & Tanggal
                          const Text(
                            'Pembayaran Tiket',
                            style: TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          const Text(
                            '9 Sep 2026, Rabu',
                            style: TextStyle(
                              color: Color(0xFF8E9590),
                              fontSize: 12.5,
                            ),
                          ),
                          const SizedBox(height: 22.0),

                          // Rincian Pesanan
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Kolom Kiri
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Jenis Tiket',
                                      style: TextStyle(
                                        color: Color(0xFF8E9590),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(
                                      widget.order.ticketTypeShortName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 14.0),
                                    const Text(
                                      'Jenis Pembayaran',
                                      style: TextStyle(
                                        color: Color(0xFF8E9590),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(
                                      widget.order.paymentMethodName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 14.0),
                                    const Text(
                                      'Total :',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Kolom Kanan
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      'Jumlah Tiket',
                                      style: TextStyle(
                                        color: Color(0xFF8E9590),
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(
                                      '${widget.order.ticketCount}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 35.0),

                                    // Total Harga Nilai
                                    Text(
                                      TicketOrder.formatRupiah(
                                          widget.order.total),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26.0),

                          // Komponen Kode QR (Untuk Non-Tunai) atau Petunjuk Kasir (Untuk Tunai)
                          Center(
                            child: widget.order.paymentMethod ==
                                    PaymentMethod.nonTunai
                                ? _buildQRCodeContainer()
                                : _buildCashPaymentNotice(),
                          ),
                          const SizedBox(height: 18.0),

                          // Countdown Merah (contoh: 04.35)
                          Center(
                            child: Text(
                              '${_countdownMinutes.toString().padLeft(2, '0')}.${_countdownSeconds.toString().padLeft(2, '0')}',
                              style: const TextStyle(
                                color: Color(0xFFE53935),
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14.0),

                          // Teks Keterangan di Bawah
                          const Center(
                            child: Text(
                              'Mohon bayar sebelum batas waktu\nhabis agar tiket Anda tidak\nkedaluwarsa.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF8E9590),
                                fontSize: 12.0,
                                height: 1.4,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),

            // Foto 4: Animasi Layar Penuh Hijau Cerah "Pembayaran Tiket Berhasil"
            if (_isProcessingVisible)
              SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: const Color(0xFF22C55E), // Hijau cerah sesuai Foto 4
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Ikon Tiket Miring Putih dengan Garis Perforasi
                        const TiltedTicketIcon(size: 130.0),
                        const SizedBox(height: 32.0),

                        // Teks 3 Baris "Pembayaran Tiket Berhasil"
                        const Text(
                          'Pembayaran\nTiket\nBerhasil',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            height: 1.25,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Kontainer Kotak Putih Berisi Gambar QR Code
  Widget _buildQRCodeContainer() {
    return Container(
      width: 170.0,
      height: 170.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      padding: const EdgeInsets.all(14.0),
      child: CustomPaint(
        painter: _QRCodePainter(),
      ),
    );
  }

  /// Tampilan Petunjuk Pembayaran Tunai di Loket
  Widget _buildCashPaymentNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: const Color(0xFF222624),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFF2F3632)),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.payments_outlined,
            color: AppColors.primaryGreen,
            size: 42,
          ),
          SizedBox(height: 10.0),
          Text(
            'Pembayaran Tunai di Loket',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Tunjukkan bukti pemesanan ini kepada petugas loket Museum Brawijaya dan siapkan uang pas.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8E9590),
              fontSize: 12.0,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

/// Ikon Tiket Miring Putih (Foto 4) digambar dengan CustomPainter
class TiltedTicketIcon extends StatelessWidget {
  final double size;

  const TiltedTicketIcon({super.key, this.size = 130.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size * 0.65,
      child: CustomPaint(
        painter: _TiltedTicketPainter(),
      ),
    );
  }
}

class _TiltedTicketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    canvas.save();
    // Miringkan tiket sekitar -18 derajat
    canvas.translate(w / 2, h / 2);
    canvas.rotate(-0.32);
    canvas.translate(-w / 2, -h / 2);

    final ticketWidth = w * 0.9;
    final ticketHeight = h * 0.85;
    final left = (w - ticketWidth) / 2;
    final top = (h - ticketHeight) / 2;
    final right = left + ticketWidth;
    final bottom = top + ticketHeight;

    final notchRadius = 7.0;

    // Gambar bodi tiket putih dengan cekungan setengah lingkaran di samping
    final path = Path()
      ..moveTo(left + 8, top)
      ..lineTo(right - 8, top)
      ..quadraticBezierTo(right, top, right, top + 8)
      ..lineTo(right, top + (ticketHeight / 2) - notchRadius)
      ..arcToPoint(
        Offset(right, top + (ticketHeight / 2) + notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(right, bottom - 8)
      ..quadraticBezierTo(right, bottom, right - 8, bottom)
      ..lineTo(left + 8, bottom)
      ..quadraticBezierTo(left, bottom, left, bottom - 8)
      ..lineTo(left, top + (ticketHeight / 2) + notchRadius)
      ..arcToPoint(
        Offset(left, top + (ticketHeight / 2) - notchRadius),
        radius: Radius.circular(notchRadius),
        clockwise: false,
      )
      ..lineTo(left, top + 8)
      ..quadraticBezierTo(left, top, left + 8, top)
      ..close();

    final fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // Garis putus-putus perforasi di sepertiga kanan
    final dashX = left + (ticketWidth * 0.68);
    final dashPaint = Paint()
      ..color = const Color(0xFF22C55E)
      ..strokeWidth = 2.4
      ..style = PaintingStyle.stroke;

    double curY = top + 4;
    while (curY < bottom - 4) {
      canvas.drawLine(Offset(dashX, curY), Offset(dashX, curY + 4), dashPaint);
      curY += 8;
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// CustomPainter untuk pola QR Code tajam pada kotak putih
class _QRCodePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint()..color = Colors.black;

    // Tiga kotak finder pattern di sudut QR Code
    void drawFinderPattern(double x, double y, double s) {
      // Kotak luar
      canvas.drawRect(Rect.fromLTWH(x, y, s, s), paint);
      // Kotak dalam putih
      final innerWhite = Paint()..color = Colors.white;
      canvas.drawRect(
          Rect.fromLTWH(x + (s * 0.16), y + (s * 0.16), s * 0.68, s * 0.68),
          innerWhite);
      // Kotak tengah hitam
      canvas.drawRect(
          Rect.fromLTWH(x + (s * 0.32), y + (s * 0.32), s * 0.36, s * 0.36),
          paint);
    }

    final finderSize = w * 0.28;
    drawFinderPattern(0, 0, finderSize);
    drawFinderPattern(w - finderSize, 0, finderSize);
    drawFinderPattern(0, h - finderSize, finderSize);

    // Pola bintik matriks data acak
    final dotSize = w * 0.055;
    final int rows = 16;
    final int cols = 16;

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        // Lewati area finder pattern
        if ((r < 5 && c < 5) || (r < 5 && c > 10) || (r > 10 && c < 5))
          continue;

        // Pola deterministik
        if ((r * c + r + c) % 3 == 0 || (r + c) % 5 == 0) {
          canvas.drawRect(
            Rect.fromLTWH(
                c * dotSize, r * dotSize, dotSize * 0.9, dotSize * 0.9),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

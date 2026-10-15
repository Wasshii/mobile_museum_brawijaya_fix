import 'package:flutter/material.dart';
import '../models/ticket_order.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';
import '../widgets/booking_confirmation_sheet.dart';
import 'payment_screen.dart';

/// Halaman Pemesanan Tiket Museum Brawijaya (Foto 1)
class TicketBookingScreen extends StatefulWidget {
  const TicketBookingScreen({super.key});

  @override
  State<TicketBookingScreen> createState() => _TicketBookingScreenState();
}

class _TicketBookingScreenState extends State<TicketBookingScreen> {
  int _ticketCount = 5;
  TicketType _selectedTicketType = TicketType.mandiri;
  PaymentMethod _selectedPaymentMethod = PaymentMethod.nonTunai;

  final TextEditingController _phoneController = TextEditingController();
  String? _phoneError;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  int get _subtotal => _ticketCount * TicketOrder.pricePerTicket;
  int get _guideFee => _selectedTicketType == TicketType.guide
      ? TicketOrder.guideFeePerOrder
      : 0;
  int get _totalPrice => _subtotal + _guideFee;

  void _incrementTicket() {
    setState(() {
      _ticketCount++;
    });
  }

  void _decrementTicket() {
    if (_ticketCount > 1) {
      setState(() {
        _ticketCount--;
      });
    }
  }

  void _handleConfirmOrder() {
    setState(() {
      _phoneError = null;
    });

    final phone = _phoneController.text.trim();

    // Validasi nomor telepon wajib diisi
    if (phone.isEmpty) {
      setState(() {
        _phoneError = 'Nomor telepon wajib diisi';
      });
      return;
    }

    if (phone.length < 8) {
      setState(() {
        _phoneError = 'Nomor telepon minimal 8 digit';
      });
      return;
    }

    // Buat snapshot pesanan dengan ID transaksi unik
    final order = TicketOrder(
      id: TicketOrder.generateTransactionId(),
      ticketCount: _ticketCount,
      ticketType: _selectedTicketType,
      paymentMethod: _selectedPaymentMethod,
      phoneNumber: phone,
      createdAt: DateTime.now(),
    );

    // Tampilkan Bottom Sheet Konfirmasi (Foto 2)
    BookingConfirmationSheet.show(
      context,
      order: order,
      onConfirm: () {
        // Navigasi ke Halaman Pembayaran (Foto 3)
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                PaymentScreen(order: order),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: AmbientBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 14.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Tombol "<- Kembali" (Pill Gelap)
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
                    const SizedBox(height: 22.0),

                    // 2. Judul & Subjudul
                    const Text(
                      'Pemesanan Tiket',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Pastikan Informasi Pemesanan\nBenar Sebelum Konfirmasi',
                      style: TextStyle(
                        color: Color(0xFF8E9590),
                        fontSize: 13.5,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // 3. Dua Kartu Bersebelahan (Jumlah Tiket & Pembayaran)
                    Row(
                      children: [
                        // Kartu Kiri: Jumlah Tiket
                        Expanded(
                          child: _buildTicketCountCard(),
                        ),
                        const SizedBox(width: 14.0),

                        // Kartu Kanan: Pembayaran (Hijau)
                        Expanded(
                          child: _buildPaymentMethodCard(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 26.0),

                    // 4. Section: Jenis Tiket (?)
                    Row(
                      children: [
                        const Text(
                          'Jenis Tiket',
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          width: 18.0,
                          height: 18.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.5),
                              width: 1.0,
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),

                    // Dua Pilihan Pil Jenis Tiket
                    Row(
                      children: [
                        // Mandiri
                        _buildTicketTypePill(
                          title: 'Mandiri',
                          type: TicketType.mandiri,
                        ),
                        const SizedBox(width: 12.0),

                        // Guide ( + 50.000 )
                        _buildTicketTypePill(
                          title: 'Guide ( + 50.000 )',
                          type: TicketType.guide,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),

                    // 5. Section: Total Pembayaran
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      width: double.infinity,
                      height: 50.0,
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF181B19),
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(color: const Color(0xFF282E2A)),
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        TicketOrder.formatRupiah(_totalPrice),
                        style: const TextStyle(
                          color: Color(0xFFA2A9A4),
                          fontSize: 14.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    // 6. Section: Nomer Telepon Aktif
                    const Text(
                      'Nomer Telepon Aktif',
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF181B19),
                        borderRadius: BorderRadius.circular(26.0),
                        border: Border.all(
                          color: _phoneError != null
                              ? AppColors.errorRed
                              : const Color(0xFF282E2A),
                        ),
                      ),
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.5,
                        ),
                        cursorColor: AppColors.primaryGreen,
                        decoration: const InputDecoration(
                          hintText: 'Masukkan Nomer Telepon',
                          hintStyle: TextStyle(
                            color: Color(0xFF6B736D),
                            fontSize: 14.0,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 14.0,
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (_) {
                          if (_phoneError != null) {
                            setState(() => _phoneError = null);
                          }
                        },
                      ),
                    ),
                    if (_phoneError != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 6.0),
                        child: Text(
                          _phoneError!,
                          style: const TextStyle(
                            color: AppColors.errorRed,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 36.0),

                    // 7. Tombol Putih "Konfirmasi" (Foto 1)
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: _handleConfirmOrder,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26.0),
                          ),
                        ),
                        child: const Text(
                          'Konfirmasi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Kartu Kiri: Jumlah Tiket dengan horizontal number list dan tombol bulat (+ / -)
  Widget _buildTicketCountCard() {
    return Container(
      height: 165.0,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF181B19),
        borderRadius: BorderRadius.circular(28.0),
        border: Border.all(color: const Color(0xFF282E2A)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Jumlah Tiket',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Deretan Angka (contoh: 3  4  [5]  6  7)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_ticketCount > 2) ...[
                Text(
                  '${_ticketCount - 2} ',
                  style: const TextStyle(
                    color: Color(0xFF555C57),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              if (_ticketCount > 1) ...[
                Text(
                  '${_ticketCount - 1} ',
                  style: const TextStyle(
                    color: Color(0xFF7A827C),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
              // Angka Utama Terpilih
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  '$_ticketCount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                ' ${_ticketCount + 1}',
                style: const TextStyle(
                  color: Color(0xFF7A827C),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' ${_ticketCount + 2}',
                style: const TextStyle(
                  color: Color(0xFF555C57),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          // Dua Tombol Bulat Putih (- dan +)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Tombol Minus
              InkWell(
                onTap: _decrementTicket,
                borderRadius: BorderRadius.circular(18.0),
                child: Container(
                  width: 34.0,
                  height: 34.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.remove,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 22.0),

              // Tombol Plus
              InkWell(
                onTap: _incrementTicket,
                borderRadius: BorderRadius.circular(18.0),
                child: Container(
                  width: 34.0,
                  height: 34.0,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Kartu Kanan: Pembayaran (Latar Hijau) dengan Tunai & Non-Tunai
  Widget _buildPaymentMethodCard() {
    return Container(
      height: 165.0,
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(28.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Pembayaran',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Pilihan 1: Tunai
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentMethod = PaymentMethod.tunai;
              });
            },
            child: Container(
              width: double.infinity,
              height: 38.0,
              decoration: BoxDecoration(
                color: _selectedPaymentMethod == PaymentMethod.tunai
                    ? Colors.black
                    : const Color(0xFF4C875C),
                borderRadius: BorderRadius.circular(20.0),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_selectedPaymentMethod == PaymentMethod.tunai) ...[
                    Container(
                      width: 7.0,
                      height: 7.0,
                      margin: const EdgeInsets.only(right: 6.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF34D399),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                  Text(
                    'Tunai',
                    style: TextStyle(
                      color: _selectedPaymentMethod == PaymentMethod.tunai
                          ? Colors.white
                          : Colors.white.withOpacity(0.75),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pilihan 2: Non – Tunai
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedPaymentMethod = PaymentMethod.nonTunai;
              });
            },
            child: Container(
              width: double.infinity,
              height: 38.0,
              decoration: BoxDecoration(
                color: _selectedPaymentMethod == PaymentMethod.nonTunai
                    ? Colors.black
                    : const Color(0xFF4C875C),
                borderRadius: BorderRadius.circular(20.0),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_selectedPaymentMethod == PaymentMethod.nonTunai) ...[
                    Container(
                      width: 7.0,
                      height: 7.0,
                      margin: const EdgeInsets.only(right: 6.0),
                      decoration: const BoxDecoration(
                        color: Color(0xFF34D399),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                  Text(
                    'Non – Tunai',
                    style: TextStyle(
                      color: _selectedPaymentMethod == PaymentMethod.nonTunai
                          ? Colors.white
                          : Colors.white.withOpacity(0.75),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Pilihan Pil Jenis Tiket (Mandiri atau Guide)
  Widget _buildTicketTypePill({
    required String title,
    required TicketType type,
  }) {
    final isSelected = _selectedTicketType == type;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTicketType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E2220) : const Color(0xFF141715),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF38403B) : const Color(0xFF222624),
            width: 1.2,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF8E9590),
            fontSize: 12.5,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/ticket_order.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';

/// Halaman Detail Tiket / Pembayaran Berhasil (Foto 5)
/// Menampilkan bukti dan ringkasan transaksi berdasarkan data pesanan yang sama
class BookingSuccessScreen extends StatelessWidget {
  final TicketOrder order;

  const BookingSuccessScreen({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: AmbientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
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
                  onTap: () {
                    // Navigasi kembali ke Dashboard
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
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

                // 2. Kartu Utama "Detail Tiket" (Foto 5)
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
                    horizontal: 26.0,
                    vertical: 28.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Kartu: Detail Tiket (?)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Detail Tiket',
                            style: TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Container(
                            width: 20.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withOpacity(0.6),
                                width: 1.2,
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 26.0),

                      // 1. Jenis Tiket
                      _buildDetailItem(
                        label: 'Jenis Tiket',
                        value: order.ticketTypeShortName,
                      ),
                      const SizedBox(height: 20.0),

                      // 2. Jumlah Tiket
                      _buildDetailItem(
                        label: 'Jumlah Tiket',
                        value: order.ticketCount.toString(),
                      ),
                      const SizedBox(height: 20.0),

                      // 3. Jenis Pembayaran
                      _buildDetailItem(
                        label: 'Jenis Pembayaran',
                        value: order.paymentMethodName,
                      ),
                      const SizedBox(height: 20.0),

                      // 4. Status
                      _buildDetailItem(
                        label: 'Status',
                        value: 'Sukses',
                      ),
                      const SizedBox(height: 20.0),

                      // 5. Id Transaksi
                      _buildDetailItem(
                        label: 'Id Transaksi',
                        value: order.id,
                      ),
                      const SizedBox(height: 12.0),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF8E9590),
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/ticket_order.dart';
import '../theme/app_colors.dart';

/// Bottom Sheet Konfirmasi Pesanan Tiket (Foto 2)
/// Muncul dari bawah dengan backdrop blur dan menampilkan rincian pesanan
class BookingConfirmationSheet extends StatelessWidget {
  final TicketOrder order;
  final VoidCallback onConfirm;

  const BookingConfirmationSheet({
    super.key,
    required this.order,
    required this.onConfirm,
  });

  /// Helper untuk menampilkan sheet dengan backdrop blur
  static Future<void> show(
    BuildContext context, {
    required TicketOrder order,
    required VoidCallback onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.65),
      enableDrag: true,
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: Container(color: Colors.transparent),
              ),
            ),
            BookingConfirmationSheet(
              order: order,
              onConfirm: onConfirm,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0C0E0D),
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(34.0),
          ),
          border: Border.all(
            color: AppColors.cardBorder,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              blurRadius: 36,
              offset: const Offset(0, -6),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag Handle Putih (Foto 2)
            Center(
              child: Container(
                width: 44.0,
                height: 4.5,
                margin: const EdgeInsets.only(top: 4.0, bottom: 26.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),

            // 1. Jenis Tiket
            _buildDetailRow(
              label: 'Jenis Tiket',
              value: order.ticketTypeName,
            ),
            const SizedBox(height: 18.0),

            // 2. Total Pemesanan Tiket
            _buildDetailRow(
              label: 'Total Pemesanan Tiket',
              value: order.ticketCount.toString(),
            ),
            const SizedBox(height: 18.0),

            // 3. Jenis Pembayaran
            _buildDetailRow(
              label: 'Jenis Pembayaran',
              value: order.paymentMethodName,
            ),
            const SizedBox(height: 18.0),

            // 4. Total Pembayaran
            _buildDetailRow(
              label: 'Total Pembayaran',
              value: TicketOrder.formatRupiah(order.total),
            ),
            const SizedBox(height: 32.0),

            // Tombol Putih "Konfirmasi" (Foto 2)
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup sheet
                  onConfirm(); // Lanjut ke halaman pembayaran
                },
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
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({required String label, required String value}) {
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

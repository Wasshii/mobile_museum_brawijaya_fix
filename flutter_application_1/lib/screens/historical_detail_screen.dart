import 'package:flutter/material.dart';
import '../models/historical_item.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';

/// Halaman Detail Benda Sejarah (1:1 sesuai Foto 2 & Foto 3)
class HistoricalDetailScreen extends StatefulWidget {
  final HistoricalItem item;

  const HistoricalDetailScreen({
    super.key,
    required this.item,
  });

  @override
  State<HistoricalDetailScreen> createState() => _HistoricalDetailScreenState();
}

class _HistoricalDetailScreenState extends State<HistoricalDetailScreen> {
  // 0 = Sejarah (Foto 2), 1 = Identitas (Foto 3)
  int _selectedTabIndex = 0;
  int _currentCarouselIndex = 0;
  final ScrollController _contentScrollController = ScrollController();

  @override
  void dispose() {
    _contentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: AmbientBackground(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Tombol "<- Kembali"
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

                // 2. Judul Besar Nama Benda Sejarah
                Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 18.0),

                // 3. Kartu Panel Gelap Utama (Foto 2 & Foto 3)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161917),
                      borderRadius: BorderRadius.circular(32.0),
                      border: Border.all(
                        color: const Color(0xFF282E2A),
                        width: 1.2,
                      ),
                    ),
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // A. Foto Artefak / Tampilan Carousel
                        Container(
                          width: double.infinity,
                          height: 180.0,
                          decoration: BoxDecoration(
                            color: const Color(0xFF212623),
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              color: const Color(0xFF2C332E),
                              width: 1.0,
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: _buildItemArtwork(item.id),
                        ),
                        const SizedBox(height: 12.0),

                        // B. Indikator Dots Carousel (3 Titik)
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(3, (index) {
                              final isActive = _currentCarouselIndex == index;
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 3.5),
                                width: isActive ? 14.0 : 6.0,
                                height: 6.0,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.white
                                      : const Color(0xFF4A524D),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(height: 18.0),

                        // C. Toggle Switch Tab: [Sejarah]  [Identitas]
                        Row(
                          children: [
                            // Tab 1: Sejarah (Foto 2)
                            _buildPillTab(
                              title: 'Sejarah',
                              index: 0,
                              isSelected: _selectedTabIndex == 0,
                            ),
                            const SizedBox(width: 10.0),

                            // Tab 2: Identitas (Foto 3)
                            _buildPillTab(
                              title: 'Identitas',
                              index: 1,
                              isSelected: _selectedTabIndex == 1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 18.0),

                        // D. Konten Tab (Scrollable dengan scrollbar kustom di kanan)
                        Expanded(
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              scrollbarTheme: ScrollbarThemeData(
                                thumbColor: WidgetStateProperty.all(
                                  Colors.white.withOpacity(0.85),
                                ),
                                thickness: WidgetStateProperty.all(4.0),
                                radius: const Radius.circular(2.0),
                              ),
                            ),
                            child: Scrollbar(
                              controller: _contentScrollController,
                              thumbVisibility: true,
                              child: SingleChildScrollView(
                                controller: _contentScrollController,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(right: 14.0),
                                child: _selectedTabIndex == 0
                                    ? _buildHistoryContent(item)
                                    : _buildIdentityContent(item),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Tab Kapsul Sejarah / Identitas
  Widget _buildPillTab({
    required String title,
    required int index,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      borderRadius: BorderRadius.circular(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF6EA87E) // Hijau cerah sesuai Foto 2 & Foto 3
              : const Color(0xFF141715),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF6EA87E) : const Color(0xFF282E2A),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF8E9590),
            fontSize: 13.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// Konten Tab Sejarah (Foto 2)
  Widget _buildHistoryContent(HistoricalItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.historyText,
          style: const TextStyle(
            color: Color(0xFFE2E7E4),
            fontSize: 14.0,
            height: 1.6,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 14.0),
        // Tambahan info konteks perjuangan
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1F1C),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: const Color(0xFF29322C)),
          ),
          child: Row(
            children: [
              const Icon(Icons.verified_rounded,
                  color: Color(0xFF6EA87E), size: 20),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Koleksi Otentik Museum Brawijaya Malang • Periode ${item.yearPeriod}',
                  style: const TextStyle(
                    color: Color(0xFFA2AAA4),
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Konten Tab Identitas (Foto 3)
  Widget _buildIdentityContent(HistoricalItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: item.identities.map((identity) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '• ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  height: 1.45,
                ),
              ),
              Expanded(
                child: Text(
                  identity,
                  style: const TextStyle(
                    color: Color(0xFFE2E7E4),
                    fontSize: 13.5,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Representasi visual display pameran artefak
  Widget _buildItemArtwork(String itemId) {
    return CustomPaint(
      painter: _ArtifactVisualPainter(itemId: itemId),
    );
  }
}

/// CustomPainter untuk menggambar ilustrasi artefak display museum
class _ArtifactVisualPainter extends CustomPainter {
  final String itemId;

  _ArtifactVisualPainter({required this.itemId});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Latar belakang foto etalase museum
    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: const [
          Color(0xFF28342B),
          Color(0xFF1E2822),
          Color(0xFF141815),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    switch (itemId) {
      case 'perahu-segigir':
        _drawPerahuSegigir(canvas, size);
        break;
      case 'mobil-de-soto':
        _drawMobilDeSoto(canvas, size);
        break;
      case 'meriam-obus':
        _drawMeriamObus(canvas, size);
        break;
      case 'gerbong-maut':
        _drawGerbongMaut(canvas, size);
        break;
      case 'tank-amx13':
        _drawTank(canvas, size);
        break;
      case 'senapan-browning':
        _drawBrowning(canvas, size);
        break;
      case 'keris-pusaka':
        _drawKeris(canvas, size);
        break;
      case 'mortir-81mm':
        _drawMortir(canvas, size);
        break;
      case 'radio-pemancar':
        _drawRadio(canvas, size);
        break;
      case 'pedang-katana':
        _drawKatana(canvas, size);
        break;
      default:
        _drawGeneric(canvas, size);
        break;
    }
  }

  void _drawPerahuSegigir(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Pilar atap pameran luar
    final pillarPaint = Paint()..color = const Color(0xFF3C483F);
    canvas.drawRect(Rect.fromLTWH(w * 0.15, 0, 6, h * 0.4), pillarPaint);
    canvas.drawRect(Rect.fromLTWH(w * 0.85, 0, 6, h * 0.4), pillarPaint);

    // Tiang layar
    final mastPaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 2.5;
    canvas.drawLine(
        Offset(w * 0.3, h * 0.12), Offset(w * 0.3, h * 0.7), mastPaint);

    // Lambung perahu putih khas Madura
    final boatPath = Path()
      ..moveTo(w * 0.08, h * 0.42)
      ..lineTo(w * 0.22, h * 0.72)
      ..lineTo(w * 0.88, h * 0.65)
      ..lineTo(w * 0.94, h * 0.42)
      ..lineTo(w * 0.5, h * 0.5)
      ..close();

    final hullPaint = Paint()..color = const Color(0xFFE4E9E6);
    canvas.drawPath(boatPath, hullPaint);

    // Striping hitam perahu Madura
    final stripePaint = Paint()
      ..color = const Color(0xFF1C221F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5;
    canvas.drawLine(
        Offset(w * 0.12, h * 0.52), Offset(w * 0.88, h * 0.58), stripePaint);

    // Dudukan penyangga museum di atas air kolam buatan
    final waterPaint = Paint()
      ..color = const Color(0xFF1E3830).withOpacity(0.5);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.75, w, h * 0.25), waterPaint);

    final standPaint = Paint()..color = const Color(0xFF2C322E);
    canvas.drawRect(
        Rect.fromLTWH(w * 0.25, h * 0.72, w * 0.55, h * 0.14), standPaint);
  }

  void _drawMobilDeSoto(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final floorPaint = Paint()..color = const Color(0xFFD6DDD8);
    canvas.drawRect(Rect.fromLTWH(0, h * 0.65, w, h * 0.35), floorPaint);

    final carWidth = w * 0.65;
    final carLeft = (w - carWidth) / 2;

    // Kabin atas
    final cabinPath = Path()
      ..moveTo(carLeft + 10, h * 0.45)
      ..lineTo(carLeft + 20, h * 0.25)
      ..lineTo(carLeft + carWidth - 20, h * 0.25)
      ..lineTo(carLeft + carWidth - 10, h * 0.45)
      ..close();
    canvas.drawPath(cabinPath, Paint()..color = const Color(0xFF4A5550));

    // Bodi mobil
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(carLeft, h * 0.42, carWidth, h * 0.38),
      const Radius.circular(10.0),
    );
    canvas.drawRRect(bodyRect, Paint()..color = const Color(0xFF141716));

    // Grille krom
    final grillePaint = Paint()..color = const Color(0xFFC9D1CC);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(carLeft + 14, h * 0.52, carWidth - 28, h * 0.2),
        const Radius.circular(4.0),
      ),
      grillePaint,
    );

    // Lampu bulat
    canvas.drawCircle(Offset(carLeft + 6, h * 0.54), 6.0,
        Paint()..color = const Color(0xFFFFF7D6));
    canvas.drawCircle(Offset(carLeft + carWidth - 6, h * 0.54), 6.0,
        Paint()..color = const Color(0xFFFFF7D6));
  }

  void _drawMeriamObus(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Laras
    final barrelPath = Path()
      ..moveTo(w * 0.2, h * 0.28)
      ..lineTo(w * 0.65, h * 0.58)
      ..lineTo(w * 0.62, h * 0.68)
      ..lineTo(w * 0.18, h * 0.38)
      ..close();
    canvas.drawPath(barrelPath, Paint()..color = const Color(0xFF3B483C));

    // Moncong
    canvas.drawCircle(Offset(w * 0.19, h * 0.33), 8.0,
        Paint()..color = const Color(0xFF263027));

    // Perisai baja
    final shieldPath = Path()
      ..moveTo(w * 0.42, h * 0.3)
      ..lineTo(w * 0.52, h * 0.35)
      ..lineTo(w * 0.5, h * 0.72)
      ..lineTo(w * 0.4, h * 0.68)
      ..close();
    canvas.drawPath(shieldPath, Paint()..color = const Color(0xFF49584B));

    // Roda
    canvas.drawCircle(Offset(w * 0.58, h * 0.68), 22.0,
        Paint()..color = const Color(0xFF1A1F1B));
    canvas.drawCircle(Offset(w * 0.58, h * 0.68), 8.0,
        Paint()..color = const Color(0xFF748477));
  }

  void _drawGerbongMaut(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Rel kereta
    canvas.drawRect(Rect.fromLTWH(0, h * 0.8, w, 4),
        Paint()..color = const Color(0xFF707672));

    // Bodi gerbong kayu hitam legendaris
    final carRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.25, w * 0.8, h * 0.52),
      const Radius.circular(6.0),
    );
    canvas.drawRRect(carRect, Paint()..color = const Color(0xFF241D18));

    // Pintu tertutup rapat
    canvas.drawRect(Rect.fromLTWH(w * 0.42, h * 0.28, w * 0.2, h * 0.46),
        Paint()..color = const Color(0xFF181310));

    // Tulisan putih GR 10152
    final textPainter = TextPainter(
      text: const TextSpan(
        text: 'GR 10152',
        style: TextStyle(
            color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    textPainter.paint(canvas, Offset(w * 0.14, h * 0.32));

    // Roda besi gerbong
    canvas.drawCircle(Offset(w * 0.25, h * 0.8), 12.0,
        Paint()..color = const Color(0xFF1A1A1A));
    canvas.drawCircle(Offset(w * 0.75, h * 0.8), 12.0,
        Paint()..color = const Color(0xFF1A1A1A));
  }

  void _drawTank(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Rantai tank (treads)
    final treadRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.15, h * 0.62, w * 0.7, h * 0.22),
      const Radius.circular(14.0),
    );
    canvas.drawRRect(treadRect, Paint()..color = const Color(0xFF1D221E));

    // Bodi lambung tank hijau tua
    final hullPath = Path()
      ..moveTo(w * 0.2, h * 0.62)
      ..lineTo(w * 0.15, h * 0.48)
      ..lineTo(w * 0.82, h * 0.48)
      ..lineTo(w * 0.78, h * 0.62)
      ..close();
    canvas.drawPath(hullPath, Paint()..color = const Color(0xFF334035));

    // Kubah menara tank (Turret)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.42, h * 0.36, w * 0.3, h * 0.16),
          const Radius.circular(8.0)),
      Paint()..color = const Color(0xFF3C4C3E),
    );

    // Moncong meriam panjang
    canvas.drawLine(
      Offset(w * 0.45, h * 0.42),
      Offset(w * 0.08, h * 0.42),
      Paint()
        ..color = const Color(0xFF263027)
        ..strokeWidth = 5.0,
    );
  }

  void _drawBrowning(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Kaki tripod
    canvas.drawLine(
        Offset(w * 0.45, h * 0.55),
        Offset(w * 0.2, h * 0.82),
        Paint()
          ..color = const Color(0xFF2E3330)
          ..strokeWidth = 3.5);
    canvas.drawLine(
        Offset(w * 0.45, h * 0.55),
        Offset(w * 0.7, h * 0.82),
        Paint()
          ..color = const Color(0xFF2E3330)
          ..strokeWidth = 3.5);

    // Bodi receiver browning
    canvas.drawRect(Rect.fromLTWH(w * 0.35, h * 0.48, w * 0.3, h * 0.12),
        Paint()..color = const Color(0xFF1A1E1C));

    // Laras pendingin berlubang panjang
    canvas.drawLine(
        Offset(w * 0.35, h * 0.54),
        Offset(w * 0.08, h * 0.54),
        Paint()
          ..color = const Color(0xFF2A302C)
          ..strokeWidth = 6.0);

    // Gagang pelatuk belakang
    canvas.drawRect(Rect.fromLTWH(w * 0.64, h * 0.46, 6, 22),
        Paint()..color = const Color(0xFF3D4440));
  }

  void _drawKeris(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Bilah keris luk 9 berlekuk indah
    final path = Path()..moveTo(w * 0.5, h * 0.8);
    for (int i = 0; i < 9; i++) {
      final y = h * (0.8 - (i * 0.065));
      final offset = (i % 2 == 0) ? 8.0 : -8.0;
      path.quadraticBezierTo(w * 0.5 + offset, y + 8, w * 0.5, y);
    }
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFD4A76A)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.5,
    );

    // Hulu pegangan kayu berukir
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Rect.fromLTWH(w * 0.46, h * 0.78, w * 0.08, h * 0.12),
          const Radius.circular(6.0)),
      Paint()..color = const Color(0xFF4A3222),
    );
  }

  void _drawMortir(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Tabung laras miring
    final path = Path()
      ..moveTo(w * 0.35, h * 0.28)
      ..lineTo(w * 0.65, h * 0.72)
      ..lineTo(w * 0.58, h * 0.76)
      ..lineTo(w * 0.28, h * 0.32)
      ..close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF3D483E));

    // Bipod penyangga
    canvas.drawLine(
        Offset(w * 0.45, h * 0.5),
        Offset(w * 0.3, h * 0.75),
        Paint()
          ..color = const Color(0xFF262C27)
          ..strokeWidth = 3.0);
    canvas.drawLine(
        Offset(w * 0.45, h * 0.5),
        Offset(w * 0.55, h * 0.75),
        Paint()
          ..color = const Color(0xFF262C27)
          ..strokeWidth = 3.0);

    // Baseplate bawah tanah
    canvas.drawOval(Rect.fromLTWH(w * 0.52, h * 0.72, w * 0.2, h * 0.08),
        Paint()..color = const Color(0xFF1E221F));
  }

  void _drawRadio(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Kotak radio militer
    final radioRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.2, h * 0.35, w * 0.6, h * 0.45),
      const Radius.circular(10.0),
    );
    canvas.drawRRect(radioRect, Paint()..color = const Color(0xFF2F3C34));

    // Dial frekuensi bulat
    canvas.drawCircle(Offset(w * 0.35, h * 0.52), 16.0,
        Paint()..color = const Color(0xFF1C221F));
    canvas.drawCircle(Offset(w * 0.35, h * 0.52), 6.0,
        Paint()..color = const Color(0xFFE2EBE5));

    // Speaker grill
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(
        Offset(w * 0.55, h * (0.44 + (i * 0.05))),
        Offset(w * 0.72, h * (0.44 + (i * 0.05))),
        Paint()
          ..color = const Color(0xFF1A221D)
          ..strokeWidth = 2.5,
      );
    }

    // Antena besi panjang
    canvas.drawLine(
        Offset(w * 0.25, h * 0.35),
        Offset(w * 0.2, h * 0.12),
        Paint()
          ..color = Colors.white70
          ..strokeWidth = 2.5);
  }

  void _drawKatana(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Bilah pedang melengkung tajam
    final path = Path()
      ..moveTo(w * 0.18, h * 0.3)
      ..quadraticBezierTo(w * 0.45, h * 0.48, w * 0.75, h * 0.68);
    canvas.drawPath(
      path,
      Paint()
        ..color = const Color(0xFFD6DDD8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0,
    );

    // Tsuba (Pelindung tangan bulat)
    canvas.drawCircle(Offset(w * 0.74, h * 0.67), 9.0,
        Paint()..color = const Color(0xFF8B6C38));

    // Tsuka (Gagang pedang bertali cokelat)
    canvas.drawLine(
      Offset(w * 0.75, h * 0.68),
      Offset(w * 0.88, h * 0.78),
      Paint()
        ..color = const Color(0xFF382618)
        ..strokeWidth = 7.0,
    );
  }

  void _drawGeneric(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    canvas.drawCircle(Offset(w * 0.5, h * 0.5), 32.0,
        Paint()..color = const Color(0xFF263228));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

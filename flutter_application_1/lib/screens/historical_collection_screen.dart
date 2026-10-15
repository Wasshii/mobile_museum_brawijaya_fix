import 'package:flutter/material.dart';
import '../models/historical_item.dart';
import '../theme/app_colors.dart';
import '../widgets/ambient_background.dart';
import 'historical_detail_screen.dart';

/// Halaman Fitur Koleksi Benda Sejarah Museum Brawijaya (Foto 1)
class HistoricalCollectionScreen extends StatefulWidget {
  const HistoricalCollectionScreen({super.key});

  @override
  State<HistoricalCollectionScreen> createState() =>
      _HistoricalCollectionScreenState();
}

class _HistoricalCollectionScreenState
    extends State<HistoricalCollectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<HistoricalItem> _allItems = [];
  List<HistoricalItem> _filteredItems = [];

  // Kategori terpilih: 'Semua', 'Senjata', 'Kendaraan', 'Maritim', 'Peralatan'
  String _selectedCategory = 'Semua';

  final List<String> _categoryOptions = const [
    'Semua',
    'Senjata',
    'Kendaraan',
    'Maritim',
    'Peralatan',
  ];

  @override
  void initState() {
    super.initState();
    _allItems = HistoricalItem.defaultItems;
    _applyFilterAndSearch();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applyFilterAndSearch() {
    final query = _searchController.text.trim().toLowerCase();

    setState(() {
      _filteredItems = _allItems.where((item) {
        // 1. Cek Kategori
        final matchesCategory = (_selectedCategory == 'Semua') ||
            (item.category.toLowerCase() == _selectedCategory.toLowerCase());

        // 2. Cek Query Pencarian
        final matchesQuery = query.isEmpty ||
            item.name.toLowerCase().contains(query) ||
            item.description.toLowerCase().contains(query) ||
            item.historyText.toLowerCase().contains(query) ||
            item.category.toLowerCase().contains(query);

        return matchesCategory && matchesQuery;
      }).toList();
    });
  }

  void _onSearchChanged(String query) {
    _applyFilterAndSearch();
  }

  /// Pop-up Modal Filterisasi dengan Tombol "Simpan"
  void _showFilterModal() {
    String tempSelected = _selectedCategory;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
              decoration: const BoxDecoration(
                color: Color(0xFF141715),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
                border: Border(
                  top: BorderSide(color: Color(0xFF282E2A), width: 1.2),
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Drag Handle
                    Center(
                      child: Container(
                        width: 44.0,
                        height: 4.5,
                        margin: const EdgeInsets.only(bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(2.5),
                        ),
                      ),
                    ),

                    // Judul Filter
                    const Text(
                      'Filter Koleksi Benda Sejarah',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Pilih kategori jenis artefak yang ingin ditampilkan',
                      style: TextStyle(
                        color: Color(0xFF8E9590),
                        fontSize: 12.5,
                      ),
                    ),
                    const SizedBox(height: 18.0),

                    // Opsi Pilihan Kategori
                    ..._categoryOptions.map((category) {
                      final isSelected = tempSelected == category;
                      return InkWell(
                        onTap: () {
                          setModalState(() {
                            tempSelected = category;
                          });
                        },
                        borderRadius: BorderRadius.circular(16.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14.0,
                            vertical: 12.0,
                          ),
                          margin: const EdgeInsets.only(bottom: 8.0),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF1F2922)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primaryGreen
                                  : const Color(0xFF242A26),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    _getCategoryIcon(category),
                                    size: 20,
                                    color: isSelected
                                        ? AppColors.primaryGreen
                                        : const Color(0xFF8E9590),
                                  ),
                                  const SizedBox(width: 12.0),
                                  Text(
                                    category == 'Semua'
                                        ? 'Semua Koleksi'
                                        : 'Jenis $category',
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFFC8CEC9),
                                      fontSize: 14.0,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              if (isSelected)
                                Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primaryGreen,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    size: 14.0,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20.0),

                    // Tombol Simpan
                    SizedBox(
                      width: double.infinity,
                      height: 48.0,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _selectedCategory = tempSelected;
                            _applyFilterAndSearch();
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Senjata':
        return Icons.military_tech_rounded;
      case 'Kendaraan':
        return Icons.directions_car_rounded;
      case 'Maritim':
        return Icons.directions_boat_rounded;
      case 'Peralatan':
        return Icons.radio_rounded;
      default:
        return Icons.all_inclusive_rounded;
    }
  }

  void _navigateToDetail(HistoricalItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HistoricalDetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: AmbientBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar: Tombol "<- Kembali"
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 12.0,
                ),
                child: InkWell(
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
              ),
              const SizedBox(height: 8.0),

              // 2. Search Bar + Tombol Filter Hijau Bulat (Foto 1)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    // Kolom Input Pencarian Kapsul
                    Expanded(
                      child: Container(
                        height: 52.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF181B19),
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(
                            color: const Color(0xFF282E2A),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              color: Color(0xFF8E9590),
                              size: 22.0,
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: _onSearchChanged,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.5,
                                ),
                                cursorColor: AppColors.primaryGreen,
                                decoration: const InputDecoration(
                                  hintText: 'Cari benda sejarah...',
                                  hintStyle: TextStyle(
                                    color: Color(0xFF6E7570),
                                    fontSize: 14.0,
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            if (_searchController.text.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _searchController.clear();
                                  _onSearchChanged('');
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Color(0xFF8E9590),
                                  size: 18.0,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 14.0),

                    // Tombol Filter Bulat Hijau (Foto 1)
                    InkWell(
                      onTap: _showFilterModal,
                      borderRadius: BorderRadius.circular(26.0),
                      child: Container(
                        width: 52.0,
                        height: 52.0,
                        decoration: const BoxDecoration(
                          color: Color(0xFF6EA87E), // Aksen hijau bulat Foto 1
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.tune_rounded,
                            color: Colors.white,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Indikator filter aktif jika bukan "Semua"
              if (_selectedCategory != 'Semua')
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, top: 12.0, right: 20.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 4.5),
                        decoration: BoxDecoration(
                          color: AppColors.primaryGreen.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(
                              color: AppColors.primaryGreen.withOpacity(0.4)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Kategori: $_selectedCategory',
                              style: const TextStyle(
                                color: AppColors.primaryGreen,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 6.0),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedCategory = 'Semua';
                                  _applyFilterAndSearch();
                                });
                              },
                              child: const Icon(Icons.close_rounded,
                                  size: 14.0, color: AppColors.primaryGreen),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 18.0),

              // 3. Daftar Kartu / Empty State (Foto 1)
              Expanded(
                child: _filteredItems.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 6.0,
                        ),
                        itemCount: _filteredItems.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16.0),
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return _buildHistoricalCard(item);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Tampilan Empty State 1:1 sesuai Foto 1
  /// Menampilkan ikon outline folder besar dan teks dua baris
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ikon Outline Folder Rounded Besar (Foto 1)
          CustomPaint(
            size: const Size(130.0, 100.0),
            painter: _FolderOutlinePainter(),
          ),
          const SizedBox(height: 28.0),

          // Teks Dua Baris (Foto 1)
          const Text(
            'Tidak Ditemukan Keywoard Dengan\nKoleksi Benda Sejarah Di Sini',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFA2A9A5),
              fontSize: 14.5,
              height: 1.45,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// Kartu Koleksi Benda Sejarah 1:1 sesuai Foto 1
  Widget _buildHistoricalCard(HistoricalItem item) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24.0),
      child: InkWell(
        onTap: () => _navigateToDetail(item),
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF181B19),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: const Color(0xFF282E2A),
              width: 1.0,
            ),
          ),
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Gambar Thumbnail Artefak (Kiri)
              Container(
                width: 95.0,
                height: 75.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: const Color(0xFF2A302C),
                    width: 0.8,
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: _buildItemThumbnail(item.id),
              ),
              const SizedBox(width: 14.0),

              // 2. Judul & Ringkasan Deskripsi (Tengah)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      item.description,
                      style: const TextStyle(
                        color: Color(0xFF8E9590),
                        fontSize: 10.5,
                        height: 1.35,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),

              // 3. Tombol Bulat Putih Panah Kanan (Kanan)
              Container(
                width: 32.0,
                height: 32.0,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF1A1D1B),
                    size: 20.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Thumbnail representasi visual artefak sejarah Museum Brawijaya
  Widget _buildItemThumbnail(String itemId) {
    return CustomPaint(
      painter: _ThumbnailPainter(itemId: itemId),
    );
  }
}

/// CustomPainter untuk Ikon Outline Folder Rounded Besar (Foto 1)
class _FolderOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final paint = Paint()
      ..color = const Color(0xFF38403B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final r = 18.0;

    // Path folder dengan tab di kiri atas dan sudut membulat halus
    final path = Path()
      // Mulai dari bawah tab
      ..moveTo(r, 0)
      ..lineTo(w * 0.42, 0)
      ..lineTo(w * 0.52, h * 0.22)
      ..lineTo(w - r, h * 0.22)
      ..arcToPoint(Offset(w, h * 0.22 + r), radius: Radius.circular(r))
      ..lineTo(w, h - r)
      ..arcToPoint(Offset(w - r, h), radius: Radius.circular(r))
      ..lineTo(r, h)
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r))
      ..lineTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: Radius.circular(r))
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// CustomPainter untuk Thumbnail item list
class _ThumbnailPainter extends CustomPainter {
  final String itemId;

  _ThumbnailPainter({required this.itemId});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: const [
          Color(0xFF263228),
          Color(0xFF1E2822),
          Color(0xFF131714),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    switch (itemId) {
      case 'perahu-segigir':
        // Layar & lambung perahu
        canvas.drawLine(
            Offset(w * 0.28, h * 0.18),
            Offset(w * 0.28, h * 0.7),
            Paint()
              ..color = Colors.white70
              ..strokeWidth = 2.0);
        final boatPath = Path()
          ..moveTo(w * 0.1, h * 0.45)
          ..lineTo(w * 0.22, h * 0.72)
          ..lineTo(w * 0.88, h * 0.65)
          ..lineTo(w * 0.94, h * 0.45)
          ..lineTo(w * 0.5, h * 0.52)
          ..close();
        canvas.drawPath(boatPath, Paint()..color = const Color(0xFFE2E7E4));
        canvas.drawLine(
            Offset(w * 0.15, h * 0.55),
            Offset(w * 0.88, h * 0.58),
            Paint()
              ..color = const Color(0xFF1C201E)
              ..strokeWidth = 2.5);
        canvas.drawRect(Rect.fromLTWH(w * 0.25, h * 0.72, w * 0.55, h * 0.16),
            Paint()..color = const Color(0xFF2C322E));
        break;

      case 'mobil-de-soto':
        canvas.drawRect(Rect.fromLTWH(0, h * 0.6, w, h * 0.4),
            Paint()..color = const Color(0xFFD6DDD8));
        final carW = w * 0.62;
        final carL = (w - carW) / 2;
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(carL, h * 0.42, carW, h * 0.36),
                const Radius.circular(8.0)),
            Paint()..color = const Color(0xFF141716));
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(carL + 12, h * 0.52, carW - 24, h * 0.2),
                const Radius.circular(4.0)),
            Paint()..color = const Color(0xFFC9D1CC));
        canvas.drawCircle(Offset(carL + 6, h * 0.54), 4.5,
            Paint()..color = const Color(0xFFFFF7D6));
        canvas.drawCircle(Offset(carL + carW - 6, h * 0.54), 4.5,
            Paint()..color = const Color(0xFFFFF7D6));
        break;

      case 'meriam-obus':
        final barrel = Path()
          ..moveTo(w * 0.2, h * 0.28)
          ..lineTo(w * 0.65, h * 0.58)
          ..lineTo(w * 0.62, h * 0.68)
          ..lineTo(w * 0.18, h * 0.38)
          ..close();
        canvas.drawPath(barrel, Paint()..color = const Color(0xFF3B483C));
        canvas.drawCircle(Offset(w * 0.58, h * 0.68), 16.0,
            Paint()..color = const Color(0xFF1A1F1B));
        canvas.drawCircle(Offset(w * 0.58, h * 0.68), 5.5,
            Paint()..color = const Color(0xFF748477));
        break;

      case 'gerbong-maut':
        canvas.drawRect(Rect.fromLTWH(0, h * 0.8, w, 3),
            Paint()..color = const Color(0xFF707672));
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(w * 0.12, h * 0.28, w * 0.76, h * 0.5),
                const Radius.circular(5.0)),
            Paint()..color = const Color(0xFF28201A));
        canvas.drawCircle(Offset(w * 0.28, h * 0.8), 8.0,
            Paint()..color = const Color(0xFF1A1A1A));
        canvas.drawCircle(Offset(w * 0.72, h * 0.8), 8.0,
            Paint()..color = const Color(0xFF1A1A1A));
        break;

      case 'tank-amx13':
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(w * 0.18, h * 0.62, w * 0.64, h * 0.2),
                const Radius.circular(10.0)),
            Paint()..color = const Color(0xFF1E2420));
        canvas.drawRect(Rect.fromLTWH(w * 0.22, h * 0.48, w * 0.56, h * 0.16),
            Paint()..color = const Color(0xFF334035));
        canvas.drawLine(
            Offset(w * 0.45, h * 0.45),
            Offset(w * 0.1, h * 0.45),
            Paint()
              ..color = const Color(0xFF222B24)
              ..strokeWidth = 4.0);
        break;

      case 'senapan-browning':
        canvas.drawRect(Rect.fromLTWH(w * 0.35, h * 0.48, w * 0.3, h * 0.12),
            Paint()..color = const Color(0xFF1A1E1C));
        canvas.drawLine(
            Offset(w * 0.35, h * 0.54),
            Offset(w * 0.08, h * 0.54),
            Paint()
              ..color = const Color(0xFF2A302C)
              ..strokeWidth = 5.0);
        canvas.drawLine(
            Offset(w * 0.45, h * 0.55),
            Offset(w * 0.25, h * 0.8),
            Paint()
              ..color = const Color(0xFF2E3330)
              ..strokeWidth = 2.5);
        canvas.drawLine(
            Offset(w * 0.45, h * 0.55),
            Offset(w * 0.65, h * 0.8),
            Paint()
              ..color = const Color(0xFF2E3330)
              ..strokeWidth = 2.5);
        break;

      case 'keris-pusaka':
        final path = Path()..moveTo(w * 0.5, h * 0.8);
        for (int i = 0; i < 7; i++) {
          final y = h * (0.8 - (i * 0.08));
          final offset = (i % 2 == 0) ? 6.0 : -6.0;
          path.quadraticBezierTo(w * 0.5 + offset, y + 6, w * 0.5, y);
        }
        canvas.drawPath(
            path,
            Paint()
              ..color = const Color(0xFFD4A76A)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3.5);
        break;

      case 'mortir-81mm':
        final mortar = Path()
          ..moveTo(w * 0.35, h * 0.28)
          ..lineTo(w * 0.65, h * 0.72)
          ..lineTo(w * 0.58, h * 0.76)
          ..lineTo(w * 0.28, h * 0.32)
          ..close();
        canvas.drawPath(mortar, Paint()..color = const Color(0xFF3D483E));
        canvas.drawLine(
            Offset(w * 0.45, h * 0.5),
            Offset(w * 0.32, h * 0.74),
            Paint()
              ..color = const Color(0xFF262C27)
              ..strokeWidth = 2.5);
        canvas.drawLine(
            Offset(w * 0.45, h * 0.5),
            Offset(w * 0.55, h * 0.74),
            Paint()
              ..color = const Color(0xFF262C27)
              ..strokeWidth = 2.5);
        break;

      case 'radio-pemancar':
        canvas.drawRRect(
            RRect.fromRectAndRadius(
                Rect.fromLTWH(w * 0.22, h * 0.35, w * 0.56, h * 0.45),
                const Radius.circular(8.0)),
            Paint()..color = const Color(0xFF2F3C34));
        canvas.drawCircle(Offset(w * 0.38, h * 0.52), 12.0,
            Paint()..color = const Color(0xFF1C221F));
        canvas.drawLine(
            Offset(w * 0.28, h * 0.35),
            Offset(w * 0.22, h * 0.15),
            Paint()
              ..color = Colors.white70
              ..strokeWidth = 2.0);
        break;

      case 'pedang-katana':
        final katana = Path()
          ..moveTo(w * 0.18, h * 0.32)
          ..quadraticBezierTo(w * 0.45, h * 0.5, w * 0.75, h * 0.68);
        canvas.drawPath(
            katana,
            Paint()
              ..color = const Color(0xFFD6DDD8)
              ..style = PaintingStyle.stroke
              ..strokeWidth = 3.5);
        canvas.drawCircle(Offset(w * 0.74, h * 0.67), 7.0,
            Paint()..color = const Color(0xFF8B6C38));
        canvas.drawLine(
            Offset(w * 0.75, h * 0.68),
            Offset(w * 0.88, h * 0.78),
            Paint()
              ..color = const Color(0xFF382618)
              ..strokeWidth = 5.0);
        break;

      default:
        canvas.drawCircle(Offset(w * 0.5, h * 0.5), 20.0,
            Paint()..color = const Color(0xFF2E3832));
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

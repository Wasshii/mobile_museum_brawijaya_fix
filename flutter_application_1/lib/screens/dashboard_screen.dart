import 'package:flutter/material.dart';
import '../models/dummy_user.dart';
import '../services/dummy_auth_service.dart';
import '../theme/app_colors.dart';
import 'historical_collection_screen.dart';
import 'login_screen.dart';
import 'ticket_booking_screen.dart';

/// Dashboard Screen Museum Brawijaya
/// Dibangun 1:1 sesuai desain referensi ketiga
class DashboardScreen extends StatefulWidget {
  final DummyUser user;

  const DashboardScreen({
    super.key,
    required this.user,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['Pelayanan', 'Sejarah', 'CS'];

  void _handleLogout() {
    DummyAuthService().logout();
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  void _showDrawerMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
          border: Border(
            top: BorderSide(color: AppColors.cardBorder, width: 1.2),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 44.0,
                height: 4.5,
                margin: const EdgeInsets.only(bottom: 20.0),
                decoration: BoxDecoration(
                  color: AppColors.textMuted.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFFE5A93C),
                    child: CircleAvatar(
                      radius: 23,
                      backgroundColor: Color(0xFF2E3430),
                      child: Icon(Icons.person, color: Colors.white, size: 28),
                    ),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.name,
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          widget.user.email,
                          style: const TextStyle(
                            color: AppColors.textMuted,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const Divider(color: AppColors.dividerLine),
              const SizedBox(height: 12.0),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.history_edu_rounded,
                    color: AppColors.primaryGreen),
                title: const Text('Koleksi & Panduan Sejarah',
                    style: TextStyle(color: AppColors.textWhite)),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.settings_outlined,
                    color: AppColors.textMuted),
                title: const Text('Pengaturan Aplikasi',
                    style: TextStyle(color: AppColors.textWhite)),
                onTap: () => Navigator.pop(context),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.infinity,
                height: 46.0,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleLogout();
                  },
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: const Text('Keluar (Logout)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2B1F20),
                    foregroundColor: AppColors.errorRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                      side: BorderSide(
                        color: AppColors.errorRed.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFeatureToast(String featureName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Fitur $featureName akan hadir pada pembaruan mendatang.'),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.cardBackground,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBase,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar: Avatar, Greeting, Hamburger Menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Avatar bulat dengan border kuning emas
                      Container(
                        width: 46.0,
                        height: 46.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFF3BF4B),
                            width: 2.2,
                          ),
                        ),
                        child: ClipOval(
                          child: Container(
                            color: const Color(0xFF28322B),
                            child: const Icon(
                              Icons.person_rounded,
                              color: Color(0xFFE2EBE5),
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14.0),
                      // Teks Sapaan
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hola,',
                            style: TextStyle(
                              color: AppColors.textMuted,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            widget.user.name,
                            style: const TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Tombol Hamburger Menu
                  InkWell(
                    onTap: _showDrawerMenu,
                    borderRadius: BorderRadius.circular(12.0),
                    child: Container(
                      width: 44.0,
                      height: 44.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E2220),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: const Color(0xFF2A302C),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 18.0,
                              height: 2.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                            const SizedBox(height: 5.0),
                            Container(
                              width: 18.0,
                              height: 2.2,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(1.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 26.0),

              // 2. Brand Header: "Museum" + Badge "Brawijaya"
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Museum',
                    style: TextStyle(
                      color: AppColors.textWhite,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      'Brawijaya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),

              // 3. Hero Banner: Rahasia di Balik Bilah Keris Kuno (Stacked Card Effect)
              _buildStackedHeroBanner(),
              const SizedBox(height: 28.0),

              // 4. Section Kategori
              const Text(
                'Kategori',
                style: TextStyle(
                  color: AppColors.textWhite,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
              ),
              const SizedBox(height: 14.0),

              // Baris Filter Kategori
              Row(
                children: [
                  // Tab 1: Pelayanan
                  _buildCategoryTab(
                    title: 'Pelayanan',
                    index: 0,
                    hasNotificationDot: false,
                  ),
                  const SizedBox(width: 12.0),

                  // Tab 2: Sejarah (dengan Red Dot)
                  _buildCategoryTab(
                    title: 'Sejarah',
                    index: 1,
                    hasNotificationDot: true,
                  ),
                  const SizedBox(width: 12.0),

                  // Tab 3: CS
                  _buildCategoryTab(
                    title: 'CS',
                    index: 2,
                    hasNotificationDot: false,
                  ),
                ],
              ),
              const SizedBox(height: 22.0),

              // 5. Grid 2x2 Menu Fitur Utama
              Row(
                children: [
                  // Kartu 1: Pindai & Jelajahi Sejarah
                  Expanded(
                    child: _buildGridFeatureCard(
                      icon: Icons.filter_center_focus_rounded,
                      title: 'Pindai & Jelajahi\nSejarah',
                      badgeText: 'Scan',
                      hasArrowButton: true,
                      onTap: () =>
                          _showFeatureToast('Pindai & Jelajahi Sejarah'),
                    ),
                  ),
                  const SizedBox(width: 14.0),

                  // Kartu 2: Benda Sejarah (Foto 2)
                  Expanded(
                    child: _buildGridFeatureCard(
                      icon: Icons.account_balance_outlined,
                      title: 'Benda\nSejarah',
                      badgeText: 'Sejarah',
                      hasArrowButton: true,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => HistoricalCollectionScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),

              Row(
                children: [
                  // Kartu 3: Bagikan Kesan Kunjunganmu
                  Expanded(
                    child: _buildGridFeatureCard(
                      icon: Icons.rate_review_outlined,
                      title: 'Bagikan\nKesan\nKunjunganmu',
                      badgeText: 'Feedback',
                      hasArrowButton: true,
                      onTap: () =>
                          _showFeatureToast('Bagikan Kesan Kunjunganmu'),
                    ),
                  ),
                  const SizedBox(width: 14.0),

                  // Kartu 4: Pesan Tiket
                  Expanded(
                    child: _buildTicketFeatureCard(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TicketBookingScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }

  /// Banner bertumpuk (Stacked Card) berisi pameran Bilah Keris Kuno
  Widget _buildStackedHeroBanner() {
    return Column(
      children: [
        // Lapisan bayangan tumpukan kartu atas
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.76,
            height: 6.0,
            decoration: const BoxDecoration(
              color: Color(0xFF161917),
              borderRadius: BorderRadius.vertical(top: Radius.circular(14.0)),
            ),
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.84,
            height: 6.0,
            decoration: const BoxDecoration(
              color: Color(0xFF1F2421),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
          ),
        ),
        // Kartu Hero Utama
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF141715),
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(
              color: const Color(0xFF282F2A),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 20.0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              // Latar belakang foto pameran keris dengan aksen pencahayaan museum
              Positioned.fill(
                child: CustomPaint(
                  painter: _MuseumShowcasePainter(),
                ),
              ),

              // Konten teks dan aksi
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Kolom teks di sisi kiri
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Rahasia di Balik\nBilah Keris Kuno',
                            style: TextStyle(
                              color: AppColors.textWhite,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              height: 1.25,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Temukan kisah, filosofi mendalam,\ndan kekuatan sejarah tersembunyi\nyang tertempa di setiap lekuk keris\nleluhur kita. Jelajahi sekarang!',
                            style: TextStyle(
                              color: Color(0xFFA2A9A5),
                              fontSize: 10.5,
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          // Tombol "Cari Tahu ->"
                          InkWell(
                            onTap: () =>
                                _showFeatureToast('Koleksi Keris Kuno'),
                            borderRadius: BorderRadius.circular(16.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                                vertical: 6.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.45),
                                borderRadius: BorderRadius.circular(16.0),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                ),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Cari Tahu',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11.5,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 6.0),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 13,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(flex: 4, child: SizedBox()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Tab kategori pil dengan indikator aktif & dot notifikasi
  Widget _buildCategoryTab({
    required String title,
    required int index,
    required bool hasNotificationDot,
  }) {
    final isSelected = _selectedCategoryIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedCategoryIndex = index;
          });
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 42.0,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryGreen
                    : const Color(0xFF1E2220),
                borderRadius: BorderRadius.circular(22.0),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.5,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (hasNotificationDot)
              Positioned(
                top: 2,
                right: 8,
                child: Container(
                  width: 9.0,
                  height: 9.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE55757),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Kartu fitur grid (Pindai, Maps, Feedback)
  Widget _buildGridFeatureCard({
    required IconData icon,
    required String title,
    required String badgeText,
    required bool hasArrowButton,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(24.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          height: 160.0,
          decoration: BoxDecoration(
            color: const Color(0xFF181B19),
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(
              color: const Color(0xFF282E2A),
              width: 1.0,
            ),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Ikon Fitur
                    Icon(
                      icon,
                      size: 26.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 12.0),

                    // Judul
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textWhite,
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),

                    // Label Kategori Bawah
                    Text(
                      badgeText,
                      style: const TextStyle(
                        color: AppColors.textMuted,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Tombol Lingkaran Putih di Pojok Kanan Bawah
              if (hasArrowButton)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(24.0),
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF1E2220),
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Kartu Pesan Tiket (Ikon Tiket & Tanda Plus)
  Widget _buildTicketFeatureCard({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24.0),
      child: Container(
        height: 160.0,
        decoration: BoxDecoration(
          color: const Color(0xFF181B19),
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(
            color: const Color(0xFF282E2A),
            width: 1.0,
          ),
        ),
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ikon Tiket
            const Icon(
              Icons.confirmation_number_rounded,
              size: 38.0,
              color: Colors.white,
            ),
            const SizedBox(height: 14.0),

            // Teks "Pesan Tiket" dan Tombol Tambah
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Pesan\nTiket',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textWhite,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                    height: 1.25,
                  ),
                ),
                const SizedBox(width: 8.0),
                Container(
                  width: 26.0,
                  height: 26.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 1.2,
                    ),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// CustomPainter untuk menggambar visual etalase museum kaca pameran keris kuno
class _MuseumShowcasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Gradasi gelap latar belakang etalase
    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF141715),
          const Color(0xFF1A1F1C),
          const Color(0xFF382A1C), // Semburat hangat pencahayaan lampu etalase
          const Color(0xFF141715),
        ],
        stops: const [0.0, 0.45, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), bgPaint);

    // Garis etalase kaca display keris di sisi kanan
    final glassFramePaint = Paint()
      ..color = const Color(0xFF4A3824).withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(
      Rect.fromLTWH(w * 0.52, h * 0.1, w * 0.44, h * 0.8),
      glassFramePaint,
    );

    // Siluet bilah keris vertikal
    final kerisPaint = Paint()
      ..color = const Color(0xFFD4A76A).withOpacity(0.65)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 5; i++) {
      final x = w * (0.58 + (i * 0.07));
      final topY = h * 0.22;
      final bottomY = h * 0.72;

      final path = Path()..moveTo(x, bottomY);
      // Buat liukan bilah keris (luk)
      path.quadraticBezierTo(
          x - 3, (topY + bottomY) / 2 + 10, x, (topY + bottomY) / 2);
      path.quadraticBezierTo(x + 3, (topY + bottomY) / 2 - 10, x, topY);

      canvas.drawPath(path, kerisPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Model data untuk koleksi benda sejarah Museum Brawijaya
class HistoricalItem {
  final String id;
  final String name;
  final String description;
  final String category; // 'Maritim', 'Kendaraan', 'Senjata', 'Peralatan'
  final String yearPeriod;
  final String historyText;
  final List<String> identities;

  const HistoricalItem({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.yearPeriod,
    required this.historyText,
    required this.identities,
  });

  /// Daftar 10 koleksi artefak sejarah resmi Museum Brawijaya
  static List<HistoricalItem> get defaultItems => const [
        // 1. Perahu Segigir
        HistoricalItem(
          id: 'perahu-segigir',
          name: 'Perahu Segigir',
          description:
              'Perahu nelayan asal Madura yang menyamar menembus blokade udara Belanda demi menyelamatkan pasukan Joko Tole pada tahun 1947.',
          category: 'Maritim',
          yearPeriod: '1947',
          historyText:
              'Perahu Segigir merupakan perahu cadik tradisional asal Desa Prenduan, Sumenep, Madura, milik Bapak Makiya yang menjadi saksi bisu perjuangan Resimen Jokotole di bawah pimpinan Letkol Chandra Hasan saat meloloskan diri dari kepungan tentara Belanda pada masa Agresi Militer Belanda I di bulan November 1947. Perahu nelayan ini digunakan secara rahasia untuk menyeberangi Selat Madura membawa para pejuang demi mempertahankan kedaulatan tanah air.',
          identities: [
            'Nama Koleksi: Perahu Segigir',
            'Jenis Objek: Perahu Cadik Tradisional (Perahu Nelayan)',
            'Asal Daerah: Desa Prenduan, Kecamatan Pragaan, Kabupaten Sumenep, Madura',
            'Pemilik Asli: Bapak Makiya',
            'Bahan Utama: Kayu jati pilihan dengan bambu sebagai cadik penyeimbang',
            'Kapasitas Muatan: 5 hingga 6 orang',
          ],
        ),

        // 2. Mobil De Soto Custom
        HistoricalItem(
          id: 'mobil-de-soto',
          name: 'Mobil De Soto Custom',
          description:
              'Mobil dinas klasik peninggalan Kolonel Soegiono yang digunakan untuk memimpin perjuangan mempertahankan kedaulatan Indonesia di Jawa Timur pada tahun 1948 hingga 1950.',
          category: 'Kendaraan',
          yearPeriod: '1948 - 1950',
          historyText:
              'Mobil dinas tipe sedan buatan Amerika Serikat tahun 1947 ini pernah digunakan oleh Kolonel Soegiono, Kepala Staf Komando Daerah Militer Brawijaya, dalam memimpin pergerakan pasukan gerilya di Jawa Timur menghadapi Agresi Militer Belanda II (1948–1949). Mobil ini dirancang kokoh dan disamarkan untuk menembus pos-pos patroli musuh.',
          identities: [
            'Nama Koleksi: Mobil De Soto Sedan Custom',
            'Jenis Objek: Kendaraan Dinas Perwira Tempur',
            'Pabrikan / Asal: Amerika Serikat (Chrysler Group)',
            'Pengguna Bersejarah: Kolonel Soegiono (Pahlawan Militer Brawijaya)',
            'Tahun Penggunaan: 1948 - 1950',
            'Bahan / Warna: Rangka baja kokoh / Hitam Militer Klasik',
          ],
        ),

        // 3. Meriam Obus (Meriam Gunung)
        HistoricalItem(
          id: 'meriam-obus',
          name: 'Meriam Obus (Meriam Gunung)',
          description:
              'Meriam lapangan laras pendek rampasan perang yang digunakan dalam operasi militer di Timor Timur pada periode tahun 1975 hingga 1976 dan kini dipamerkan di ruang koleksi dalam Museum Brawijaya, Malang.',
          category: 'Senjata',
          yearPeriod: '1975 - 1976',
          historyText:
              'Meriam gunung kaliber 75mm laras pendek ini merupakan senjata artileri legendaris yang dirampas dari tentara penjajah. Didesain untuk medan perbukitan terjal dan pegunungan, meriam ini pernah diandalkan oleh para prajurit pejuang Brawijaya dalam pertempuran mempertahankan lereng Gunung Kelud dan operasi keamanan wilayah Jawa Timur.',
          identities: [
            'Nama Koleksi: Meriam Obus Kaliber 75 mm',
            'Jenis Objek: Senjata Artileri Medan Ringan',
            'Kaliber Peluru: 75 mm',
            'Jangkauan Efektif: Sekitar 5.000 meter',
            'Pengoperasian: 4 hingga 6 orang awak regu artileri',
            'Status Koleksi: Rampasan perang operasi kedaulatan RI',
          ],
        ),

        // 4. Gerbong Maut Bondowoso
        HistoricalItem(
          id: 'gerbong-maut',
          name: 'Gerbong Maut Bondowoso',
          description:
              'Gerbong barang kereta api tertutup rapat yang menjadi saksi bisu gugurnya 46 tawanan pejuang kemerdekaan saat pemindahan dari Bondowoso ke Surabaya pada 23 November 1947.',
          category: 'Kendaraan',
          yearPeriod: '1947',
          historyText:
              'Gerbong kereta barang bertutup rapat berkode GR 10152 ini menjadi saksi kekejaman tentara Belanda saat memindahkan 100 orang pejuang tawanan dari Bondowoso menuju Penjara Wonokromo, Surabaya pada 23 November 1947. Karena gerbong disegel tanpa ventilasi udara dan makanan di bawah terik matahari selama 16 jam, 46 pejuang gugur sebagai kusuma bangsa.',
          identities: [
            'Nama Koleksi: Gerbong Maut (Nomor Seri GR 10152)',
            'Jenis Objek: Gerbong Barang Kereta Api Bersejarah',
            'Peristiwa Bersejarah: Tragedi Pemindahan Tawanan Bondowoso–Surabaya',
            'Tanggal Peristiwa: 23 November 1947',
            'Jumlah Korban Gugur: 46 pejuang kemerdekaan',
            'Tempat Pameran: Halaman Luar Museum Brawijaya Malang',
          ],
        ),

        // 5. Tank Amfibi AMX-13
        HistoricalItem(
          id: 'tank-amx13',
          name: 'Tank Amfibi AMX-13',
          description:
              'Kendaraan tempur lapis baja ringan yang memperkuat korps kavaleri TNI AD dalam mempertahankan kedaulatan dan stabilitas keamanan wilayah Republik Indonesia.',
          category: 'Kendaraan',
          yearPeriod: '1960 - 1980',
          historyText:
              'Kendaraan tempur lapis baja ringan buatan Prancis yang didatangkan ke Indonesia pada dekade 1960-an untuk memperkuat Korps Kavaleri TNI AD. Tank ini turut aktif dalam berbagai operasi militer penumpasan pemberontakan dalam negeri serta pengamanan wilayah teritorial Jawa Timur sebelum akhirnya dipensiunkan sebagai koleksi edukasi militer.',
          identities: [
            'Nama Koleksi: Tank Tempur Ringan AMX-13',
            'Jenis Objek: Kendaraan Lapis Baja Tempur Kavaleri',
            'Persenjataan Utama: Meriam kaliber 75mm / 90mm',
            'Ketebalan Pelindung: Baja tebal 10 hingga 40 mm',
            'Awak Pengemudi: 3 orang (Komandan, Penembak, Pengemudi)',
            'Asal Pabrikan: Prancis (Atelier de Construction d\'Issy-les-Moulineaux)',
          ],
        ),

        // 6. Senapan Mesin Berat Browning .50
        HistoricalItem(
          id: 'senapan-browning',
          name: 'Senapan Mesin Browning .50',
          description:
              'Senapan mesin otomatis berat kaliber 12,7 mm andalan infanteri dan kavaleri untuk melumpuhkan kendaraan lapis baja ringan serta posisi pertahanan lawan.',
          category: 'Senjata',
          yearPeriod: '1945 - 1950',
          historyText:
              'Senapan mesin berat kaliber 12,7 mm legendaris yang dirampas dari pasukan sekutu dan Belanda. Dengan laju tembakan tinggi dan daya penetrasi kuat, senjata ini dipasang di pos-pos pertahanan strategis dan kendaraan taktis pejuang untuk menghalau laju pesawat intai maupun konvoi lapis baja musuh.',
          identities: [
            'Nama Koleksi: Senapan Mesin Berat Browning M2HB',
            'Jenis Objek: Senjata Mesin Otomatis Berat',
            'Kaliber Amunisi: .50 BMG (12,7 × 99 mm NATO)',
            'Kecepatan Tembak: 450 hingga 600 peluru per menit',
            'Jarak Jangkau Efektif: 1.800 meter',
            'Dudukan: Tripod berat M3 baja',
          ],
        ),

        // 7. Keris Pusaka Kyai Pamor
        HistoricalItem(
          id: 'keris-pusaka',
          name: 'Keris Pusaka Kyai Pamor',
          description:
              'Senjata tikam tradisional dengan luk sembilan dan pamor banyu mili, lambang keberanian spiritual serta kepemimpinan para perwira laskar perjuangan rakyat.',
          category: 'Senjata',
          yearPeriod: 'Abad XIX',
          historyText:
              'Keris pusaka tradisional warisan leluhur nusantara dengan lekuk luk sembilan dan pamor banyu mili. Keris ini dibawa oleh para bangsawan dan komandan laskar rakyat selama Perang Jawa dan masa pergerakan nasional sebagai simbol kepemimpinan, keberanian moral, dan ikatan spiritual dalam mengusir penjajah dari bumi nusantara.',
          identities: [
            'Nama Koleksi: Keris Pusaka Kyai Pamor Luk 9',
            'Jenis Objek: Senjata Tikam Tradisional Nusantara',
            'Bilah & Luk: 9 Lekukan (Luk) Baja Tempa Meteorit',
            'Warangka / Sarung: Kayu Timoho dihiasi perak ukir',
            'Filosofi: Ketenangan batin, perlindungan, dan wibawa ksatria',
            'Asal Budaya: Budaya Mataram & Jawa Timur',
          ],
        ),

        // 8. Mortir Udara Kaliber 81mm
        HistoricalItem(
          id: 'mortir-81mm',
          name: 'Mortir Udara Kaliber 81mm',
          description:
              'Senjata lengkung infanteri untuk tembakan bantuan jarak sedang yang sangat efektif menghantam sasaran pertahanan musuh di balik punggung bukit.',
          category: 'Senjata',
          yearPeriod: '1947 - 1950',
          historyText:
              'Mortir tabung penembak sudut tinggi kaliber 81mm yang digunakan oleh regu bantuan tempur infanteri Brawijaya. Senjata ini sangat efektif untuk menghantam kubu pertahanan musuh di balik bukit dan benteng perlindungan selama pertempuran gerilya mempertahankan kemerdekaan.',
          identities: [
            'Nama Koleksi: Mortir Tempur Lapangan 81mm',
            'Jenis Objek: Senjata Lengkung Bantu Infanteri',
            'Kaliber Tabung: 81 mm',
            'Berat Senjata: Sekitar 42 kg (termasuk bipod dan baseplate)',
            'Tipe Amunisi: Proyektil High Explosive (HE) & Asap',
            'Awak Pengawak: 3 orang prajurit infanteri',
          ],
        ),

        // 9. Radio Pemancar Darurat RRI
        HistoricalItem(
          id: 'radio-pemancar',
          name: 'Radio Pemancar Darurat RRI',
          description:
              'Perangkat komunikasi radio gelombang pendek yang menyuarakan perlawanan rakyat Jawa Timur dan membuktikan kedaulatan Indonesia tetap tegak ke dunia internasional.',
          category: 'Peralatan',
          yearPeriod: '1945 - 1949',
          historyText:
              'Perangkat pemancar dan penerima radio gelombang pendek yang digunakan para teknisi pejuang dan penyiar Radio Republik Indonesia (RRI) di pedalaman Jawa Timur saat Agresi Militer Belanda. Alat inilah yang menyiarkan pidato Bung Tomo dan kabar perlawanan rakyat Indonesia ke seluruh penjuru dunia untuk membuktikan kedaulatan RI masih tegak berdiri.',
          identities: [
            'Nama Koleksi: Radio Pemancar Transceiver Gelombang Pendek',
            'Jenis Objek: Peralatan Komunikasi & Siaran Perjuangan',
            'Operator Bersejarah: Awak Sandi & Teknisi Siaran RRI Perjuangan',
            'Tahun Pemakaian: 1945 - 1949',
            'Catu Daya: Dinamo engkol manual dan baterai darurat',
            'Asal Perolehan: Markas Komando Siaran Gerilya Jawa Timur',
          ],
        ),

        // 10. Pedang Katana Perwira Pasifik
        HistoricalItem(
          id: 'pedang-katana',
          name: 'Pedang Katana Perwira Pasifik',
          description:
              'Pedang dinas militer Gunto hasil pelucutan tentara Jepang pada tahun 1945 oleh pemuda BKR Malang untuk memperkuat persenjataan komando perlawanan.',
          category: 'Senjata',
          yearPeriod: '1945',
          historyText:
              'Pedang militer peninggalan perwira tentara Dai Nippon (Jepang) pada akhir Perang Pasifik tahun 1945. Ketika Jepang menyerah, senjata-senjata ini dilucuti secara berani oleh barisan pemuda PETA dan BKR di Malang, lalu digunakan untuk mempersenjatai komandan laskar dalam menghadapi kedatangan kembali pasukan NICA.',
          identities: [
            'Nama Koleksi: Pedang Gunto (Katana Militer Tipe 98)',
            'Jenis Objek: Senjata Sabetan Jarak Dekat Perwira',
            'Panjang Bilah: Sekitar 70 cm baja tempa berkarbon tinggi',
            'Gagang (Tsuka): Kulit ikan pari berlapis anyaman tali cokelat',
            'Sarung (Saya): Logam baja bercat zaitun pelindung lapangan',
            'Perolehan: Hasil pelucutan senjata tentara Jepang 1945',
          ],
        ),
      ];
}

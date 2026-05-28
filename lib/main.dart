import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

const Color green = Color(0xFF00897B);
const Color red  = Color(0xFFD32F2F);
const Color gray = Color(0xFFF5F5F5);

// ─── Ana Uygulama —————
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MHRS",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const AnasayfaPage(),
    );
  }
}

// ─── Ortak Bottom Bar ─────────────────────────────────────────
BottomNavigationBar buildBottomBar(int currentIndex, BuildContext context) {
  return BottomNavigationBar(
    currentIndex: currentIndex,
    selectedItemColor: gray,
    unselectedItemColor: Colors.grey,
    backgroundColor: Colors.white,
    elevation: 8,
    onTap: (index) {
      if (index == currentIndex) return;
      if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AnasayfaPage()));
      if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RandevularPage()));
      if (index == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MenuPage()));
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Anasayfa'),
      BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), activeIcon: Icon(Icons.calendar_month), label: 'Randevularım'),
      BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menü'),
    ],
  );
}

// ——————————————————————————————————————————————————
// BÖLÜM 1 ANA SAYFA
// ——————————————————————————————————————————————————
class AnasayfaPage extends StatelessWidget {
  const AnasayfaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  const SizedBox(height: 12),
                  _buildSearchBox(),
                  const SizedBox(height: 14),
                  _buildRandevuBtn(
                    icon: Icons.person_outline,
                    label: "Aile Hekimi Randevusu Al",
                    iconBg: green,
                    borderColor: green,
                    textColor: green,
                  ),
                  const SizedBox(height: 10),
                  _buildRandevuBtn(
                    icon: Icons.add,
                    label: "Hastane Randevusu Al",
                    iconBg: red,
                    borderColor: red,
                    textColor: red,
                  ),
                  const SizedBox(height: 10),
                  _buildRandevuBtn(
                    icon: Icons.monitor_heart_outlined,
                    label: "Sağlıklı Hayat Merkezi Randevusu Al",
                    iconBg: Colors.grey.shade600,
                    borderColor: Colors.grey.shade400,
                    textColor: Colors.black87,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "YAKLAŞAN RANDEVULARIM",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey, letterSpacing: 1),
                  ),
                  const SizedBox(height: 8),
                  _buildBosRandevu(),
                  const SizedBox(height: 12),
                  _buildSonGirisBtn(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(0, context),
    );
  }

  // Üst başlık
  Widget _buildHeader() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: "Hoş Geldiniz, ", style: TextStyle(fontSize: 18, color: green, fontWeight: FontWeight.w400)),
                TextSpan(text: "Süleyman Ezdemir", style: TextStyle(fontSize: 18, color: Color.fromARGB(221, 205, 4, 4), fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: green, width: 2)),
            child: const Icon(Icons.people_outline, color: green, size: 22),
          ),
        ],
      ),
    );
  }

  // Arama kutusu
  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: "Poliklinik, Hastahane veya Hekim Ara...",
          hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }

  // Randevu türü butonu
  Widget _buildRandevuBtn({required IconData icon, required String label, required Color iconBg, required Color borderColor, required Color textColor}) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border(left: BorderSide(color: borderColor, width: 4)),
        ),
        child: ListTile(
          leading: Container(
            width: 38, height: 38,
            decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          title: Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textColor)),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        ),
      ),
    );
  }

  // Yaklaşan randevu yok durumu
  Widget _buildBosRandevu() {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const Column(
          children: [
            Icon(Icons.calendar_today_outlined, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text("Yaklaşan randevunuz bulunmamaktadır.", style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  // Son giriş bilgileri butonu
  Widget _buildSonGirisBtn() {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: ListTile(
          leading: Container(
            width: 32, height: 32,
            decoration: const BoxDecoration(color: green, shape: BoxShape.circle),
            child: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
          ),
          title: const Text('Son Giriş Bilgilerim', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}

// ——————————————————————————————————————————————————
// BÖLÜM 2 RANDEVULARIM
// ——————————————————————————————————————————————————
class RandevularPage extends StatefulWidget {
  const RandevularPage({super.key});
  @override
  State<RandevularPage> createState() => _RandevularPageState();
}

class _RandevularPageState extends State<RandevularPage> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            _buildBaslik(),
            _buildTabBar(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Tab'a göre içerik göster
                  if (_selectedTab == 0) _buildBosTab("Aktif randevunuz bulunmamaktadır."),
                  if (_selectedTab == 1) _buildRandevuKarti(),
                  if (_selectedTab == 2) _buildBosTab("Gizli randevunuz bulunmamaktadır."),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(1, context),
    );
  }

  // Üst Kısım - logo ve bildirim
  Widget _buildTopBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add, color: Colors.white, size: 22),
          ),
          const Column(
            children: [
              Text("Merkezi Hekim", style: TextStyle(fontSize: 13, color: Colors.black54)),
              Text("Randevu Sistemi", style: TextStyle(fontSize: 13, color: red, fontWeight: FontWeight.w700)),
            ],
          ),
          const Icon(Icons.notifications_outlined, color: green, size: 26),
        ],
      ),
    );
  }

  // Sayfa başlığı
  Widget _buildBaslik() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      child: const Center(
        child: Text("Randevularım", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ),
    );
  }

  // Randevularım / Geçmiş / Gizli 
  Widget _buildTabBar() {
    final tabs = ["RANDEVULARIM", "GEÇMİŞ", "GİZLİ"];
    return Container(
      color: Colors.white,
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isSelected = _selectedTab == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: isSelected ? green : Colors.transparent, width: 2)),
                ),
                child: Text(
                  tabs[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    color: isSelected ? green : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Boş tab mesajı
  Widget _buildBosTab(String mesaj) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        children: [
          const Icon(Icons.calendar_today_outlined, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(mesaj, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }

  // Geçmiş randevu kartı
  Widget _buildRandevuKarti() {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarih ve saat satırı
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("5 Ocak 2026 Pazartesi", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.black54),
                      SizedBox(width: 4),
                      Text("15:20", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("GİRESUN ŞEBİNKARAHİSAR DEVLET HASTANESİ",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  _buildSatir(Icons.person_outline, green, "ARDA TOPSAKALOĞLU"),
                  const SizedBox(height: 4),
                  _buildSatir(Icons.add_box_outlined, green, "Diş Hekimliği (Genel Diş)"),
                  const SizedBox(height: 4),
                  _buildSatir(Icons.add_box_outlined, green, "DİŞ POLİKLİNİĞİ 1"),
                  const SizedBox(height: 8),
                  const Text("İptal Randevu ", style: TextStyle(fontSize: 13, color: red, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: green),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          ),
                          child: const Text('Randevu Al', style: TextStyle(color: green)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          ),
                          child: const Text('Gizle', style: TextStyle(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Kart içi ikon + metin satırı
  Widget _buildSatir(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 13)),
      ],
    );
  }
}

// ——————————————————————————————————————————————————
// BÖLÜM 3 MENÜ
// ——————————————————————————————————————————————————
class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                children: [
                  // Menü kartları - tıklanabilir
                  _buildMenuItem(
                    context: context,
                    icon: Icons.location_on,
                    iconColor: Colors.amber,
                    label: "Çevremdeki Hastaneler",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.star,
                    iconColor: Colors.amber,
                    label: "Favorilerim",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.medical_services_outlined,
                    iconColor: green,
                    label: "Hekimler",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.settings_outlined,
                    iconColor: Colors.grey,
                    label: "Ayarlar",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.person_outline,
                    iconColor: green,
                    label: "Profil",
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.logout,
                    iconColor: red,
                    label: "Çıkış Yap",
                    // Çıkış yapınca anasayfaya dön
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const AnasayfaPage()),
                      (route) => false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(2, context),
    );
  }

  // Üst bar
  Widget _buildTopBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.add, color: Colors.white, size: 22),
          ),
          const Column(
            children: [
              Text("Merkezi Hekim", style: TextStyle(fontSize: 13, color: Colors.black54)),
              Text("Randevu Sistemi", style: TextStyle(fontSize: 13, color: red, fontWeight: FontWeight.w700)),
            ],
          ),
          const Icon(Icons.notifications_outlined, color: green, size: 26),
        ],
      ),
    );
  }

  // Tıklanabilir menü kartı
  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: iconColor),
              const SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
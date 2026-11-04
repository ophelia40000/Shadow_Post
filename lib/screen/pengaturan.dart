import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/globals.dart' as globals;
import 'package:flutter_application_1/screen/login_screen.dart';
import 'package:flutter_application_1/widgets/safe_image.dart';

class Pengaturan extends StatefulWidget {
  const Pengaturan({super.key});

  @override
  State<Pengaturan> createState() => _PengaturanState();
}

class _PengaturanState extends State<Pengaturan> {
  bool _notifikasiAktif = true;
  bool _modePrivasi = false;

  void _showInfoDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B1C22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF272932), width: 1),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            content,
            style: const TextStyle(
              color: Color(0xFFC0C4CC),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Tutup",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      globals.uid = "";
      globals.nama = "";
      globals.chat_room = "";
    } catch (_) {}

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1B1C22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF272932), width: 1),
          ),
          title: const Text(
            "Keluar dari Akun?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Anda yakin ingin mengakhiri sesi ini? Anda perlu login kembali untuk mengakses postingan dan pesan.",
            style: TextStyle(
              color: Color(0xFF7A7E85),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Batal",
                style: TextStyle(
                  color: Color(0xFF7A7E85),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _logout();
              },
              child: const Text(
                "Keluar",
                style: TextStyle(
                  color: Color(0xFFD32F2F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = user?.email ?? "user@shadowpost.com";
    final nama = globals.nama.isNotEmpty ? globals.nama : "User";

    return Scaffold(
      backgroundColor: const Color(0xFF0F1015),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1015),
        elevation: 0,
        toolbarHeight: 64,
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFF272932),
            width: 1,
          ),
        ),
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          alignment: Alignment.center,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1B1C22),
                border: Border.all(
                  color: const Color(0xFF272932),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFFC0C4CC),
                size: 20,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          "Pengaturan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.2,
          ),
        ),
      ),
      body: Stack(
        children: [
          // ── Ambient Glow (selaras dengan beranda & login) ──
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0x8C262038),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                // ── Profil Card ──
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1B1C22),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFF272932),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF272932),
                            width: 1.5,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: SafeNetworkImage(
                            imageUrl: globals.url,
                            fit: BoxFit.cover,
                            cacheWidth: 100,
                            cacheHeight: 100,
                            fallbackWidget: const Icon(
                              Icons.person,
                              color: Colors.white70,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              nama,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              email,
                              style: const TextStyle(
                                color: Color(0xFF7A7E85),
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF16171C),
                          border: Border.all(
                            color: const Color(0xFF272932),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF7A7E85),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // ── Section: Akun ──
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Text(
                    "Akun",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _buildCardGroup([
                  _buildTile(
                    icon: Icons.person_outline_rounded,
                    title: "Edit Profil",
                    subtitle: "Nama, foto profil, dan bio",
                    onTap: () => _showInfoDialog("Edit Profil",
                        "Fitur ubah profil tersedia di pembaruan berikutnya."),
                  ),
                  _buildDivider(),
                  _buildTile(
                    icon: Icons.key_outlined,
                    title: "Ganti Kata Sandi",
                    subtitle: "Perbarui keamanan akun Anda",
                    onTap: () => _showInfoDialog("Ganti Kata Sandi",
                        "Silakan hubungi administrator untuk mereset kata sandi."),
                  ),
                ]),

                const SizedBox(height: 14),

                // ── Section: Preferensi ──
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Text(
                    "Preferensi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _buildCardGroup([
                  SwitchListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    secondary:
                        _buildIconCircle(Icons.notifications_none_rounded),
                    title: const Text(
                      "Pemberitahuan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      "Notifikasi pesan dan aktivitas",
                      style: TextStyle(color: Color(0xFF7A7E85), fontSize: 12),
                    ),
                    value: _notifikasiAktif,
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFF383B48),
                    onChanged: (val) => setState(() => _notifikasiAktif = val),
                  ),
                  _buildDivider(),
                  SwitchListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    secondary: _buildIconCircle(Icons.visibility_off_outlined),
                    title: const Text(
                      "Mode Samaran",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      "Sembunyikan status aktif online",
                      style: TextStyle(color: Color(0xFF7A7E85), fontSize: 12),
                    ),
                    value: _modePrivasi,
                    activeThumbColor: Colors.white,
                    activeTrackColor: const Color(0xFF383B48),
                    onChanged: (val) => setState(() => _modePrivasi = val),
                  ),
                  _buildDivider(),
                  _buildTile(
                    icon: Icons.dark_mode_outlined,
                    title: "Tema Tampilan",
                    subtitle: "Gelap (Bawaan sistem)",
                    onTap: () => _showInfoDialog("Tema Tampilan",
                        "Shadow Post dioptimalkan khusus untuk tema gelap (dark mode)."),
                  ),
                ]),

                const SizedBox(height: 14),

                // ── Section: Informasi & Bantuan ──
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                  child: Text(
                    "Informasi & Bantuan",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                _buildCardGroup([
                  _buildTile(
                    icon: Icons.info_outline_rounded,
                    title: "Tentang Shadow Post",
                    subtitle: "Versi 1.0.0 • Tim Dev_eloping Infants",
                    onTap: () => _showInfoDialog(
                      "Tentang Shadow Post",
                      "Shadow Post v1.0.0\nProyek UAS Software Development\n\nTim Pengembang (Dev_eloping Infants):\n• Muhammad Raffi Hermawan (535220259)\n• Jason Wiedardi Limtara (535220212)\n• Wilson Alfando (535220219)\n• Christ Thaddeus (535220196)",
                    ),
                  ),
                  _buildDivider(),
                  _buildTile(
                    icon: Icons.shield_outlined,
                    title: "Kebijakan Privasi",
                    subtitle: "Perlindungan data dan akun Anda",
                    onTap: () => _showInfoDialog(
                      "Kebijakan Privasi",
                      "Data profil dan postingan Anda disimpan secara aman di cloud database. Pesan obrolan hanya dapat dibaca oleh partisipan yang terlibat dalam ruang pesan tersebut.",
                    ),
                  ),
                ]),

                const SizedBox(height: 14),

                // ── Section: Sesi ──
                _buildCardGroup([
                  ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    leading: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF16171C),
                        border: Border.all(
                          color: const Color(0xFFD32F2F).withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: Color(0xFFD32F2F),
                        size: 18,
                      ),
                    ),
                    title: const Text(
                      "Keluar dari Akun",
                      style: TextStyle(
                        color: Color(0xFFD32F2F),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: const Text(
                      "Akhiri sesi login pada perangkat ini",
                      style: TextStyle(
                        color: Color(0xFF7A7E85),
                        fontSize: 12,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      color: Color(0xFF7A7E85),
                      size: 20,
                    ),
                    onTap: _confirmLogout,
                  ),
                ]),

                const SizedBox(height: 28),
                const Center(
                  child: Text(
                    "Shadow Post • Dev_eloping Infants",
                    style: TextStyle(
                      color: Color(0xFF7A7E85),
                      fontSize: 12,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFF272932),
          width: 1,
        ),
      ),
      child: Material(
        color: const Color(0xFF1B1C22),
        borderRadius: BorderRadius.circular(18),
        clipBehavior: Clip.antiAlias,
        child: Column(children: children),
      ),
    );
  }

  Widget _buildIconCircle(IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF16171C),
        border: Border.all(
          color: const Color(0xFF272932),
          width: 1,
        ),
      ),
      child: Icon(
        icon,
        color: const Color(0xFFC0C4CC),
        size: 18,
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      leading: _buildIconCircle(icon),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF7A7E85),
          fontSize: 12,
        ),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Color(0xFF7A7E85),
        size: 20,
      ),
      onTap: onTap,
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Color(0xFF272932),
      indent: 58,
    );
  }
}

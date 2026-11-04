import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screen/splash_screen.dart';
import 'package:flutter_application_1/screen/login_screen.dart';
import 'package:flutter_application_1/screen/home_screen.dart';
import 'package:flutter_application_1/screen/post_screen.dart';
import 'package:flutter_application_1/screen/pengaturan.dart';
import 'package:flutter_application_1/screen/globals.dart' as globals;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCKRRFyUF4s2Uc5KOHRj1W6ylqIc5UlNz0",
        appId: "1:1009608363850:web:twitter_web",
        messagingSenderId: "1009608363850",
        projectId: "twitter-3ec97",
        storageBucket: "twitter-3ec97.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  await Future.delayed(const Duration(seconds: 0));
  if (!kIsWeb) {
    try {
      FlutterNativeSplash.remove();
    } catch (e) {
      // Ignore
    }
  }
  runApp(const MyApp());
}

class PhoneFrame extends StatelessWidget {
  final Widget child;

  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const statusColor = Colors.white;

    return Center(
      child: Container(
        width: 414,
        height: 896,
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: const Color(0xFF101216),
          borderRadius: BorderRadius.circular(54.0),
          border: Border.all(color: const Color(0xFF2C2F36), width: 4.0),
          boxShadow: const [
            BoxShadow(
              color: Color(0x8C000000),
              blurRadius: 28,
              offset: Offset(0, 14),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(44.0),
          child: Container(
            color: const Color(0xFF0F1015),
            child: Stack(
              children: [
                Positioned.fill(
                  child: MediaQuery(
                    data: const MediaQueryData(
                      size: Size(390, 844),
                      padding: EdgeInsets.only(top: 50, bottom: 28),
                      viewPadding: EdgeInsets.only(top: 50, bottom: 28),
                    ),
                    child: child,
                  ),
                ),

                // Status Bar Top Overlay
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 26.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          '20.37',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                            color: statusColor,
                            letterSpacing: -0.2,
                          ),
                        ),
                        Container(
                          width: 112,
                          height: 29,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 9),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0F172A),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(width: 3, height: 4, color: statusColor),
                                const SizedBox(width: 1.5),
                                Container(width: 3, height: 6.5, color: statusColor),
                                const SizedBox(width: 1.5),
                                Container(width: 3, height: 9, color: statusColor),
                                const SizedBox(width: 1.5),
                                Container(width: 3, height: 11.5, color: statusColor),
                              ],
                            ),
                            const SizedBox(width: 5),
                            const Icon(Icons.wifi, size: 15.5, color: statusColor),
                            const SizedBox(width: 5),
                            Container(
                              width: 22,
                              height: 11.5,
                              padding: const EdgeInsets.all(1.5),
                              decoration: BoxDecoration(
                                border: Border.all(color: statusColor, width: 1.2),
                                borderRadius: BorderRadius.circular(3.5),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: statusColor,
                                  borderRadius: BorderRadius.circular(1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Home Indicator Bar at the bottom
                Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 135,
                      height: 4.5,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget home = const SplashScreen();

    if (kIsWeb) {
      final screen = Uri.base.queryParameters['screen'];
      if (screen == 'login') {
        home = const LoginScreen();
      } else if (screen == 'beranda') {
        if (globals.nama.isEmpty) globals.nama = 'Muhammad Raffi';
        home = const BottomNavBar();
      } else if (screen == 'post') {
        home = const PostScreen();
      } else if (screen == 'pengaturan') {
        if (globals.nama.isEmpty) globals.nama = 'Muhammad Raffi';
        home = const Pengaturan();
      }

      if (Uri.base.queryParameters['frame'] == 'true') {
        home = Scaffold(
          backgroundColor: Colors.transparent,
          body: PhoneFrame(child: home),
        );
      }
    }

    return MaterialApp(
      title: 'Shadow Post',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F1015),
        canvasColor: const Color(0xFF0F1015),
        cardColor: const Color(0xFF1B1C22),
        dividerColor: const Color(0xFF272932),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8F94FB),
          surface: Color(0xFF1B1C22),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F1015),
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: home,
    );
  }
}

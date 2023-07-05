import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practical/module/auth/login.view.dart';
import 'package:practical/module/main/home_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Training',
        theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.grey.shade200,
          textTheme: TextTheme(
            titleLarge:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16),
            titleMedium:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 24),
            titleSmall:
                GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 16),
            bodySmall:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 12),
            bodyMedium:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 18),
            displayLarge:
                GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 34),
            displaySmall:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
            displayMedium:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              backgroundColor: Colors.green, // background (button) color
              foregroundColor: Colors.white, // foreground (text) color
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const Login();
            }
          },
        ));
  }
}

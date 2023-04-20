import 'package:flutter/material.dart';
import 'package:mutu/registerandlogin/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mutu/firebase_options.dart';

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Login(),
        theme: ThemeData(
            primaryColor: const Color(0xFFFAD6A5),
            scaffoldBackgroundColor: const Color(0xFF567189),
            textTheme: TextTheme(
                headlineLarge: GoogleFonts.andika(
                  textStyle: const TextStyle(
                    color: Color(0xFFFAD6A5),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                headlineMedium: GoogleFonts.andika(
                  textStyle: const TextStyle(
                    color: Color(0xFFFAD6A5),
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                headlineSmall: GoogleFonts.andika(
                  textStyle: const TextStyle(
                    color: Color(0xFFFAD6A5),
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                )),
            iconTheme: const IconThemeData(color: Color(0xFF344D67)),
            
            inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: const Color(0xFF7B8FA1),
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFCFB997)),
                    borderRadius: BorderRadius.circular(10)),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFFCFB997)),
                    borderRadius: BorderRadius.circular(15))))),
  );
}

import 'package:flutter/material.dart';
import 'sales_page.dart'; // Importe a sua página principal

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove aquela etiqueta de "Debug"
      title: 'Brazilian Beauty Code',
      theme: ThemeData(
        brightness: Brightness.dark, // Define o tema escuro como base
        scaffoldBackgroundColor: const Color(0xFF09090B), // Cor de fundo global
        fontFamily: 'Arial', // Ou a fonte que você estiver usando
      ),
      home: SalesPage(), // <-- AQUI É ONDE A MÁGICA ACONTECE
    );
  }
}
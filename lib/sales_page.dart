import 'package:flutter/material.dart';
import 'responsive.dart';
import 'sales_navbar.dart';
import 'sales_hero_section.dart';
import 'sales_bottom_section.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF09090B), // Cor de fundo principal
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 1. MENU SUPERIOR
              const SalesNavbar(),

              // 2. HERO SECTION (A dobra com a foto e o título)
              const SalesHeroSection(),

              // 3. FAIXA "AS SEEN IN" (Logos das revistas)
              // ATENÇÃO: mantida desativada de propósito. Exibir logos de veículos
              // como Vogue, Elle ou Cosmopolitan implica que o produto foi
              // citado por eles. Se isso não for verdade, é propaganda enganosa
              // e pode gerar problema legal (nos EUA, isso cai sob regras da FTC
              // sobre "endorsements" falsos). Só reative se o produto tiver sido
              // genuinamente mencionado por esses veículos.
              // _buildAsSeenInBanner(),

              // 4. CONTEÚDO INFERIOR (Cards, FAQ, Preço)
              const SalesBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget da faixa branca com as marcas
  Widget _buildAsSeenInBanner() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF3EFE9),
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 40,
        runSpacing: 20,
        children: [
          const Text(
            "AS SEEN IN",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
              fontSize: 12,
            ),
          ),
          _logoText("VOGUE"),
          _logoText("ELLE"),
          _logoText("allure"),
          _logoText("COSMOPOLITAN"),
          _logoText("GLAMOUR"),
        ],
      ),
    );
  }

  Widget _logoText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w900,
        fontSize: 22,
        fontFamily: 'Times New Roman', // Simula fonte serifada de revista
        letterSpacing: 1.2,
      ),
    );
  }
}
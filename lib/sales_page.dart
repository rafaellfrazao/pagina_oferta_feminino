import 'package:flutter/material.dart';
import 'responsive.dart';
import 'sales_navbar.dart';
import 'sales_hero_section.dart';
import 'sales_bottom_section.dart';
import 'meta_pixel_helper.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  void initState() {
    super.initState();

    // Aguarda a página ser carregada antes de disparar o evento.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MetaPixelHelper.trackViewContent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF09090B),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 1. MENU SUPERIOR
              const SalesNavbar(),

              // 2. HERO SECTION
              const SalesHeroSection(),

              // 3. FAIXA "AS SEEN IN"
              // Desativada de propósito.
              // Só deve ser ativada se essas publicações realmente
              // tiverem mencionado o produto.
              // _buildAsSeenInBanner(),

              // 4. CONTEÚDO INFERIOR
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
      padding: const EdgeInsets.symmetric(
        vertical: 24,
        horizontal: 16,
      ),
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
        fontFamily: 'Times New Roman',
        letterSpacing: 1.2,
      ),
    );
  }
}

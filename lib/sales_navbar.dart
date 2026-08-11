import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'responsive.dart'; // Importando a sua classe de responsividade
import 'meta_pixel_helper.dart';

class SalesNavbar extends StatelessWidget {
  const SalesNavbar({Key? key}) : super(key: key);

  // Método auxiliar para abrir o link de checkout
  Future<void> _launchCheckout() async {
    MetaPixelHelper.trackInitiateCheckout();
    final Uri url = Uri.parse('https://pay.hotmart.com/Y107092223A?off=h7ia16qz');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // LÓGICA SEGURA: Esconde os links do menu em telas menores que 950px (Mobile e Tablets)
    final bool hideNavLinks = isMobile || screenWidth < 950;

    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.black, // Fundo preto da barra superior
      padding: EdgeInsets.symmetric(horizontal: hideNavLinks ? 16.0 : 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. LOGO (Envolta em Flexible para evitar estouro em telas minúsculas)
          Flexible(child: _buildLogo()),

          // 2. LINKS DO CENTRO (Escondidos no mobile/tablet para não quebrar a tela)
          if (!hideNavLinks) _buildNavLinks(),

          // 3. BOTÃO DE AÇÃO
          _buildCtaButton(hideNavLinks),
        ],
      ),
    );
  }

  // Constrói a Logo semelhante à imagem
  Widget _buildLogo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Flexible(
              child: Text(
                "BRAZILIAN",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            SizedBox(width: 4),
            Icon(Icons.auto_awesome, color: Color(0xFFFFC636), size: 16), // Estrelinha dourada
          ],
        ),
        const Text(
          "BEAUTY CODE",
          style: TextStyle(
            color: Color(0xFFC778B5), // Tom rosa/roxo parecido com a imagem
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  // Constrói os links do centro
  Widget _buildNavLinks() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _navItem("What You'll Get"),
        _navItem("Modules"),
        _navItem("Bonus"),
        _navItem("Testimonials"),
        _navItem("FAQ"),
      ],
    );
  }

  // Widget auxiliar para cada link do menu
  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  // Constrói o botão amarelo da direita
  Widget _buildCtaButton(bool hideNavLinks) {
    return ElevatedButton(
      onPressed: _launchCheckout,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFC636), // Amarelo/Dourado
        foregroundColor: Colors.black, // Texto preto
        padding: EdgeInsets.symmetric(
          horizontal: hideNavLinks ? 12 : 24,
          vertical: 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4), // Borda levemente arredondada
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // FittedBox garante que o texto do botão reduza o tamanho se precisar, sem dar erro de pixel
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              hideNavLinks ? "GET ACCESS" : "GET INSTANT ACCESS",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Icon(Icons.arrow_forward, size: 14),
        ],
      ),
    );
  }
}
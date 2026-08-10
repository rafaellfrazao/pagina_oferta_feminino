import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'responsive.dart';

class SalesHeroSection extends StatelessWidget {
  const SalesHeroSection({Key? key}) : super(key: key);

  // Método auxiliar para abrir o link de checkout
  Future<void> _launchCheckout() async {
    final Uri url = Uri.parse('https://pay.hotmart.com/Y107092223A?off=h7ia16qz');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // LÓGICA DE RESPONSIVIDADE
    // forceColumn: Telas menores que 900px (Mobile e Tablets em pé como 768px)
    final bool forceColumn = isMobile || screenWidth < 900;
    
    // isLaptop: Telas médias (ex: 1024px até 1200px)
    final bool isLaptop = screenWidth >= 900 && screenWidth < 1200;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: forceColumn ? 800 : 850,
      ),
      color: const Color(0xFF09090B),
      child: Stack(
        children: [
          // 1. IMAGEM DE FUNDO COM GRADIENTE ESCURO
          Positioned.fill(
            child: Row(
              children: [
                // CORREÇÃO: Removido o flex: 0 que causava erro no Tablet. 
                // Se for forceColumn, simplesmente não renderizamos o container vazio.
                if (!forceColumn)
                  Expanded(
                    flex: 1,
                    child: Container(color: const Color(0xFF09090B)),
                  ),
                
                Expanded(
                  // Se for coluna (tablet/mobile), a imagem toma 100% do espaço (flex 1 único)
                  flex: forceColumn ? 1 : 2, 
                  child: forceColumn
                      ? const _HeroImage(isDesktop: false)
                      : Align(
                          alignment: Alignment.centerRight,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: isLaptop ? 450 : 550),
                            child: const SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: _HeroImage(isDesktop: true),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          
          // Gradiente por cima da imagem
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF09090B),
                    const Color(0xFF09090B).withOpacity(forceColumn ? 0.85 : 0.95),
                    const Color(0xFF09090B).withOpacity(forceColumn ? 0.6 : 0.4),
                    Colors.transparent,
                  ],
                  stops: forceColumn 
                    ? const [0.0, 0.4, 0.7, 1.0] 
                    : const [0.0, 0.5, 0.8, 1.0],
                ),
              ),
            ),
          ),

          // 2. CONTEÚDO PRINCIPAL
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: forceColumn ? 24.0 : (isLaptop ? 32.0 : 60.0),
              vertical: forceColumn ? 48.0 : 60.0,
            ),
            child: forceColumn
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLeftContent(forceColumn, isLaptop),
                      const SizedBox(height: 48),
                      _buildRightFeatures(forceColumn),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: _buildLeftContent(forceColumn, isLaptop)),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: _buildRightFeatures(forceColumn),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftContent(bool forceColumn, bool isLaptop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: const [
            Text("🇧🇷 ", style: TextStyle(fontSize: 16)),
            // CORREÇÃO: Flexible impede que esse texto quebre a tela em celulares finos
            Flexible(
              child: Text(
                "30 BRAZILIAN BODY CARE RECIPES",
                style: TextStyle(
                  color: Color(0xFFFFC636),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: forceColumn ? 36 : (isLaptop ? 42 : 56),
              fontWeight: FontWeight.w900,
              fontFamily: 'Arial',
              height: 1.0,
            ),
            children: const [
              TextSpan(text: "UNLOCK YOUR MOST\n", style: TextStyle(color: Colors.white)),
              TextSpan(text: "RADIANT, CONFIDENT ", style: TextStyle(color: Color(0xFFFFC636))),
              TextSpan(text: "SKIN", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        const SizedBox(height: 20),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Text(
            "30 real Brazilian body care recipes, organized into 4 easy step-by-step modules — using simple ingredients you likely already have at home.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: isLaptop ? 15 : 16,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Wrap(
            spacing: 20,
            runSpacing: 12,
            children: [
              _buildCheckItem("30 Real Brazilian Recipes"),
              _buildCheckItem("4 Step-by-Step Modules"),
              _buildCheckItem("Works On Any Device"),
              _buildCheckItem("Natural & Affordable Ingredients"),
              _buildCheckItem("Real Results That Last"),
              _buildCheckItem("7-Day Money-Back Guarantee"),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // CORREÇÃO: Transformado em Wrap. No Tablet com espaço, o botão 
        // e o badge ficam lado a lado. Se apertar, descem organizados.
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 24,
          runSpacing: 16,
          children: [
            _buildMainCTA(),
            _buildGuaranteeBadge(),
          ],
        ),

        const SizedBox(height: 32),

        _buildSocialProof(),
      ],
    );
  }

  // Lado Direito: Os 4 cards escuros com ícones
  Widget _buildRightFeatures(bool forceColumn) {
    // CORREÇÃO: No modo "coluna" (Tablet/Mobile), em vez de esticar uma Column, 
    // usamos Wrap! Isso cria um belo grid 2x2 no Tablet, e 1x4 no Mobile, 
    // sem estourar limites de pixels.
    if (forceColumn) {
      return Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          _buildFeatureCard(Icons.menu_book, "30 Recipes", "Simple & Effective"),
          _buildFeatureCard(Icons.view_module, "4 Modules", "Clear Step-by-Step Path"),
          _buildFeatureCard(Icons.devices, "Any Device", "PC, Mobile & Tablet"),
          _buildFeatureCard(Icons.lock_outline, "Lifetime Access", "Yours Forever"),
        ],
      );
    }
    
    // No PC (largo o suficiente), os cards continuam em uma coluna alinhada à direita
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildFeatureCard(Icons.menu_book, "30 Recipes", "Simple & Effective"),
        _buildFeatureCard(Icons.view_module, "4 Modules", "Clear Step-by-Step Path"),
        _buildFeatureCard(Icons.devices, "Any Device", "PC, Mobile & Tablet"),
        _buildFeatureCard(Icons.lock_outline, "Lifetime Access", "Yours Forever"),
      ],
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _buildCheckItem(String text) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFFFC636), size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildMainCTA() {
    return ElevatedButton(
      onPressed: _launchCheckout, // <-- Chamando a função de redirecionamento aqui
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFC636),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      child: const Text(
        "YES! I WANT MY GLOW UP NOW →",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 15,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildGuaranteeBadge() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.shield_outlined, color: Color(0xFFFFC636), size: 36),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text(
              "7-Day Money-Back Guarantee", 
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              "Risk-Free. Cancel anytime.", 
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildSocialProof() {
    return Row(
      children: [
        SizedBox(
          width: 100,
          height: 32,
          child: Stack(
            children: [
              Positioned(left: 0, child: _avatar('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80')),
              Positioned(left: 20, child: _avatar('https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=200&q=80')),
              Positioned(left: 40, child: _avatar('https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80')),
              Positioned(left: 60, child: _avatar('https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=200&q=80')),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: List.generate(5, (index) => const Icon(Icons.star, color: Color(0xFFFFC636), size: 14)),
              ),
              const Text(
                "Join 1,000+ women who are transforming\ntheir skin with the Brazilian Beauty Code.",
                style: TextStyle(color: Colors.white70, fontSize: 11),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _avatar(String url) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF09090B), width: 2),
      ),
      child: CircleAvatar(
        radius: 16,
        backgroundImage: NetworkImage(url),
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle) {
    return Container(
      // CORREÇÃO: Agora o card tem uma largura base de 250 (em vez de usar ConstrainedBox).
      // Isso permite que o Wrap agrupe eles perfeitamente na tela.
      width: 250, 
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFC636).withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFFC636), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Color(0xFFFFC636), fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  final bool isDesktop;
  const _HeroImage({this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const NetworkImage(
              'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?q=80&w=1000&auto=format&fit=crop'),
          fit: BoxFit.cover,
          alignment: isDesktop ? const Alignment(0.0, -0.2) : Alignment.topCenter,
        ),
      ),
    );
  }
}
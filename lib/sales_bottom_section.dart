import 'package:flutter/material.dart';
import 'responsive.dart';

class SalesBottomSection extends StatelessWidget {
  const SalesBottomSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final screenWidth = MediaQuery.of(context).size.width;

    // LÓGICA DE RESPONSIVIDADE SEGURA
    // forceColumn: Garante que tablets menores que 950px fiquem empilhados (sem espremer os cards)
    final bool forceColumn = isMobile || screenWidth < 950;

    return Container(
      width: double.infinity,
      color: const Color(0xFF09090B),
      padding: EdgeInsets.symmetric(
        horizontal: forceColumn ? 24.0 : 40.0,
        vertical: 60.0,
      ),
      child: Column(
        children: [
          // 1. SEÇÃO "WHAT YOU'LL GET"
          _buildSectionHeader("WHAT YOU'LL GET"),
          const SizedBox(height: 32),
          _buildWhatYouGetGrid(forceColumn),
          const SizedBox(height: 60),

          // 2. CONTEÚDO PRINCIPAL (Depoimentos + FAQ na esquerda, Preço na direita)
          if (forceColumn)
            Column(
              children: [
                _buildPricingCard(forceColumn), // No mobile/tablet, o preço vem antes
                const SizedBox(height: 48),
                _buildTestimonialsSection(),
                const SizedBox(height: 48),
                _buildFAQSection(),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 7,
                  child: Column(
                    children: [
                      _buildTestimonialsSection(),
                      const SizedBox(height: 60),
                      _buildFAQSection(),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  flex: 5, // Aumentei um pouco o flex do preço pro desktop ficar mais harmonioso
                  child: _buildPricingCard(forceColumn),
                ),
              ],
            ),

          const SizedBox(height: 80),

          // 3. BANNER INFERIOR DE URGÊNCIA (Cronômetro)
          _buildUrgencyBanner(forceColumn),
        ],
      ),
    );
  }

  // --- COMPONENTES AUXILIARES ---

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 30, height: 1, color: const Color(0xFFFFC636).withOpacity(0.5)),
        const SizedBox(width: 12),
        // CORREÇÃO: Flexible impede que títulos muito grandes quebrem telas pequenas
        Flexible(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(width: 30, height: 1, color: const Color(0xFFFFC636).withOpacity(0.5)),
      ],
    );
  }

  Widget _buildWhatYouGetGrid(bool forceColumn) {
    final items = [
      {"icon": Icons.menu_book, "title": "30 BRAZILIAN RECIPES", "desc": "Simple, real recipes using ingredients you likely already have."},
      {"icon": Icons.view_module, "title": "4 COMPLETE MODULES", "desc": "A clear step-by-step path from skin basics to full body glow."},
      {"icon": Icons.devices, "title": "WORKS ON ANY DEVICE", "desc": "Access your program from your phone, tablet, or computer."},
      {"icon": Icons.card_giftcard, "title": "BONUS CONTENT", "desc": "Extra tips and rituals to take your results further."},
      {"icon": Icons.all_inclusive, "title": "LIFETIME ACCESS", "desc": "Watch anytime, anywhere, forever."},
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: items.map((item) {
        return Container(
          // CORREÇÃO: Largura dinâmica suave para alinhar o Grid perfeitamente
          width: forceColumn ? double.infinity : 220, 
          constraints: const BoxConstraints(maxWidth: 350), // Evita esticar demais no mobile
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF141416),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(
            children: [
              Icon(item["icon"] as IconData, color: const Color(0xFFFFC636), size: 40),
              const SizedBox(height: 16),
              Text(
                item["title"] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              const SizedBox(height: 8),
              Text(
                item["desc"] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTestimonialsSection() {
    return Column(
      children: [
        _buildSectionHeader("REAL RESULTS FROM REAL WOMEN"),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            _buildReviewCard(
              "Sarah M.",
              "https://i.pravatar.cc/100?img=5",
              "The coffee and coconut scrub from Module 2 alone was worth it. My skin has never felt this soft.",
            ),
            _buildReviewCard(
              "Jessica L.",
              "https://i.pravatar.cc/100?img=9",
              "I love that every recipe uses stuff I already had at home. So simple, but so effective!",
            ),
            _buildReviewCard(
              "Amanda R.",
              "https://i.pravatar.cc/100?img=12",
              "I'm on Module 3 now and I'm already glowing. Easy to follow and genuinely fun to do.",
            ),
          ],
        )
      ],
    );
  }

  Widget _buildReviewCard(String name, String avatar, String text) {
    return Container(
      width: 240,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: List.generate(5, (index) => const Icon(Icons.star, color: Color(0xFFFFC636), size: 16))),
          const SizedBox(height: 16),
          Text(
            '"$text"',
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              CircleAvatar(radius: 12, backgroundImage: NetworkImage(avatar)),
              const SizedBox(width: 8),
              Flexible(child: Text(name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    final faqs = [
      {
        "q": "How do I get access?",
        "a": "Right after your purchase is confirmed, you'll get an email with your login link. Just click it to access the program instantly on our website — no app download needed.",
      },
      {
        "q": "How long do I have access?",
        "a": "Forever. Once you're in, you have lifetime access to all 4 modules, your progress, and any future bonus content, on any device.",
      },
      {
        "q": "Is there a refund policy?",
        "a": "Yes. If you're not satisfied for any reason, you have 30 days from your purchase date to request a full refund, no questions asked.",
      },
      {
        "q": "Is this a physical product?",
        "a": "No, nothing is shipped to you. This is a fully digital program hosted on our website, so you can start using it instantly on your phone, tablet, or computer.",
      },
      {
        "q": "Do I need to watch things in order?",
        "a": "We recommend following Modules 1 through 4 in order the first time through, since each one builds on the last. After that, you can revisit any recipe or lesson whenever you like.",
      },
    ];

    return Column(
      children: [
        _buildSectionHeader("FREQUENTLY ASKED QUESTIONS"),
        const SizedBox(height: 24),
        ...faqs.map((faq) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(
              collapsedBackgroundColor: const Color(0xFF141416),
              backgroundColor: const Color(0xFF1A1A1E),
              iconColor: Colors.white54,
              collapsedIconColor: Colors.white54,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              title: Text(faq["q"]!, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    faq["a"]!,
                    style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13, height: 1.5),
                  ),
                )
              ],
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildPricingCard(bool forceColumn) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFFC636).withOpacity(0.3), width: 2),
      ),
      child: Column(
        children: [
          const Text("SPECIAL LIMITED OFFER", textAlign: TextAlign.center, style: TextStyle(color: Color(0xFFFFC636), fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
          const SizedBox(height: 8),
          const Text("GET INSTANT ACCESS NOW", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text("\$19", style: TextStyle(color: Color(0xFFFFC636), fontSize: 56, fontWeight: FontWeight.w900, height: 1.0)),
              SizedBox(width: 12),
              Text(
                "\$39",
                style: TextStyle(color: Colors.white54, fontSize: 24, fontWeight: FontWeight.bold, decoration: TextDecoration.lineThrough, decorationColor: Colors.red, decorationThickness: 2),
              ),
            ],
          ),
          const SizedBox(height: 32),
          _buildCheckItem("Full Access to All 4 Modules"),
          _buildCheckItem("30 Step-by-Step Brazilian Recipes"),
          _buildCheckItem("Lifetime Access, Any Device"),
          _buildCheckItem("30-Day Money-Back Guarantee"),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC636),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
              ),
              // CORREÇÃO: FittedBox no botão garante que o texto não corte em celulares pequenos
              child: const FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("GET INSTANT ACCESS →", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.lock_outline, color: Colors.white54, size: 14),
              SizedBox(width: 8),
              Flexible(child: Text("Secure Checkout - One Time Payment", textAlign: TextAlign.center, style: TextStyle(color: Colors.white54, fontSize: 12))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCheckItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          const Icon(Icons.check, color: Color(0xFFFFC636), size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 14))),
        ],
      ),
    );
  }

  Widget _buildUrgencyBanner(bool forceColumn) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: forceColumn ? 16 : 40, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(0xFF141416),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      // CORREÇÃO: Transformado de Flex para Wrap! 
      // Agora os elementos se posicionam inteligentemente sem NUNCA dar erro de pixel.
      child: Wrap(
        alignment: WrapAlignment.spaceEvenly,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 24,
        runSpacing: 32,
        children: [
          // 1. Textos
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              crossAxisAlignment: forceColumn ? CrossAxisAlignment.center : CrossAxisAlignment.start,
              children: [
                Text(
                  "DON'T MISS OUT ON YOUR BEST VERSION", 
                  textAlign: forceColumn ? TextAlign.center : TextAlign.left,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)
                ),
                const SizedBox(height: 8),
                Text(
                  "Join thousands of women who already transformed their skin.", 
                  textAlign: forceColumn ? TextAlign.center : TextAlign.left,
                  style: const TextStyle(color: Colors.white54, fontSize: 13)
                ),
              ],
            ),
          ),
          
          // 2. Cronômetro
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildTimeBox("02", "DAYS"),
              _buildTimeBox("18", "HOURS"),
              _buildTimeBox("47", "MINUTES"),
              _buildTimeBox("35", "SECONDS"),
            ],
          ),
          
          // 3. Botão
          Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC636),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text("GET INSTANT ACCESS NOW →", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.lock_outline, color: Colors.white54, size: 12),
                  SizedBox(width: 4),
                  Text("30-Day Money-Back Guarantee", style: TextStyle(color: Colors.white54, fontSize: 11)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTimeBox(String number, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFFFC636).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(number, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Color(0xFFFFC636), fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
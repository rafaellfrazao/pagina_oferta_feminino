import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:url_launcher/url_launcher.dart';

// --- CLASSE RESPONSIVE (FORNECIDA) ---
class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 768 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double maxWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}

void main() {
  runApp(const SalesPageApp());
}

class SalesPageApp extends StatelessWidget {
  const SalesPageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Brazilian Beauty Code',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF08080A),
        primaryColor: Colors.amber,
      ),
      home: const SalesPageScreen(),
    );
  }
}

@JS('trackInitiateCheckout')
external void trackInitiateCheckout();

class SalesPageScreen extends StatefulWidget {
  const SalesPageScreen({super.key});

  @override
  State<SalesPageScreen> createState() => _SalesPageScreenState();
}

class _SalesPageScreenState extends State<SalesPageScreen> {
  Future<void> _openCheckout() async {
    // Meta Pixel
    trackInitiateCheckout();

    final url = Uri.parse('https://pay.hotmart.com/I107051915O');

    await launchUrl(url, mode: LaunchMode.platformDefault);
  }

  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();

    _youtubeController = YoutubePlayerController.fromVideoId(
      videoId: 'stzhnefC2ws',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        showVideoAnnotations: false,
        strictRelatedVideos: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return SelectionArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0D0D0E),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // BARRA DE URGÊNCIA NO TOPO
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 8 : 10,
                  horizontal: isMobile ? 10 : 16,
                ),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFFF8C00), Color(0xFFFF0000)],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.timer_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "🔥 ONLY TODAY: PRICE INCREASES TO \$39 TONIGHT AT MIDNIGHT",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: isMobile ? 10 : 12,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 960),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 32,
                      vertical: isMobile ? 16 : 24,
                    ),
                    child: Column(
                      children: [
                        // --- HERO SECTION ---
                        _buildBadge("🇧🇷 THE BRAZILIAN GLOW UP METHOD"),
                        const SizedBox(height: 16),
      
                        // HEADLINE COM FONTE RESPONSIVA (Sem cortar no Mobile)
                        Text(
                          "Get The Glow Brazilian Women Are Famous For.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 26 : 44,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            height: 1.15,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Discover the exact skin, shower ritual, and body-glow system Brazilian women use to get soft, hydrated, radiant skin — even if your routine right now is basically just soap and water.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 17,
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
      
                        // MOCKUP HERO
                        _buildHeroVisualMockup(context),
      
                        const SizedBox(height: 24),
      
                        // CTA #1
                        _buildCtaButton(
                          context: context,
                          label: "GET INSTANT ACCESS FOR \$12 👉",
                          subtext: "Regular Price \$39 • Instant Digital Access",
                        ),
      
                        const SizedBox(height: 16),
                        _buildQuickRatingBadge(context),
      
                        const SizedBox(height: 36),
                        const Divider(color: Colors.white12),
                        const SizedBox(height: 30),
      
                        // "IMAGINE IF..."
                        _buildImagineSection(context),
      
                        const SizedBox(height: 36),
      
                        // PAIN VS SOLUTION (Responsivo: Row no PC, Column no Mobile)
                        _buildPainVsSolutionSection(context),
      
                        const SizedBox(height: 36),
      
                        // SHOW THE PRODUCT
                        _buildMultiDevicePreview(context),
      
                        const SizedBox(height: 24),
      
                        // CTA #2
                        _buildCtaButton(
                          context: context,
                          label: "START YOUR GLOW UP FOR \$12",
                          subtext: "One-Time Payment • Lifetime Access",
                        ),
      
                        const SizedBox(height: 36),
      
                        // ESTATÍSTICAS
                        _buildStatisticsSection(context),
      
                        const SizedBox(height: 36),
      
                        // MÓDULOS
                        Text(
                          "Inside The Brazilian Glow Up",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isMobile ? 22 : 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "No theory. Just simple, real routines you can start tonight.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white60, fontSize: 13),
                        ),
                        const SizedBox(height: 20),
      
                        _buildModuleCard(
                          context: context,
                          icon: "🧴",
                          number: "MODULE 01",
                          title: "Brazilian Skin Fundamentals",
                          description:
                              "The exact cleansing and layered-hydration routine behind that 'always hydrated' Brazilian skin look — for every skin type.",
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: "🚿",
                          number: "MODULE 02",
                          title: "The Shower Ritual & Body Scrub",
                          description:
                              "Turn your shower into a real ritual: body exfoliation, layered hydration, and the timing trick that keeps skin soft for hours.",
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: "✨",
                          number: "MODULE 03",
                          title: "Natural Glow, Bronze & Body Contour",
                          description:
                              "Get that sun-kissed, photo-ready glow on legs, chest, and arms — no sunburn required, with body oils and simple highlighting tricks.",
                        ),
                        _buildModuleCard(
                          context: context,
                          icon: "🌙",
                          number: "MODULE 04",
                          title: "Maintenance & Everyday Lifestyle",
                          description:
                              "The small daily habits — hydration, sleep, sun care — that keep your glow consistent long after the first results show up.",
                        ),
      
                        const SizedBox(height: 36),
      
                        // CRONOGRAMA DE EVOLUÇÃO
                        _buildTimelineSection(context),
      
                        const SizedBox(height: 36),
      
                        // DEPOIMENTOS
                        _buildSocialProofSection(context),
      
                        const SizedBox(height: 24),
      
                        // CTA #3
                        _buildCtaButton(
                          context: context,
                          label: "CLAIM YOUR 69% DISCOUNT NOW",
                          subtext:
                              "Join 3,400+ Women Who Already Started Their Glow Up",
                        ),
      
                        const SizedBox(height: 36),
      
                        // BONUS BOX
                        _buildBonusSection(context),
      
                        const SizedBox(height: 36),
      
                        // CAIXA DE PREÇO & GARANTIA
                        _buildOfferPricingCard(context),
      
                        const SizedBox(height: 36),
      
                        // FAQ
                        _buildFaqSection(context),
      
                        const SizedBox(height: 36),
      
                        // CTA FINAL
                        _buildCtaButton(
                          context: context,
                          label: "YES! I WANT THE BRAZILIAN GLOW UP (\$12)",
                          subtext: "30-Day Money-Back Guarantee • 100% Secure",
                        ),
      
                        const SizedBox(height: 36),
      
                        // FOOTER
                        const Text(
                          "© 2026 The Brazilian Glow Up. All Rights Reserved.\nDisclaimer: This site is not a part of the Facebook website or Meta Inc.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white30,
                            fontSize: 11,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGETS RESPONSIVOS DA PÁGINA ---

  static Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.4)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.amber,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildHeroVisualMockup(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          width: 420,
          height: 740,
          child: YoutubePlayer(
            controller: _youtubeController,
            aspectRatio: 9 / 16,
          ),
        ),
      ),
    );
  }

  static Widget _buildQuickRatingBadge(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Wrap(
      alignment: WrapAlignment.center,

      spacing: 8,
      runSpacing: 4,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            5,
            (index) => const Icon(Icons.star, color: Colors.amber, size: 16),
          ),
        ),
        Text(
          "4.9/5 Rating (3,400+ Women Glowed Up)",
          style: TextStyle(
            color: Colors.white70,
            fontSize: isMobile ? 11 : 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  static Widget _buildImagineSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: const Color(0xFF121216),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Imagine If...",
            style: TextStyle(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.bold,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 14),
          _buildResultCheckItem(
            context,
            "Your skin looks hydrated and glowing without a full face of makeup.",
          ),
          _buildResultCheckItem(
            context,
            "People ask what skincare you use, or if you just got back from Brazil.",
          ),
          _buildResultCheckItem(
            context,
            "Your shower becomes a 15-minute ritual you actually look forward to.",
          ),
          _buildResultCheckItem(
            context,
            "Your legs and arms have that soft, smooth, bronzed glow in every photo.",
          ),
          _buildResultCheckItem(
            context,
            "You finally have a simple routine you'll actually stick to, no 10-step chaos.",
          ),
        ],
      ),
    );
  }

  static Widget _buildResultCheckItem(BuildContext context, String text) {
    final isMobile = Responsive.isMobile(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.amber, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: isMobile ? 13 : 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPainVsSolutionSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    Widget withoutBox = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.withOpacity(0.3)),
      ),
      child: Column(
        children: const [
          Text(
            "❌ WITHOUT IT",
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "• Dry, dull, tired-looking skin",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            "• Random products with no real routine",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            "• Never feeling ready to show your skin",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );

    Widget withBox = Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
      ),
      child: Column(
        children: const [
          Text(
            "✔ WITH THE GLOW UP",
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "• Soft, hydrated, radiant skin",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            "• A simple ritual you follow in minutes",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            "• Real confidence in shorts, swimsuits & photos",
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );

    return Column(
      children: [
        Text(
          "What Happens If You Keep Skipping Your Skin?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        // Se for Mobile empilha na vertical (Column), se for PC coloca lado a lado (Row)
        if (isMobile) ...[
          withoutBox,
          const SizedBox(height: 12),
          withBox,
        ] else ...[
          Row(
            children: [
              Expanded(child: withoutBox),
              const SizedBox(width: 12),
              Expanded(child: withBox),
            ],
          ),
        ],
      ],
    );
  }

  static Widget _buildMultiDevicePreview(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: const Color(0xFF101014),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Text(
            "Access Anywhere, On Any Device",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 17 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            "Instant digital dashboard optimized for iOS, Android & Web.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.laptop_mac_rounded,
                size: isMobile ? 38 : 50,
                color: Colors.amber,
              ),
              Icon(
                Icons.tablet_mac_rounded,
                size: isMobile ? 30 : 40,
                color: Colors.amber,
              ),
              Icon(
                Icons.phone_iphone_rounded,
                size: isMobile ? 24 : 30,
                color: Colors.amber,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildStatisticsSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        Text(
          "Average User Glow Up Results",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 18 : 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildStatBar("Skin Hydration & Softness", 0.94, "94% Increase"),
        _buildStatBar("Visible Glow & Radiance", 0.90, "90% Brighter"),
        _buildStatBar("Body Skin Smoothness", 0.88, "88% Improvement"),
        _buildStatBar("Confidence In Your Skin", 0.92, "92% Boost"),
      ],
    );
  }

  static Widget _buildStatBar(
    String label,
    double value,
    String percentageText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
              Text(
                percentageText,
                style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: value,
            backgroundColor: Colors.white10,
            color: Colors.amber,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }

  static Widget _buildModuleCard({
    required BuildContext context,
    required String icon,
    required String number,
    required String title,
    required String description,
  }) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(isMobile ? 14 : 18),
      decoration: BoxDecoration(
        color: const Color(0xFF121215),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: TextStyle(fontSize: isMobile ? 26 : 32)),
          SizedBox(width: isMobile ? 12 : 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    color: Colors.amber,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: isMobile ? 12 : 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildTimelineSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        Text(
          "Your 4-Week Glow Up Plan",
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildWeekStep(
          "WEEK 1",
          "Learn your skin type and build your daily facial cleansing routine.",
        ),
        _buildWeekStep(
          "WEEK 2",
          "Start your shower ritual: body exfoliation and layered hydration.",
        ),
        _buildWeekStep(
          "WEEK 3",
          "Add body oils and glow techniques for legs, chest & arms.",
        ),
        _buildWeekStep(
          "WEEK 4",
          "Your glow becomes visible & people start noticing the difference.",
        ),
      ],
    );
  }

  static Widget _buildWeekStep(String week, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              week,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildSocialProofSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        Text(
          "What Women Are Saying",
          style: TextStyle(
            fontSize: isMobile ? 20 : 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildTestimonialCard(
          "Ashley R. — Miami, FL",
          "\"My skin has never looked this hydrated. I get compliments almost every day now and it's genuinely just this routine, nothing fancy.\"",
        ),
        _buildTestimonialCard(
          "Brianna K. — Austin, TX",
          "\"The shower ritual module alone changed everything. My legs and arms actually look bronzed and smooth now, not just moisturized.\"",
        ),
        _buildTestimonialCard(
          "Sofia M. — Los Angeles, CA",
          "\"I've bought so many skincare courses that never stuck. This one is so simple I actually still do it every night, months later.\"",
        ),
      ],
    );
  }

  static Widget _buildTestimonialCard(String name, String quote) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF141418),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(
              5,
              (index) => const Icon(Icons.star, color: Colors.amber, size: 14),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            quote,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildBonusSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF141418),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "🎁 FREE BONUSES INCLUDED TODAY:",
            style: TextStyle(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          _buildBonusCheck("Printable Daily Glow Checklist"),
          _buildBonusCheck("7-Day Skin & Body Quick-Start Protocol"),
          _buildBonusCheck("DIY At-Home Recipes Mini-Guide"),
          _buildBonusCheck("Lifetime Platform Updates"),
        ],
      ),
    );
  }

  static Widget _buildBonusCheck(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline, color: Colors.amber, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildOfferPricingCard(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 18 : 28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1E26), Color(0xFF121216)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.amber.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(
            "Get Instant Access To Everything",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 18 : 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),

          // REGULAR PRICE VS TODAY PRICE (Wrap para garantir ajuste em telas muito pequenas)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            runSpacing: 10,
            children: [
              Column(
                children: const [
                  Text(
                    "REGULAR PRICE",
                    style: TextStyle(color: Colors.white38, fontSize: 10),
                  ),
                  Text(
                    "\$39",
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              Column(
                children: const [
                  Text(
                    "TODAY'S PRICE",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "\$12",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "SAVE 69%",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // GUARANTEE BADGE
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.shield, color: Colors.amber, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "30-DAY MONEY BACK GUARANTEE",
                        style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "Try it risk-free. If you don't see results, get a 100% full refund.",
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildFaqSection(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        Text(
          "Frequently Asked Questions",
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        _buildFaqTile(
          "Do I need expensive products or a big budget?",
          "Not at all. Every routine works with drugstore products or simple ingredients you likely already have at home.",
        ),
        _buildFaqTile(
          "Is this an app or a digital guide?",
          "You get instant access to our responsive web platform with photo guides, step-by-step tutorials, and at-home recipes.",
        ),
        _buildFaqTile(
          "Can I access it on my phone?",
          "Yes! It is fully optimized for iOS, Android, tablets, and desktop computers.",
        ),
        _buildFaqTile(
          "How long do I have access?",
          "You get lifetime access with a single one-time payment. No subscription fees ever.",
        ),
        _buildFaqTile(
          "Will this work for my skin type?",
          "Yes. Module 1 teaches you how to identify your skin type first, so every routine after that is adapted to you.",
        ),
        _buildFaqTile(
          "Can I download everything?",
          "Yes, all checklists and step-by-step guides are downloadable for offline use.",
        ),
        _buildFaqTile(
          "What if I don't like it?",
          "You are backed by our 30-day 100% money-back guarantee. Zero risk.",
        ),
        _buildFaqTile(
          "Is this suitable for complete beginners?",
          "Absolutely. We start from the basics — understanding your skin — before moving into any technique.",
        ),
      ],
    );
  }

  static Widget _buildFaqTile(String question, String answer) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF121215),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            child: Text(
              answer,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaButton({
    required BuildContext context,
    required String label,
    required String subtext,
  }) {
    final isMobile = Responsive.isMobile(context);

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: isMobile ? 50 : 58,
          child: ElevatedButton(
            onPressed: _openCheckout,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 8,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isMobile ? 13 : 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtext,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white54, fontSize: 11),
        ),
      ],
    );
  }
}

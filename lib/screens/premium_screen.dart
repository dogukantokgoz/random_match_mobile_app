import 'package:flutter/material.dart';
import 'call_screen.dart';

class PremiumScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final int currentGold;

  const PremiumScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    this.currentGold = 0,
  });

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.75,
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPremiumPackage(BuildContext context, {
    required String title,
    required List<String> features,
    required String price,
    required String oldPrice,
    required int index,
    required int totalItems,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: widget.selectedColor.withOpacity(0.08),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 14, 16, 14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...features.map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: widget.selectedColor,
                                  size: 15,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[800],
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )).toList(),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      decoration: BoxDecoration(
                        color: widget.selectedColor.withOpacity(0.08),
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            oldPrice,
                            style: const TextStyle(
                              color: Colors.black38,
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            height: 46,
            decoration: BoxDecoration(
              color: widget.selectedColor[900]!.withOpacity(0.95),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.horizontal(left: Radius.circular(25)),
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 46,
                      height: 46,
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Premium Satın Al',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(25)),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => CallScreen(
                              selectedCategory: widget.selectedMainCategory,
                            ),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(0.0, 0.03);
                              const end = Offset.zero;
                              const curve = Curves.easeOut;
                              var tween = Tween(begin: begin, end: end).chain(
                                CurveTween(curve: curve),
                              );
                              return SlideTransition(
                                position: animation.drive(tween),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            transitionDuration: const Duration(milliseconds: 150),
                            reverseTransitionDuration: const Duration(milliseconds: 150),
                          ),
                        );
                      },
                      child: Container(
                        width: 46,
                        height: 46,
                        child: const Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: PageView.builder(
              controller: _pageController,
              padEnds: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildPremiumPackage(
                  context,
                  title: 'Premium ${index + 1}',
                  features: index == 0 ? [
                    'Özel profil rozeti',
                    'Reklamsız deneyim',
                    'Özel mesaj bildirimleri',
                    'Öncelikli destek',
                    'Özel temalar',
                  ] : index == 1 ? [
                    'Premium 1\'in tüm özellikleri',
                    'Sınırsız mesajlaşma',
                    'Özel emoji paketi',
                    'Profil istatistikleri',
                    'Gelişmiş arama filtreleri',
                  ] : [
                    'Premium 2\'nin tüm özellikleri',
                    'VIP müşteri desteği',
                    'Özel etkinlik davetiyeleri',
                    'Profil özelleştirme',
                    'Beta özelliklere erken erişim',
                  ],
                  price: index == 0 ? '₺49.99' : index == 1 ? '₺79.99' : '₺129.99',
                  oldPrice: index == 0 ? '₺99.99' : index == 1 ? '₺159.99' : '₺259.99',
                  index: index,
                  totalItems: 3,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
} 
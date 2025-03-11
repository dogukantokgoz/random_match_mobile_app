import 'package:flutter/material.dart';

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
      viewportFraction: 0.85,
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
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: widget.selectedColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ...features.map((feature) => Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: widget.selectedColor,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black87,
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
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            price,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            oldPrice,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 13,
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
      backgroundColor: Colors.white,
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
                const SizedBox(width: 46),
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
          child: PageView(
            controller: _pageController,
            padEnds: false,
            children: [
              _buildPremiumPackage(
                context,
                title: 'Premium 1',
                features: [
                  'Özel profil rozeti',
                  'Reklamsız deneyim',
                  'Özel mesaj bildirimleri',
                  'Öncelikli destek',
                  'Özel temalar',
                ],
                price: '₺49.99',
                oldPrice: '₺99.99',
              ),
              _buildPremiumPackage(
                context,
                title: 'Premium 2',
                features: [
                  'Premium 1\'in tüm özellikleri',
                  'Sınırsız mesajlaşma',
                  'Özel emoji paketi',
                  'Profil istatistikleri',
                  'Gelişmiş arama filtreleri',
                ],
                price: '₺79.99',
                oldPrice: '₺159.99',
              ),
              _buildPremiumPackage(
                context,
                title: 'Premium 3',
                features: [
                  'Premium 2\'nin tüm özellikleri',
                  'VIP müşteri desteği',
                  'Özel etkinlik davetiyeleri',
                  'Profil özelleştirme',
                  'Beta özelliklere erken erişim',
                ],
                price: '₺129.99',
                oldPrice: '₺259.99',
              ),
            ],
          ),
        ),
      ),
    );
  }
} 
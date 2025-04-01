import 'package:flutter/material.dart';
import 'call_screen.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';
import 'notifications_screen.dart';

class PremiumScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final int selectedIndex;

  const PremiumScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    required this.selectedIndex,
  });

  @override
  _PremiumScreenState createState() => _PremiumScreenState();
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
    required int index,
    required int totalItems,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon and Title Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: widget.selectedColor[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          index == 0 ? Icons.star_border :
                          index == 1 ? Icons.workspace_premium :
                          Icons.diamond_outlined,
                          color: widget.selectedColor[900],
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Subtitle
                  Text(
                    'For individuals and small teams',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Price
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (oldPrice != price) Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          oldPrice,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: Colors.grey[500],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Features
                  ...features.map((feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.grey[800],
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                  const SizedBox(height: 24),
                  // Get Started Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.selectedColor[900],
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Get started',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MessagesScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            selectedCategory: widget.selectedMainCategory,
          ),
        ),
      );
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationsScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
            selectedIndex: 0,
            onItemSelected: (index) {},
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // İndirim yüzdesini hesaplama fonksiyonu
    String calculateDiscount(String oldPrice, String currentPrice) {
      double old = double.parse(oldPrice.replaceAll('₺', '').replaceAll(',', '.'));
      double current = double.parse(currentPrice.replaceAll('₺', '').replaceAll(',', '.'));
      int discount = ((old - current) / old * 100).round();
      return '%$discount İndirim';
    }

    final features = [
      {'text': 'Özel profil resmi', 'icon': Icons.account_circle},
      {'text': 'Özel profil rozeti', 'icon': Icons.military_tech},
      {'text': 'Reklamsız deneyim', 'icon': Icons.block},
      {'text': 'Özel mesaj bildirimleri', 'icon': Icons.notifications},
      {'text': 'Öncelikli destek', 'icon': Icons.support_agent},
      {'text': 'Özel temalar', 'icon': Icons.palette},
      {'text': 'Sınırsız mesajlaşma', 'icon': Icons.chat},
      {'text': 'Özel emoji paketi', 'icon': Icons.emoji_emotions},
      {'text': 'Profil istatistikleri', 'icon': Icons.analytics},
      {'text': 'Gelişmiş arama filtreleri', 'icon': Icons.filter_alt},
      {'text': 'VIP müşteri desteği', 'icon': Icons.diamond},
    ];

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
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Premium Title
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.workspace_premium,
                            size: 36,
                            color: widget.selectedColor[900],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Premium',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: widget.selectedColor[900],
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Tüm özelliklere erişim sağlayın',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Features List
                    ...features.map((feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: Row(
                        children: [
                          Icon(
                            feature['icon'] as IconData,
                            color: widget.selectedColor[900],
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature['text'] as String,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )).toList(),
                  ],
                ),
              ),
            ),
          ),
          // Bottom Price Slider Section
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            height: 120, // Reduced from 150
            child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (context, index) {
                final plans = [
                  {'title': 'Haftalık', 'price': '₺19,99', 'oldPrice': '₺39,99'},
                  {'title': 'Aylık', 'price': '₺49,99', 'oldPrice': '₺99,99'},
                  {'title': 'Yıllık', 'price': '₺399,99', 'oldPrice': '₺799,99'},
                ];
                return Container(
                  margin: const EdgeInsets.all(6), // Reduced from 8
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12), // Reduced from 16
                    child: InkWell(
                      onTap: () {
                        // Kart tıklama işlemi
                      },
                      borderRadius: BorderRadius.circular(12), // Reduced from 16
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[200]!,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(12), // Reduced from 16
                        ),
                        child: Stack(
                          children: [
                            // İndirim Badge'i
                            Positioned(
                              top: 8, // Reduced from 12
                              right: 8, // Reduced from 12
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Reduced padding
                                decoration: BoxDecoration(
                                  color: widget.selectedColor[900]!.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12
                                ),
                                child: Text(
                                  calculateDiscount(plans[index]['oldPrice']!, plans[index]['price']!),
                                  style: TextStyle(
                                    color: widget.selectedColor[900],
                                    fontSize: 11, // Reduced from 12
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            // Popüler Badge'i (Sadece aylık plan için)
                            if (index == 1) Positioned(
                              top: 8, // Reduced from 12
                              left: 8, // Reduced from 12
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Reduced padding
                                decoration: BoxDecoration(
                                  color: widget.selectedColor[900]!.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8), // Reduced from 12
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 12, // Reduced from 14
                                      color: widget.selectedColor[900],
                                    ),
                                    const SizedBox(width: 3), // Reduced from 4
                                    Text(
                                      'Popüler',
                                      style: TextStyle(
                                        color: widget.selectedColor[900],
                                        fontSize: 11, // Reduced from 12
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Ana İçerik
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8), // Reduced from 12
                                      child: Text(
                                        plans[index]['title']!,
                                        style: TextStyle(
                                          fontSize: 14, // Reduced from 16
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4), // Reduced from 8
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          plans[index]['price']!,
                                          style: TextStyle(
                                            fontSize: 20, // Reduced from 24
                                            fontWeight: FontWeight.bold,
                                            color: widget.selectedColor[900],
                                          ),
                                        ),
                                        const SizedBox(width: 6), // Reduced from 8
                                        Text(
                                          plans[index]['oldPrice']!,
                                          style: TextStyle(
                                            fontSize: 12, // Reduced from 14
                                            color: Colors.grey[500],
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  child: Container(
                                    height: 32,
                                    decoration: BoxDecoration(
                                      color: widget.selectedColor[900],
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Hemen Başla',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 
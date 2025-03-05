import 'package:flutter/material.dart';
import 'categories_screen.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with TickerProviderStateMixin {
  int _selectedIndex = 1;
  String _selectedCategory = 'Genel';
  bool _isSearching = false;
  bool _hasAnimatedText = false;
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late AnimationController _textAnimationController;
  late Animation<double> _textSlideAnimation;
  
  final Map<String, MaterialColor> categoryColors = {
    'Genel': Colors.blue,
    'Müzik': Colors.purple,
    'Spor': Colors.green,
    'Oyun': Colors.deepOrange,
    'Film': Colors.red,
    'Seyahat': Colors.teal,
    'Yemek': Colors.pink,
    'Sanat': Colors.indigo,
  };

  @override
  void initState() {
    super.initState();
    _animationController1 = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationController2 = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animationController3 = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _textSlideAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeOut,
    ));

    // Animasyonları sırayla başlat
    _animationController1.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController1.reset();
        _animationController1.forward();
      }
    });
    _animationController2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController2.reset();
        _animationController2.forward();
      }
    });
    _animationController3.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController3.reset();
        _animationController3.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController1.dispose();
    _animationController2.dispose();
    _animationController3.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _startSearchAnimation();
      } else {
        _stopSearchAnimation();
        _hasAnimatedText = false;
      }
    });
  }

  void _startSearchAnimation() {
    if (!_hasAnimatedText) {
      _textAnimationController.forward();
      _hasAnimatedText = true;
    }
    _animationController1.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      if (_isSearching) _animationController2.forward();
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      if (_isSearching) _animationController3.forward();
    });
  }

  void _stopSearchAnimation() {
    _animationController1.stop();
    _animationController2.stop();
    _animationController3.stop();
    _animationController1.reset();
    _animationController2.reset();
    _animationController3.reset();
    _textAnimationController.reset();
  }

  Widget _buildSearchRing(AnimationController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: 120 + (controller.value * 80),
          height: 120 + (controller.value * 80),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.grey.withOpacity(0.3 * (1 - controller.value)),
              width: 4,
            ),
          ),
        );
      },
    );
  }

  Widget _buildTopButton({
    required Widget child,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(minWidth: 130),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
        ),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCategoryColor = categoryColors[_selectedCategory] ?? Colors.blue;
    
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  currentCategoryColor[700]!,
                  currentCategoryColor[900]!,
                ],
                stops: const [0.0, 0.7],
              ),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // Categories Button (Top Left)
                  Positioned(
                    left: 16,
                    top: 16,
                    child: _buildTopButton(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CategoriesScreen()),
                        );
                        if (result != null) {
                          setState(() {
                            _selectedCategory = result as String;
                          });
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.category,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _selectedCategory,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  // Level and Stats Display (Top Right)
                  Positioned(
                    right: 16,
                    top: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Level Container
                        _buildTopButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Level 1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 30),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Stats Container
                        _buildTopButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.person_add,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 16),
                              Icon(
                                Icons.timer,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Center Call Button and Text
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            if (_isSearching) ...[
                              _buildSearchRing(_animationController3),
                              _buildSearchRing(_animationController2),
                              _buildSearchRing(_animationController1),
                            ],
                            GestureDetector(
                              onTap: _toggleSearch,
                              child: Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 15,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.call,
                                  size: 50,
                                  color: currentCategoryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        AnimatedBuilder(
                          animation: _textSlideAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, 24 + (_isSearching && _hasAnimatedText ? 16 : _textSlideAnimation.value * 16)),
                              child: Opacity(
                                opacity: 1.0,
                                child: Text(
                                  _isSearching ? 'Aranıyor...' : 'Ara',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Navigation Bar
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300]?.withOpacity(0.95),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(Icons.notifications, 0),
                    _buildNavItem(Icons.call, 1),
                    _buildNavItem(Icons.message, 2),
                    _buildNavItem(Icons.person, 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    final currentCategoryColor = categoryColors[_selectedCategory] ?? Colors.blue;
    
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? currentCategoryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[600],
          size: 28,
        ),
      ),
    );
  }
} 
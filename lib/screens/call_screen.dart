import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';
import 'buy_gold_screen.dart';
import 'notifications_screen.dart';
import '../components/bottom_nav_bar.dart';
import 'match_screen.dart';
import 'chat_screen.dart';
import 'end_match_screen.dart';
import 'call_status_screen.dart';
import '../components/call_request_widget.dart';
import '../components/outgoing_call_widget.dart';
import 'match_request_screen.dart';
import 'premium_screen.dart';
import '../components/profile_card.dart';
import 'login_screen.dart';
import 'splash_screen.dart';

class CallScreen extends StatefulWidget {
  final int currentGold;
  final String? selectedMainCategory;

  const CallScreen({
    super.key,
    this.currentGold = 0,
    this.selectedMainCategory,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> with TickerProviderStateMixin {
  int _selectedIndex = 1;
  late String _selectedCategory;
  bool _isSearching = false;
  late AnimationController _animationController1;
  late AnimationController _animationController2;
  late AnimationController _animationController3;
  late AnimationController _callButtonController;
  late Animation<double> _callButtonAnimation;
  late Animation<double> _callIconAnimation;
  late Animation<double> _callIconFloatAnimation;
  bool _showCallRequest = false;
  bool _showOutgoingCall = false;
  
  final Map<String, dynamic> categoryData = {
    'Genel': {'color': Colors.blue, 'icon': Icons.public},
    'Müzik': {'color': Colors.purple, 'icon': Icons.music_note},
    'Spor': {'color': Colors.green, 'icon': Icons.sports_soccer},
    'Oyun': {'color': Colors.deepOrange, 'icon': Icons.sports_esports},
    'Film': {'color': Colors.red, 'icon': Icons.movie},
    'Seyahat': {'color': Colors.teal, 'icon': Icons.flight},
    'Yemek': {'color': Colors.pink, 'icon': Icons.restaurant},
    'Sanat': {'color': Colors.indigo, 'icon': Icons.palette},
  };

  MaterialColor get currentCategoryColor => categoryData[_selectedCategory]['color'] as MaterialColor;
  IconData get currentCategoryIcon => categoryData[_selectedCategory]['icon'] as IconData;

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.selectedMainCategory ?? 'Genel';
    
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
    _callButtonController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _callButtonAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(
      parent: _callButtonController,
      curve: Curves.easeInOut,
    ));

    _callIconAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.14159, // 360 derece
    ).animate(CurvedAnimation(
      parent: _callButtonController,
      curve: Curves.easeInOut,
    ));

    _callIconFloatAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _callButtonController,
      curve: Curves.easeInOut,
    ));

    _callButtonController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _callButtonController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _callButtonController.forward();
      }
    });

    _callButtonController.forward();

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
    _callButtonController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 3) {
      // Profile icon tapped
      _navigateToScreen(ProfileScreen(
        selectedMainCategory: _selectedCategory,
        selectedColor: currentCategoryColor,
      ));
    } else if (index == 2) {
      // Messages icon tapped
      _navigateToScreen(MessagesScreen(
        selectedMainCategory: _selectedCategory,
        selectedColor: currentCategoryColor,
      ));
    } else if (index == 0) {
      // Notifications icon tapped
      _navigateToScreen(NotificationsScreen(
        selectedMainCategory: _selectedCategory,
        selectedColor: currentCategoryColor,
        selectedIndex: 0,
        onItemSelected: (index) {},
      ));
    }
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _startSearchAnimation();
        _callButtonController.stop();
      } else {
        _stopSearchAnimation();
        _callButtonController.forward();
      }
    });
  }

  void _startSearchAnimation() {
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
  }

  Widget _buildSearchRing(AnimationController controller) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Container(
          width: 120 + (controller.value * 100),
          height: 120 + (controller.value * 100),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withOpacity(0.2 * (1 - controller.value)),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.1 * (1 - controller.value)),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopButton({
    required Widget child,
    VoidCallback? onTap,
    double? width,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        constraints: BoxConstraints(
          minWidth: width ?? 150,
          maxWidth: width ?? 150,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }

  Widget _buildCoinIcon({double size = 20, Color color = Colors.amber}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            color.withOpacity(0.8),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.eco,
          size: size * 0.6,
          color: Colors.yellow[100],
        ),
      ),
    );
  }

  void _navigateToBuyGold() {
    _navigateToScreen(BuyGoldScreen(
      selectedMainCategory: _selectedCategory,
      selectedColor: currentCategoryColor,
      currentGold: widget.currentGold,
    ));
  }

  Future<dynamic> _navigateToScreen(Widget screen) {
    return Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.01);
          const end = Offset.zero;
          const curve = Curves.easeOutCubic;
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
        transitionDuration: const Duration(milliseconds: 100),
        reverseTransitionDuration: const Duration(milliseconds: 100),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentCategoryColor = categoryData[_selectedCategory]['color'] as MaterialColor;
    
    return Scaffold(
      backgroundColor: currentCategoryColor[900],
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
                  // Test button for Splash Screen
                  Positioned(
                    left: 20,
                    top: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SplashScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Test Splash',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  // Categories Button (Top Left)
                  Positioned(
                    left: 16,
                    top: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTopButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                currentCategoryIcon,
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
                          onTap: () async {
                            final result = await _navigateToScreen(CategoriesScreen(
                              selectedCategory: _selectedCategory,
                            ));
                            if (result != null) {
                              setState(() {
                                _selectedCategory = result as String;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 8),
                        _buildTopButton(
                          width: 75,
                          child: Icon(
                            Icons.workspace_premium,
                            color: Colors.amber,
                            size: 20,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PremiumScreen(
                                  selectedMainCategory: _selectedCategory,
                                  selectedColor: currentCategoryColor,
                                  selectedIndex: _selectedIndex,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
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
                            mainAxisSize: MainAxisSize.min,
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Likes and Gold Container
                        _buildTopButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 4),
                              Text(
                                '128',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 16),
                              GestureDetector(
                                onTap: _navigateToBuyGold,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    _buildCoinIcon(size: 20),
                                    Container(
                                      width: 24,
                                      alignment: Alignment.center,
                                      child: Text(
                                        '40',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Stats Container
                        _buildTopButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                Row(
                                  children: [
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
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                              ),
                            ],
                            ),
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
                        SizedBox(
                          height: 180,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (_isSearching) ...[
                                _buildSearchRing(_animationController3),
                                _buildSearchRing(_animationController2),
                                _buildSearchRing(_animationController1),
                              ],
                              AnimatedBuilder(
                                animation: _callButtonController,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _isSearching ? 1.0 : _callButtonAnimation.value,
                                    child: GestureDetector(
                                      onTap: _toggleSearch,
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Colors.white,
                                              Colors.white.withOpacity(0.9),
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: currentCategoryColor.withOpacity(0.3),
                                              spreadRadius: 5,
                                              blurRadius: 15,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            if (!_isSearching)
                                              AnimatedBuilder(
                                                animation: _callIconAnimation,
                                                builder: (context, child) {
                                                  return Transform.translate(
                                                    offset: Offset(
                                                      0,
                                                      -10 * _callIconFloatAnimation.value,
                                                    ),
                                                    child: Transform.rotate(
                                                      angle: _callIconAnimation.value,
                                                      child: Icon(
                                                        Icons.call,
                                                        size: 50,
                                                        color: currentCategoryColor,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              )
                                            else
                                              Icon(
                                                Icons.call,
                                                size: 50,
                                                color: currentCategoryColor,
                                              ),
                                          ],
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

                  // Test Buttons
                  Positioned(
                    bottom: 80,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              _navigateToScreen(MatchScreen(
                                selectedMainCategory: _selectedCategory,
                                selectedColor: currentCategoryColor,
                                user: {
                                  'name': 'Test User',
                                  'level': 5,
                                  'likes': 128,
                                  'status': 'online',
                                  'bio': 'Hello! I love music and traveling. Looking for new friends to chat with!',
                                },
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test Match',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              _navigateToScreen(EndMatchScreen(
                                selectedColor: currentCategoryColor,
                                user: {
                                  'name': 'John Doe',
                                  'level': 5,
                                  'likes': 123,
                                  'status': 'Online',
                                },
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test End',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              _navigateToScreen(CallStatusScreen(
                                selectedColor: currentCategoryColor,
                                isBusy: true,
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test Busy',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              _navigateToScreen(CallStatusScreen(
                                selectedColor: currentCategoryColor,
                                isBusy: false,
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test No Match',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              setState(() {
                                _showCallRequest = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test Gelen Arama',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              setState(() {
                                _showOutgoingCall = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test Giden Arama',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              _navigateToScreen(MatchRequestScreen(
                                selectedMainCategory: _selectedCategory,
                                selectedColor: currentCategoryColor,
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test Eşleşme İsteği',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(15),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ProfileCard(
                                        name: 'John Doe',
                                        imageUrl: 'assets/images/profile.png',
                                        level: 5,
                                        likes: 128,
                                        isPremium: true,
                                      ),
                                      const SizedBox(height: 16),
                                      ProfileCard(
                                        name: 'Jane Smith',
                                        imageUrl: 'assets/images/profile.png',
                                        level: 3,
                                        likes: 64,
                                        isPremium: false,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Test Profile Cards',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Test Buttons
                  Positioned(
                    bottom: 80,
                    left: 16,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(15),
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: const Text(
                            'Test Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showCallRequest)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CallRequestWidget(
                callerName: 'John Doe',
                callerImage: 'assets/images/profile.png',
                onAccept: () {
                  setState(() {
                    _showCallRequest = false;
                  });
                  // Arama kabul edildiğinde yapılacak işlemler
                },
                onReject: () {
                  setState(() {
                    _showCallRequest = false;
                  });
                  // Arama reddedildiğinde yapılacak işlemler
                },
              ),
            ),
          if (_showOutgoingCall)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: OutgoingCallWidget(
                receiverName: 'Jane Smith',
                receiverImage: 'assets/images/profile.png',
                onCancel: () {
                  setState(() {
                    _showOutgoingCall = false;
                  });
                  // Arama iptal edildiğinde yapılacak işlemler
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        selectedColor: currentCategoryColor,
        onItemSelected: _onItemTapped,
      ),
    );
  }
} 
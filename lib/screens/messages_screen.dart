import 'package:flutter/material.dart';
import 'profile_screen.dart';
import 'chat_screen.dart';
import 'buy_gold_screen.dart';
import '../components/bottom_nav_bar.dart';
import 'call_screen.dart';
import 'notifications_screen.dart';
import '../components/profile_avatar_card.dart';

class MessagesScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final int currentGold;

  const MessagesScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    this.currentGold = 0,
  });

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 2;
  int? _openedMessageIndex;
  Map<int, double> _messageOffsets = {};
  final double _maxSlideAmount = 80.0;
  late AnimationController _animationController;
  
  final List<Map<String, dynamic>> messages = [
    {
      'name': 'John Doe',
      'lastMessage': 'See you tomorrow!',
      'time': '2 min ago',
      'unread': true,
      'status': 'Online',
      'level': 5,
      'likes': 128
    },
    {
      'name': 'Jane Smith',
      'lastMessage': 'Thanks for the help',
      'time': '1 hour ago',
      'unread': false,
      'status': 'Offline',
      'level': 3,
      'likes': 64
    },
    {
      'name': 'Mike Johnson',
      'lastMessage': 'Great idea!',
      'time': '2 hours ago',
      'unread': true,
      'status': 'Offline',
      'level': 7,
      'likes': 256
    },
    {
      'name': 'Sarah Wilson',
      'lastMessage': 'Let me know when you\'re free',
      'time': 'Yesterday',
      'unread': false,
      'status': 'Online',
      'level': 4,
      'likes': 96
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    for (int i = 0; i < messages.length; i++) {
      _messageOffsets[i] = 0.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onBuyGoldPressed() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => BuyGoldScreen(
          selectedMainCategory: widget.selectedMainCategory,
          selectedColor: widget.selectedColor,
          currentGold: widget.currentGold,
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
  }

  void _handleBuyGoldOption() {
    _onBuyGoldPressed();
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => ChatScreen(
                  selectedMainCategory: widget.selectedMainCategory,
                  selectedColor: widget.selectedColor,
                  user: message,
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
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            widget.selectedColor[400]!,
                            widget.selectedColor[600]!,
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: widget.selectedColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: message['status'].toLowerCase() == 'online' 
                              ? Colors.green[400]
                              : Colors.grey[400],
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message['name'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message['lastMessage'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        message['status'],
                        style: TextStyle(
                          fontSize: 12,
                          color: message['status'].toLowerCase() == 'online'
                              ? Colors.green[600]
                              : Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      message['time'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (message['unread'])
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: widget.selectedColor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '1 new',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
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
  }

  void _closeMessage(int index) {
    setState(() {
      _messageOffsets[index] = 0;
      _openedMessageIndex = null;
    });
  }

  void _openMessage(int index) {
    setState(() {
      _messageOffsets[index] = -_maxSlideAmount;
      _openedMessageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    'Messages',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: const BorderRadius.horizontal(right: Radius.circular(25)),
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => CallScreen(
                              selectedMainCategory: widget.selectedMainCategory,
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
                          size: 24,
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
      body: Stack(
        children: [
          if (_openedMessageIndex != null)
            Positioned.fill(
              child: GestureDetector(
                onTapDown: (_) => _closeMessage(_openedMessageIndex!),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragUpdate: (details) {
                  setState(() {
                    if (_openedMessageIndex == index) {
                      _messageOffsets[index] = _messageOffsets[index]! + details.delta.dx;
                      if (_messageOffsets[index]! > 0) {
                        _messageOffsets[index] = 0;
                      }
                      if (_messageOffsets[index]! > -20) {
                        _closeMessage(index);
                      }
                    } else if (_openedMessageIndex == null) {
                      _messageOffsets[index] = _messageOffsets[index]! + details.delta.dx;
                      if (_messageOffsets[index]! < -_maxSlideAmount) {
                        _messageOffsets[index] = -_maxSlideAmount;
                      }
                      if (_messageOffsets[index]! > 0) {
                        _messageOffsets[index] = 0;
                      }
                      if (_messageOffsets[index]! < -60) {
                        _openMessage(index);
                      }
                    }
                  });
                },
                onHorizontalDragEnd: (details) {
                  setState(() {
                    if (_openedMessageIndex == index) {
                      if (_messageOffsets[index]! > -40) {
                        _closeMessage(index);
                      } else {
                        _messageOffsets[index] = -_maxSlideAmount;
                      }
                    } else {
                      if (_messageOffsets[index]! < -40) {
                        _openMessage(index);
                      } else {
                        _messageOffsets[index] = 0;
                      }
                    }
                  });
                },
                child: Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      transform: Matrix4.translationValues(_messageOffsets[index] ?? 0, 0, 0),
                      child: _buildMessageItem(message),
                    ),
                    if (_openedMessageIndex == index)
                      Positioned.fill(
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _closeMessage(index),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut,
                              width: -(_messageOffsets[index] ?? 0),
                              margin: const EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                color: Colors.red[50],
                                borderRadius: const BorderRadius.horizontal(
                                  right: Radius.circular(12),
                                ),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      backgroundColor: Colors.transparent,
                                      child: Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                            color: Colors.red[600]!,
                                            width: 2,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.1),
                                              blurRadius: 20,
                                              offset: const Offset(0, 10),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Sohbeti Sil',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey[900],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Bu sohbeti silmek istediğinizden emin misiniz?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            const SizedBox(height: 24),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () => Navigator.pop(context),
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[100],
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: Text(
                                                          'Vazgeç',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.grey[800],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          messages.removeAt(index);
                                                          _closeMessage(index);
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: Container(
                                                        padding: const EdgeInsets.symmetric(vertical: 14),
                                                        decoration: BoxDecoration(
                                                          color: Colors.red[600],
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: const Text(
                                                          'Sil',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
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
                                  );
                                },
                                child: Container(
                                  width: 80,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: Colors.red[50],
                                    borderRadius: const BorderRadius.horizontal(
                                      right: Radius.circular(12),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        color: Colors.red[600],
                                        size: 24,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Sil',
                                        style: TextStyle(
                                          color: Colors.red[600],
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
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
                  ],
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        selectedColor: widget.selectedColor,
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _onItemTapped(index);
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    if (index == 3) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ProfileScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
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
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => CallScreen(
            selectedMainCategory: widget.selectedMainCategory,
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
    } else if (index == 0) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => NotificationsScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
            selectedIndex: 0,
            onItemSelected: (index) {},
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
    }
  }

  void _navigateToScreen(Widget screen) {
    Navigator.push(
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
} 
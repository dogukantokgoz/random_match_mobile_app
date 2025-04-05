import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import '../components/profile_avatar_card.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';
import 'call_screen.dart';

class NotificationsScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const NotificationsScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int? _openedNotificationIndex;
  Map<int, double> _notificationOffsets = {};
  final double _maxSlideAmount = 80.0;

  final List<Map<String, dynamic>> notifications = [
    {
      'user': {
        'name': 'Ahmet Yılmaz',
        'image': null,
        'status': 'Online',
        'level': 6,
        'likes': 156
      },
      'type': 'poke',
      'time': '10:00',
      'read': false,
    },
    {
      'user': {
        'name': 'Mehmet Demir',
        'image': null,
        'status': 'Offline',
        'level': 4,
        'likes': 89
      },
      'type': 'poke',
      'time': '09:45',
      'read': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < notifications.length; i++) {
      _notificationOffsets[i] = 0.0;
    }
  }

  void _onItemTapped(int index) {
    widget.onItemSelected(index);
    
    if (index == 3) {
      _navigateToScreen(ProfileScreen(
        selectedMainCategory: widget.selectedMainCategory,
        selectedColor: widget.selectedColor,
      ));
    } else if (index == 2) {
      _navigateToScreen(MessagesScreen(
        selectedMainCategory: widget.selectedMainCategory,
        selectedColor: widget.selectedColor,
      ));
    } else if (index == 1) {
      _navigateToScreen(CallScreen(
        selectedMainCategory: widget.selectedMainCategory,
      ));
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

  Widget _buildNotificationItem(Map<String, dynamic> notification, int index) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onHorizontalDragUpdate: (details) {
        setState(() {
          if (_openedNotificationIndex == index) {
            // Sağa kaydırma - bildirimi kapat
            _notificationOffsets[index] = _notificationOffsets[index]! + details.delta.dx;
            if (_notificationOffsets[index]! > 0) {
              _notificationOffsets[index] = 0;
            }
            if (_notificationOffsets[index]! > -20) {
              _openedNotificationIndex = null;
            }
          } else if (_openedNotificationIndex == null) {
            // Sola kaydırma - bildirimi aç
            _notificationOffsets[index] = _notificationOffsets[index]! + details.delta.dx;
            if (_notificationOffsets[index]! < -_maxSlideAmount) {
              _notificationOffsets[index] = -_maxSlideAmount;
            }
            if (_notificationOffsets[index]! > 0) {
              _notificationOffsets[index] = 0;
            }
            if (_notificationOffsets[index]! < -60) {
              _openedNotificationIndex = index;
            }
          }
        });
      },
      onHorizontalDragEnd: (details) {
        setState(() {
          if (_openedNotificationIndex == index) {
            if (_notificationOffsets[index]! > -40) {
              _notificationOffsets[index] = 0;
              _openedNotificationIndex = null;
            } else {
              _notificationOffsets[index] = -_maxSlideAmount;
            }
          } else {
            if (_notificationOffsets[index]! < -40) {
              _notificationOffsets[index] = -_maxSlideAmount;
              _openedNotificationIndex = index;
            } else {
              _notificationOffsets[index] = 0;
            }
          }
        });
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: Matrix4.translationValues(_notificationOffsets[index] ?? 0, 0, 0),
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: notification['read'] ? Colors.white : widget.selectedColor.withOpacity(0.1),
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
                  onTap: () {
                    // Bildirime tıklandığında yapılacak işlemler
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
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
                                  color: notification['user']['status'].toLowerCase() == 'online'
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
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Text(
                                      notification['user']['name'],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'seni dürttü',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification['time'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
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
            ),
          ),
          if (_openedNotificationIndex == index)
            Positioned.fill(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _notificationOffsets[index] = 0;
                          _openedNotificationIndex = null;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    width: -(_notificationOffsets[index] ?? 0),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(16),
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
                                    'Bildirimi Sil',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[900],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Bu bildirimi silmek istediğinizden emin misiniz?',
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
                                                notifications.removeAt(index);
                                                _openedNotificationIndex = null;
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
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(16),
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
                    'Bildirimler',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
          if (_openedNotificationIndex != null)
            Positioned.fill(
              child: GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    _notificationOffsets[_openedNotificationIndex!] = 0;
                    _openedNotificationIndex = null;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: notifications.length,
            itemBuilder: (context, index) => _buildNotificationItem(notifications[index], index),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: widget.selectedIndex,
        selectedColor: widget.selectedColor,
        onItemSelected: _onItemTapped,
      ),
    );
  }
} 
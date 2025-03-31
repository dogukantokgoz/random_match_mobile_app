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

  void _onItemTapped(int index) {
    widget.onItemSelected(index);
    
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
          ),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MessagesScreen(
            selectedMainCategory: widget.selectedMainCategory,
            selectedColor: widget.selectedColor,
          ),
        ),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CallScreen(
            selectedCategory: widget.selectedMainCategory,
          ),
        ),
      );
    }
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Container(
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
            setState(() {
              notification['read'] = true;
            });
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
                      Row(
                        children: [
                          Text(
                            notification['time'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) => _buildNotificationItem(notifications[index]),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: widget.selectedIndex,
        selectedColor: widget.selectedColor,
        onItemSelected: _onItemTapped,
      ),
    );
  }
} 

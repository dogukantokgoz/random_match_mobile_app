import 'package:flutter/material.dart';

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
        'image': null, // Profil resmi null ise varsayılan icon kullanılacak
        'status': 'Online',
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
      },
      'type': 'poke',
      'time': '09:45',
      'read': true,
    },
  ];

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
                // User Avatar
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: notification['user']['image'] != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                notification['user']['image'],
                                fit: BoxFit.cover,
                              ),
                            )
                          : Icon(
                              Icons.person,
                              color: Colors.grey[600],
                              size: 30,
                            ),
                    ),
                    if (notification['user']['status'] == 'Online')
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            notification['user']['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'seni dürttü',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification['time'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
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
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: widget.selectedColor[900]!.withOpacity(0.95),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(23),
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(23),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Bildirimler',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
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
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) => _buildNotificationItem(notifications[index]),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            height: 56,
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 12,
              top: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem(0, Icons.home_outlined, Icons.home),
                _buildNavItem(1, Icons.message_outlined, Icons.message),
                _buildNavItem(2, Icons.notifications_outlined, Icons.notifications),
                _buildNavItem(3, Icons.person_outline, Icons.person),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData outlinedIcon, IconData filledIcon) {
    final isSelected = widget.selectedIndex == index;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => widget.onItemSelected(index),
        child: Container(
          width: 56,
          height: 56,
          padding: const EdgeInsets.all(16),
          child: Icon(
            isSelected ? filledIcon : outlinedIcon,
            color: isSelected ? widget.selectedColor : Colors.grey[400],
            size: 24,
          ),
        ),
      ),
    );
  }
} 
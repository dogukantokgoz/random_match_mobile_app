import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;

  const ProfileScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3;
  String _selectedCategory = 'Arkadaşlar';
  
  final Map<String, Map<String, dynamic>> categoryData = {
    'Arkadaşlar': {'color': Colors.blue, 'icon': Icons.people, 'items': [
      {'name': 'John Doe', 'status': 'Online'},
      {'name': 'Jane Smith', 'status': 'Offline'},
      {'name': 'Mike Johnson', 'status': 'Away'},
    ]},
    'İstekler': {'color': Colors.green, 'icon': Icons.person_add, 'items': [
      {'name': 'Alice Brown', 'status': 'Pending'},
      {'name': 'Bob Wilson', 'status': 'Pending'},
      {'name': 'Carol White', 'status': 'Pending'},
    ]},
    'Sildiklerim': {'color': Colors.red, 'icon': Icons.person_remove, 'items': [
      {'name': 'David Lee', 'status': 'Blocked'},
      {'name': 'Emma Davis', 'status': 'Removed'},
    ]},
  };

  List<Map<String, String>> get currentItems => 
    (categoryData[_selectedCategory]!['items'] as List<Map<String, String>>);

  MaterialColor get currentCategoryColor => widget.selectedColor;
  IconData get currentCategoryIcon => categoryData[_selectedCategory]!['icon'] as IconData;

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

  Widget _buildStatItem(IconData icon, String value, Color iconColor) {
    return Row(
      children: [
        icon == Icons.monetization_on
            ? _buildCoinIcon(size: 24)
            : Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String title, IconData icon, int count, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
        });
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border(
            bottom: BorderSide(
              color: isSelected ? currentCategoryColor : Colors.transparent,
              width: 2,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? currentCategoryColor : Colors.grey[700],
                ),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected ? currentCategoryColor : Colors.grey[800],
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? currentCategoryColor.withOpacity(0.1) : Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                count.toString(),
                style: TextStyle(
                  color: isSelected ? currentCategoryColor : Colors.grey[600],
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey[100],
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: Colors.black87,
        iconSize: 20,
      ),
    );
  }

  Widget _buildFriendItem(String name, String status) {
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
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey[600],
                    size: 30,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        status,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildActionButton(Icons.call, () {}),
                _buildActionButton(Icons.message, () {}),
                _buildActionButton(Icons.notifications, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final currentColor = currentCategoryColor;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            height: 46,
            decoration: BoxDecoration(
              color: currentColor[900]!.withOpacity(0.95),
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
                    'My Profile',
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
                      onTap: () {},
                      child: Container(
                        width: 46,
                        height: 46,
                        child: const Icon(
                          Icons.settings,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 45,
                        color: Colors.grey[500],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.edit,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nickname',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Status message',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildStatItem(Icons.star, 'Level 5', currentColor),
                    const SizedBox(height: 4),
                    _buildStatItem(Icons.favorite, '128', currentColor),
                    const SizedBox(height: 4),
                    _buildStatItem(Icons.monetization_on, '50', Colors.amber),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCategoryButton('Arkadaşlar', Icons.people, currentItems.length, _selectedCategory == 'Arkadaşlar'),
                    const SizedBox(width: 8),
                    _buildCategoryButton('İstekler', Icons.person_add, (categoryData['İstekler']!['items'] as List).length, _selectedCategory == 'İstekler'),
                    const SizedBox(width: 8),
                    _buildCategoryButton('Sildiklerim', Icons.person_remove, (categoryData['Sildiklerim']!['items'] as List).length, _selectedCategory == 'Sildiklerim'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ...currentItems.map((item) => _buildFriendItem(item['name']!, item['status']!)).toList(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
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
              _buildNavItem(Icons.notifications, 0, _selectedIndex == 0),
              _buildNavItem(Icons.call, 1, _selectedIndex == 1),
              _buildNavItem(Icons.message, 2, _selectedIndex == 2),
              _buildNavItem(Icons.person, 3, _selectedIndex == 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index, bool isSelected) {
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

  void _onItemTapped(int index) {
    if (index != 3) {
      Navigator.pop(context);
    }
    setState(() {
      _selectedIndex = index;
    });
  }
} 
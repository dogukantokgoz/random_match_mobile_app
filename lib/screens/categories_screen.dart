import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Genel', 'color': Colors.blue, 'icon': Icons.public},
    {'name': 'Müzik', 'color': Colors.purple, 'icon': Icons.music_note},
    {'name': 'Spor', 'color': Colors.green, 'icon': Icons.sports_soccer},
    {'name': 'Oyun', 'color': Colors.deepOrange, 'icon': Icons.sports_esports},
    {'name': 'Film', 'color': Colors.red, 'icon': Icons.movie},
    {'name': 'Seyahat', 'color': Colors.teal, 'icon': Icons.flight},
    {'name': 'Yemek', 'color': Colors.pink, 'icon': Icons.restaurant},
    {'name': 'Sanat', 'color': Colors.indigo, 'icon': Icons.palette},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kategoriler',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final MaterialColor categoryColor = category['color'] as MaterialColor;
          
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.pop(context, category['name']),
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  decoration: BoxDecoration(
                    color: categoryColor[700],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: categoryColor[900]!.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        category['icon'] as IconData,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        category['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white70,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 
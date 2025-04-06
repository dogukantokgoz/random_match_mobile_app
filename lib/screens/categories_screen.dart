import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.selectedCategory,
  });

  final String selectedCategory;

  final List<Map<String, dynamic>> categories = const [
    {'name': 'Genel', 'color': Colors.blue, 'icon': Icons.public, 'online': 1988},
    {'name': 'Müzik', 'color': Colors.purple, 'icon': Icons.music_note, 'online': 550},
    {'name': 'Spor', 'color': Colors.green, 'icon': Icons.sports_soccer, 'online': 320},
    {'name': 'Oyun', 'color': Colors.deepOrange, 'icon': Icons.sports_esports, 'online': 780},
    {'name': 'Film', 'color': Colors.red, 'icon': Icons.movie, 'online': 450},
    {'name': 'Seyahat', 'color': Colors.teal, 'icon': Icons.flight, 'online': 15},
    {'name': 'Yemek', 'color': Colors.pink, 'icon': Icons.restaurant, 'online': 120},
    {'name': 'Sanat', 'color': Colors.indigo, 'icon': Icons.palette, 'online': 85},
  ];

  MaterialColor _getCategoryColor(String categoryName) {
    final category = categories.firstWhere(
      (cat) => cat['name'] == categoryName,
      orElse: () => categories.first,
    );
    return category['color'] as MaterialColor;
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = _getCategoryColor(selectedCategory);
    
    return Scaffold(
      backgroundColor: selectedColor[900]!.withOpacity(0.95),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
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
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 46),
                      child: Text(
                        'Kategoriler',
                        style: const TextStyle(
                          color: Colors.white,
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
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final MaterialColor categoryColor = category['color'] as MaterialColor;
          final bool isSelected = category['name'] == selectedCategory;
          
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
                    color: isSelected 
                        ? categoryColor[700]
                        : categoryColor[700]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected
                          ? Colors.white.withOpacity(0.5)
                          : categoryColor[300]!.withOpacity(0.3),
                      width: 1.5,
                    ),
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
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${category['online']} çevrimiçi',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (isSelected)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        )
                      else
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
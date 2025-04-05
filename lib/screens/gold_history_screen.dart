import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';

class GoldHistoryScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final int selectedIndex;

  const GoldHistoryScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    required this.selectedIndex,
  });

  @override
  _GoldHistoryScreenState createState() => _GoldHistoryScreenState();
}

class _GoldHistoryScreenState extends State<GoldHistoryScreen> {
  final List<Map<String, dynamic>> goldTransactions = [
    {
      'type': 'purchase',
      'amount': 10,
      'date': DateTime.now().subtract(const Duration(hours: 2)),
      'description': '10 altın satın aldın',
    },
    {
      'type': 'send',
      'amount': 1,
      'date': DateTime.now().subtract(const Duration(hours: 5)),
      'description': '1 altın gönderdin',
    },
    {
      'type': 'purchase',
      'amount': 25,
      'date': DateTime.now().subtract(const Duration(days: 1)),
      'description': '25 altın satın aldın',
    },
    {
      'type': 'send',
      'amount': 5,
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'description': '5 altın gönderdin',
    },
  ];

  void _onItemTapped(int index) {
    Navigator.pop(context);
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Bugün ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Dün ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      return '${date.day}/${date.month}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    }
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
                    'Altın İşlemleri',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Material(
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
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: goldTransactions.length,
        itemBuilder: (context, index) {
          final transaction = goldTransactions[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      transaction['description'],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                  ),
                  Text(
                    _formatDate(transaction['date']),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: widget.selectedIndex,
        selectedColor: widget.selectedColor,
        onItemSelected: _onItemTapped,
      ),
    );
  }
} 
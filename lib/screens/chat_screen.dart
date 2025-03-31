import 'package:flutter/material.dart';
import 'package:random_match/components/bottom_nav_bar.dart';
import '../components/profile_avatar_card.dart';
import 'messages_screen.dart';
import 'buy_gold_screen.dart';

class ChatScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final Map<String, dynamic> user;
  final int currentGold;

  const ChatScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    required this.user,
    this.currentGold = 0,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Merhaba!',
      'isMe': false,
      'time': '10:00',
      'status': null,
    },
    {
      'text': 'Nasılsın?',
      'isMe': true,
      'time': '10:01',
      'status': 'seen',
    },
    {
      'text': 'İyiyim, teşekkürler. Sen nasılsın?',
      'isMe': false,
      'time': '10:02',
      'status': null,
    },
    {
      'text': 'Ben de iyiyim, teşekkürler!',
      'isMe': true,
      'time': '10:03',
      'status': 'delivered',
    },
  ];

  Widget _buildMessageStatus(String status) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (status == 'delivered')
          const Icon(
            Icons.done,
            size: 14,
            color: Colors.white,
          )
        else if (status == 'seen')
          const Icon(
            Icons.done_all,
            size: 14,
            color: Colors.white,
          ),
        const SizedBox(width: 2),
      ],
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    return Align(
      alignment: message['isMe'] ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: message['isMe'] ? 64 : 0,
          right: message['isMe'] ? 0 : 64,
          bottom: 8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message['isMe'] 
              ? widget.selectedColor.withOpacity(0.9)
              : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(message['isMe'] ? 16 : 4),
            bottomRight: Radius.circular(message['isMe'] ? 4 : 16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: message['isMe'] 
              ? CrossAxisAlignment.end 
              : CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: TextStyle(
                color: message['isMe'] ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message['time'],
                  style: TextStyle(
                    color: message['isMe'] 
                        ? Colors.white.withOpacity(0.7) 
                        : Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                if (message['isMe'] && message['status'] != null)
                  _buildMessageStatus(message['status']),
              ],
            ),
          ],
        ),
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
                // Back Button
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
                // User Info
                Expanded(
                  flex: 3,
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
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 36,
                              height: 36,
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
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.user['status'].toLowerCase() == 'online'
                                      ? Colors.green[400]
                                      : widget.user['status'].toLowerCase() == 'away'
                                          ? Colors.orange[400]
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
                          child: Text(
                            widget.user['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Call Button
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: widget.user['status'].toLowerCase() == 'online'
                        ? widget.selectedColor[900]!.withOpacity(0.95)
                        : Colors.grey[400]!.withOpacity(0.95),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(23),
                      onTap: widget.user['status'].toLowerCase() == 'online' ? () {} : null,
                      child: Icon(
                        Icons.call,
                        color: widget.user['status'].toLowerCase() == 'online'
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // More Options Button
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: widget.selectedColor[900]!.withOpacity(0.95),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: PopupMenuButton<String>(
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 24,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem<String>(
                          value: 'poke',
                          child: Row(
                            children: [
                              Icon(
                                Icons.notifications_active,
                                color: widget.selectedColor[400],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text('Dürt'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'buy_gold',
                          child: Row(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                color: Colors.amber[700],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text('Altın Satın Al'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'gold',
                          child: Row(
                            children: [
                              Icon(
                                Icons.workspace_premium,
                                color: Colors.amber[700],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text('Altın Gönder'),
                            ],
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.red[600],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text('Sohbeti Sil'),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (String value) {
                        if (value == 'poke') {
                          // Dürtme işlemi
                        } else if (value == 'buy_gold') {
                          _navigateToBuyGold();
                        } else if (value == 'gold') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Altın Gönder'),
                              content: const Text('Bu kullanıcıya altın göndermek istediğinizden emin misiniz?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'İptal',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    // Altın gönderme işlemi
                                  },
                                  child: Text(
                                    'Gönder',
                                    style: TextStyle(
                                      color: Colors.amber[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (value == 'delete') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Sohbeti Sil'),
                              content: const Text('Bu sohbeti silmek istediğinizden emin misiniz?'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'İptal',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Sil',
                                    style: TextStyle(
                                      color: Colors.red[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) => _buildMessageBubble(messages[index]),
            ),
          ),
          // Message Input
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Photo Button
                Material(
                  color: Colors.transparent,
                  child: PopupMenuButton<String>(
                    icon: Icon(
                      Icons.photo_camera,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'gallery',
                        child: Row(
                          children: [
                            Icon(
                              Icons.photo_library,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text('Galeriden Seç'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'camera',
                        child: Row(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.grey[600],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text('Fotoğraf Çek'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      if (value == 'gallery') {
                        // Galeri açma işlemi
                      } else if (value == 'camera') {
                        // Kamera açma işlemi
                      }
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Mesaj yazın...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                // Gold Button
                Material(
                  color: Colors.transparent,
                  child: PopupMenuButton<String>(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        children: [
                          _buildCoinIcon(size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${widget.currentGold}',
                            style: TextStyle(
                              color: Colors.amber[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem<String>(
                        value: 'buy_gold',
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.amber[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text('Altın Satın Al'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'send_gold',
                        child: Row(
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: Colors.amber[700],
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            const Text('Altın Gönder'),
                          ],
                        ),
                      ),
                    ],
                    onSelected: (String value) {
                      if (value == 'buy_gold') {
                        _navigateToBuyGold();
                      } else if (value == 'send_gold') {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Altın Gönder'),
                            content: const Text('Bu kullanıcıya altın göndermek istediğinizden emin misiniz?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'İptal',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  // Altın gönderme işlemi
                                },
                                child: Text(
                                  'Gönder',
                                  style: TextStyle(
                                    color: Colors.amber[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                // Send Button
                Material(
                  color: Colors.transparent,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: widget.selectedColor,
                    ),
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          messages.add({
                            'text': _messageController.text,
                            'isMe': true,
                            'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                            'status': 'delivered',
                          });
                          _messageController.clear();
                        });
                      }
                    },
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
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
} 
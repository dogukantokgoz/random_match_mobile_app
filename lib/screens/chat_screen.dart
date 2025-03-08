import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String selectedMainCategory;
  final MaterialColor selectedColor;
  final Map<String, dynamic> user;

  const ChatScreen({
    super.key,
    required this.selectedMainCategory,
    required this.selectedColor,
    required this.user,
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
                  flex: 2,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.grey[600],
                                size: 20,
                              ),
                            ),
                            if (widget.user['status'] == 'Online')
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 10,
                                  height: 10,
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
                        const SizedBox(width: 8),
                        Text(
                          widget.user['name'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
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
                    color: widget.selectedColor[900]!.withOpacity(0.95),
                    shape: BoxShape.circle,
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(23),
                      onTap: () {},
                      child: const Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Poke Button
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
                      onTap: () {},
                      child: const Icon(
                        Icons.notifications_active,
                        color: Colors.white,
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
                        if (value == 'buy_gold') {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Altın Satın Al'),
                              content: const Text('Altın satın alma sayfasına yönlendirileceksiniz. Devam etmek istiyor musunuz?'),
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
                                    // Altın satın alma sayfasına yönlendirme
                                  },
                                  child: Text(
                                    'Devam Et',
                                    style: TextStyle(
                                      color: Colors.amber[700],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
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
                          Icon(
                            Icons.workspace_premium,
                            color: Colors.amber[700],
                            size: 20,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '50', // Mevcut altın miktarı
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
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Altın Satın Al'),
                            content: const Text('Altın satın alma sayfasına yönlendirileceksiniz. Devam etmek istiyor musunuz?'),
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
                                  // Altın satın alma sayfasına yönlendirme
                                },
                                child: Text(
                                  'Devam Et',
                                  style: TextStyle(
                                    color: Colors.amber[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
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
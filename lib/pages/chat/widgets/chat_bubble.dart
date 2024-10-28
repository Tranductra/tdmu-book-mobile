import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String? message;
  final String? imageUrl;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, this.message, required this.isCurrentUser, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.green : Colors.blueAccent,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (message != null)
            Container(
              padding: const EdgeInsets.all(6),
              child: Text(
                message!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          if (imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  10), // Thay đổi giá trị để điều chỉnh độ cong
              child: Image.network(
                imageUrl!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
        ],
      ),
    );
  }
}

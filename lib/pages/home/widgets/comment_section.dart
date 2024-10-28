import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CommentSection extends StatelessWidget {
  CommentSection({super.key, required this.commentController, this.onSend});
  final TextEditingController commentController;
  final void Function()? onSend;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80, // Adjust height as needed
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 2),
                ),
                child: SvgPicture.asset(
                  'assets/images/home/feed/avatar_user.svg',
                  height: 24,
                  width: 24,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextFormField(
                  controller: commentController,
                  decoration: InputDecoration(
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    suffixIcon: IconButton(
                      onPressed: onSend,
                      icon: const Icon(Icons.send, color: Colors.blue),
                    ),
                    hintText: 'Viết bình luận...',
                    border: OutlineInputBorder(),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

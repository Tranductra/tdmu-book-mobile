import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationSectionWidget extends StatefulWidget {
  final String title;
  final String content;
  final Color? titleColor;

  const InformationSectionWidget({
    super.key,
    required this.title,
    required this.content,
    this.titleColor = Colors.deepPurpleAccent,
  });

  @override
  _InformationSectionWidgetState createState() =>
      _InformationSectionWidgetState();
}

class _InformationSectionWidgetState extends State<InformationSectionWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // Define the maximum number of characters to show when collapsed
    final int maxLength = 80;

    // Check if the content is longer than the maximum length
    bool isLongContent = widget.content.length > maxLength;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: widget.titleColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isExpanded || !isLongContent
                    ? widget.content
                    : widget.content.substring(0, maxLength) + '...',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.black87,
                  ),
                ),
                textAlign: TextAlign.justify,
              ),
              if (isLongContent) // Show button only if content is long
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Thu gọn' : 'Xem thêm',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

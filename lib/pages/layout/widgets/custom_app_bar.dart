import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final VoidCallback? onMorePressed;
  final double? toolbarHeight;
  final double? marginLeft;
  final Widget? child;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.onMorePressed, this.child, this.toolbarHeight, this.marginLeft,
  });

  @override
  Widget build(BuildContext context) {
    int length = title.length;
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 80.0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        height: toolbarHeight ?? 100.0,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30.0),
            bottomRight: Radius.circular(30.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade900.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: marginLeft ?? 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                onBackPressed == null
                    ? SizedBox(
                        width: 48.0,
                )
                    :
                IconButton(
                  icon: const Icon(Icons.arrow_back,
                      color: Colors.white, size: 20),
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                ),
                IntrinsicWidth(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          length > 20 ? '${title.substring(0,15)}...' : title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          softWrap: true,
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: child ?? SizedBox.shrink()),
                onMorePressed == null
                    ? SizedBox.shrink()
                    : IconButton(
                        icon: const Icon(Icons.more_vert,
                            color: Colors.white, size: 28),
                        onPressed: onMorePressed,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80.0);
}

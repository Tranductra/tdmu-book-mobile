import 'package:flutter/material.dart';
import 'package:tdmubook/pages/home/views/add_post_page.dart';
import 'package:tdmubook/pages/home/views/connect_livestream_page.dart';

import 'add_reel_page.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  late PageController pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  onPageChanged(int page) {
    if (mounted) {
      setState(() {
        _currentIndex = page;
      });
    }
  }

  navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: pageController,
              onPageChanged: onPageChanged,
              children: [
                AddPostPage(),
                AddReelPage(),
                ConnectLivestreamPage(),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              bottom: 10,
              child: Container(
                width: 250,
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  color: Colors.blueAccent.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        navigationTapped(0);
                      },
                      child: Text(
                        'Hình ảnh',
                        style: TextStyle(
                          fontSize: _currentIndex == 0 ? 20 : 15,
                          fontWeight: FontWeight.w500,
                          color:
                              _currentIndex == 0 ? Colors.white : Colors.white54,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationTapped(1);
                      },
                      child: Text(
                        'Video',
                        style: TextStyle(
                          fontSize: _currentIndex == 1 ? 20 : 15,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 1
                              ? Colors.white
                              : Colors.white54,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        navigationTapped(2);
                      },
                      child: Text(
                        'Live stream',
                        style: TextStyle(
                          fontSize: _currentIndex == 2 ? 20 : 15,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 2
                              ? Colors.white
                              : Colors.white54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

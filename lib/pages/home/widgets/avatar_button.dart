import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AvatarButton extends StatefulWidget {
  const AvatarButton({super.key});

  @override
  _AvatarButtonState createState() => _AvatarButtonState();
}

class _AvatarButtonState extends State<AvatarButton>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTapDown: _onTapDown,
      onTapUp: (details) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(16),
              alignment: Alignment.topCenter,
              content: _buildAlertDialogContent(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            );
          },
        );
      },

      child: Container(
        padding: const EdgeInsets.all(4),
        margin: const EdgeInsets.only(right: 16),
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
    );
  }

  Widget _buildAlertDialogContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeaderSection(),
        SizedBox(height: 8),
        _buildButtonProfile(),
        SizedBox(height: 8),
        Flexible(
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shrinkWrap: true,
            children: [
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.login_outlined),
                        SizedBox(width: 8),
                        Text('Đăng xuất'),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  // Your navigation code here
                },
              ),
              Divider(),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 8),
                        Text('Cài đặt'),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onTap: () {
                  // Your navigation code here
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
          .copyWith(right: 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: SvgPicture.asset(
              'assets/images/home/feed/avatar_user.svg',
              height: 32,
              width: 32,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Trần Đức Trà',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonProfile() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Color(0xff00B389),
          width: 1,
        ),
      ),
      child: Text(
        'Xem trang cá nhân',
        style: TextStyle(
            color: Color(0xff00B389),
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
    );
  }
}

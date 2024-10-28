import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tdmubook/pages/layout/widgets/custom_app_bar.dart';
import 'package:tdmubook/shared/constants/launch.dart';

class TrainingPortalPage extends StatelessWidget {
  const TrainingPortalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Cổng thông tin đào tạo',
        onBackPressed: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SvgPicture.asset(
                  'assets/images/login/logo_tdmu.svg',
                  color: Color(0xff6610f2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Khi nhập học sinh viên được Trường cung cấp tài khoản để đăng nhập vào hệ thống website của Trường. Sinh viên được xem các thông tin về đào tạo thông qua hệ thống này.',
                style: TextStyle(fontSize: 18, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.language, color: Colors.blueAccent),
                      title: Text(
                        'Cổng thông tin đào tạo',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.link, color: Colors.blueAccent),
                      title: Text('https://daa.tdmu.edu.vn/'),
                      onTap: () => launchURL('https://daa.tdmu.edu.vn/'),
                    ),
                    ListTile(
                      leading: Icon(Icons.link, color: Colors.blueAccent),
                      title: Text('https://dkmh.tdmu.edu.vn/'),
                      onTap: () => launchURL('https://dkmh.tdmu.edu.vn/'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.blueAccent),
                      title: Text(
                        'Địa chỉ hộp thư đào tạo:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.mail_outline, color: Colors.blueAccent),
                      title: Text('phongdaotao@tdmu.edu.vn'),
                      onTap: () => launchURL('mailto:phongdaotao@tdmu.edu.vn'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.blueAccent),
                      title: Text(
                        'Điện thoại liên lạc:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.call, color: Colors.blueAccent),
                      title: Text('(0274) 3834518 (Ext 110)'),
                      onTap: () => launchURL('tel:(0274) 3834518'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Khi gặp các khó khăn về đăng ký học phần hoặc thắc mắc về lịch học hay đóng góp ý kiến cho Nhà trường về hoạt động đào tạo, sinh viên gửi thông tin về hộp thư đào tạo. Trong trường hợp cấp thiết, sinh viên gọi về đường dây điện thoại trên.',
                style: TextStyle(fontSize: 18, height: 1.5),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading:
                          Icon(Icons.description, color: Colors.blueAccent),
                      title: Text(
                        'Các văn bản về đào tạo và hệ thống biểu mẫu được đăng tải tại:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.link, color: Colors.blueAccent),
                      title: Text('https://daa.tdmu.edu.vn/bieu-mau/5'),
                      onTap: () =>
                          launchURL('https://daa.tdmu.edu.vn/bieu-mau/5'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

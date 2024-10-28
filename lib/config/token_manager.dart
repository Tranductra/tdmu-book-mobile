import 'package:get/get.dart';

class TokenManager extends GetxController {
  final RxString _bearToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InBoYW4ubnZAb3J5emEudm4iLCJpZCI6IjI0ZmI4N2U0LTlkYWMtNDliNy04NWQ0LTFhOTY2ZjA4YzVmMyIsInBob25lIjoiMDMzODMxMzI2MiIsInJmX3Rva2VuIjoiOTEwMDcxNWMtZTg0Zi00MWNkLWE5N2UtN2E3NzM4ZGQ0YTEwIiwiaWF0IjoxNzI0NzIyNTA0LCJleHAiOjE3MjY1MzM2MjY1MDN9.c4n0BO6Sie5efBazaG6bx0mSsIyfR54y8WLwM1HO_zg'
          .obs;

  String get bearToken => _bearToken.value;
  set bearToken(String value) => _bearToken.value = value;
}

const String uRL = 'http://192.168.103.79:3003';
final tokenManager = TokenManager();

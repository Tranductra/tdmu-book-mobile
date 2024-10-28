import 'package:intl/intl.dart';
import 'package:tdmubook/pages/guest/notifications/models/guest_notification.dart';

String formatDateAPI(String dateStr) {
  // Parse the input date string
  DateTime parsedDate =
      DateFormat("yyyy-MM-dd HH:mm:ss.SSS").parse(dateStr, true);

  // Format the parsed date to the desired format
  String formattedDate =
      DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(parsedDate.toUtc());

  return formattedDate;
}

String formatDate(String dateStr) {
  final dateTime = DateTime.parse(dateStr);
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

String formatDateTime(String dateStr) {
  final dateTime = DateTime.parse(dateStr).add(Duration(hours: 7));
  return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
}

DateTime parseDate(String dateString) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  return formatter.parse(dateString);
}

String formatDateTimePost(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 60) {
    return '${difference.inMinutes} phút trước';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} giờ trước';
  } else if (difference.inDays == 1) {
    return 'Hôm qua';
  } else if (difference.inDays <= 2) {
    return '${difference.inDays} ngày trước';
  } else {
    return DateFormat('dd/MM/yyyy HH:mm', 'vi_VN').format(dateTime);
  }
}

String formatTimestamp(DataPublished timestamp) {
  // Lấy số giây từ timestamp
  int seconds = timestamp.iSeconds!;
  // Tạo đối tượng DateTime từ số giây
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);

  // Định dạng ngày giờ theo mong muốn
  return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}';
}

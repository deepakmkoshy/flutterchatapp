import 'package:permission_handler/permission_handler.dart';

Future<void> getPermissions() async {
  await Permission.microphone.request();
}

import 'package:chatapp/constants/users.dart';
import 'package:chatapp/models/user_model.dart';

String getPhotoURL(String userId) {
  UserModel user = users.firstWhere((element) => element.userId == userId);
  return user.photoURL;
}

String getName(String userId) {
  UserModel user = users.firstWhere((element) => element.userId == userId);
  return user.name;
}

import 'package:hive/hive.dart';
import '../models/user_profile_model.dart';
import '../../core/utils/database_service.dart';

class UserLocalDataSource {
  static const String userKey = 'current_user';

  Future<UserProfileModel?> getUserProfile() async {
    final box = await DatabaseService.getUserProfileBox();
    final jsonData = box.get(userKey);
    if (jsonData != null) {
      return UserProfileModel.fromJson(Map<String, dynamic>.from(jsonData));
    }
    return null;
  }

  Future<void> saveUserProfile(UserProfileModel profile) async {
    final box = await DatabaseService.getUserProfileBox();
    await box.put(userKey, profile.toJson());
  }

  Future<void> deleteUserProfile() async {
    final box = await DatabaseService.getUserProfileBox();
    await box.delete(userKey);
  }
}

import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  static const String userProfileBox = 'user_profile';
  static const String dailyLogsBox = 'daily_logs';
  static const String favoriteFoodsBox = 'favorite_foods';
  static const String customRecipesBox = 'custom_recipes';

  static Future<void> init() async {
    await Hive.initFlutter();
  }

  static Future<Box> getUserProfileBox() async {
    if (!Hive.isBoxOpen(userProfileBox)) {
      return await Hive.openBox(userProfileBox);
    }
    return Hive.box(userProfileBox);
  }

  static Future<Box> getDailyLogsBox() async {
    if (!Hive.isBoxOpen(dailyLogsBox)) {
      return await Hive.openBox(dailyLogsBox);
    }
    return Hive.box(dailyLogsBox);
  }

  static Future<Box> getFavoriteFoodsBox() async {
    if (!Hive.isBoxOpen(favoriteFoodsBox)) {
      return await Hive.openBox(favoriteFoodsBox);
    }
    return Hive.box(favoriteFoodsBox);
  }

  static Future<Box> getCustomRecipesBox() async {
    if (!Hive.isBoxOpen(customRecipesBox)) {
      return await Hive.openBox(customRecipesBox);
    }
    return Hive.box(customRecipesBox);
  }

  static Future<void> closeAll() async {
    await Hive.close();
  }
}

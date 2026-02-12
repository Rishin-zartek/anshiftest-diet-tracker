import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../models/daily_log_model.dart';
import '../../core/utils/database_service.dart';

class LogLocalDataSource {
  String _getDateKey(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  Future<DailyLogModel?> getDailyLog(DateTime date) async {
    final box = await DatabaseService.getDailyLogsBox();
    final key = _getDateKey(date);
    final jsonData = box.get(key);
    if (jsonData != null) {
      return DailyLogModel.fromJson(Map<String, dynamic>.from(jsonData));
    }
    return null;
  }

  Future<void> saveDailyLog(DailyLogModel log) async {
    final box = await DatabaseService.getDailyLogsBox();
    final key = _getDateKey(log.date);
    await box.put(key, log.toJson());
  }

  Future<List<DailyLogModel>> getLogsInRange(DateTime start, DateTime end) async {
    final box = await DatabaseService.getDailyLogsBox();
    final List<DailyLogModel> logs = [];
    
    for (var date = start; date.isBefore(end) || date.isAtSameMomentAs(end); date = date.add(const Duration(days: 1))) {
      final key = _getDateKey(date);
      final jsonData = box.get(key);
      if (jsonData != null) {
        logs.add(DailyLogModel.fromJson(Map<String, dynamic>.from(jsonData)));
      }
    }
    
    return logs;
  }

  Future<void> deleteDailyLog(DateTime date) async {
    final box = await DatabaseService.getDailyLogsBox();
    final key = _getDateKey(date);
    await box.delete(key);
  }
}

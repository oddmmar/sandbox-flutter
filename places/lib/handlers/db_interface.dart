import 'package:places/handlers/sql_handler.dart';

abstract class DbHandler {
  factory DbHandler() => SqlHandler();

  Future<void> insert({
    required String table,
    required Map<String, Object> data,
  });

  Future<List<Map<String, dynamic>>> getData({
    required String table,
  });
}

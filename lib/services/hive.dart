import 'package:hive_flutter/hive_flutter.dart';

class HiveServices {
  Future<void> initHive() async {
    await Hive.initFlutter();
    await Hive.openBox('splash');
  }

  Future<void> setSplash() async {
    final box = Hive.box('splash');
    await box.put('set', true);
  }

  Future<void> remove() async {
    final box = Hive.box('splash');
    await box.delete('set');
  }

  bool isSet() {
    final box = Hive.box('splash');
    return box.containsKey('set');
  }
}

HiveServices hiveServices = HiveServices();

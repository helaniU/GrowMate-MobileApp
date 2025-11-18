import 'notification_manager.dart';

class WaterSupplyMonitor {
  double waterLevel;        // <-- now mutable
  DateTime lastWatered;     // <-- now mutable
  String schedule;

  WaterSupplyMonitor({
    required this.waterLevel,
    DateTime? lastWatered,
    this.schedule = '',
  }) : lastWatered = lastWatered ?? DateTime.now();

  bool needsWater({double threshold = 30.0}) => waterLevel < threshold;

  void sendWaterAlert(NotificationManager nm, User user, Plant plant) {
    final msg =
        'Plant "${plant.plantName}" needs watering (level: ${waterLevel.toStringAsFixed(1)}%).';
    nm.sendNotification(user, type: 'warning', message: msg);
  }

  @override
  String toString() =>
      'Water(level: ${waterLevel.toStringAsFixed(1)}%, last: $lastWatered, schedule: $schedule)';
}

class Plant {
  final String plantName;
  Plant(this.plantName);
}

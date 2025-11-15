import 'notification_manager.dart';

class WaterSupplyMonitor {
  final double waterLevel; // percentage (0 - 100)
  final DateTime lastWatered;
  final String schedule; // e.g. 'Every 3 days'

  WaterSupplyMonitor({
    required this.waterLevel,
    DateTime? lastWatered,
    this.schedule = '',
  }) : lastWatered = lastWatered ?? DateTime.now();

  // return true if plant likely needs water (simple threshold logic)
  bool checkWaterNeeds({double threshold = 30.0}) {
    return waterLevel < threshold;
  }

  void sendWaterAlert(NotificationManager nm, User user, Plant plant) {
    final msg =
        'Plant "${plant.plantName}" needs watering (level: ${waterLevel.toStringAsFixed(1)}%).';
    nm.sendNotification(
      user,
      type: 'warning',
      message: msg,
    );
  }

  @override
  String toString() =>
      'Water(level: ${waterLevel.toStringAsFixed(1)}%, last: $lastWatered, schedule: $schedule)';
}

// Example Plant class (to make it compile)
class Plant {
  final String plantName;
  Plant(this.plantName);
}

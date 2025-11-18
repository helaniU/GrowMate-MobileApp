import 'plant_model.dart';
import 'user.dart';

class Dashboard {
  String dashboardId;
  List<Plant> plantData;

  Dashboard({
    required this.dashboardId,
    required this.plantData,
  });

  void displayMonitors([User? user]) {
    print('\n[Dashboard] Displaying monitors for ${user?.name ?? 'All users'}');

    for (var p in plantData) {
      print('--- ${p.plantName} ---');
      print('Location: ${p.location}');
      print('Health: ${p.healthStatus}');
      print('Water Level: ${p.waterMonitor.waterLevel}');
      print('Last Watered: ${p.waterMonitor.lastWatered}');
      print('Sunlight Hours: ${p.sunlightMonitor.sunlightHours}');
      print('Optimal Sunlight: ${p.sunlightMonitor.optimalHours}');
      print('Nutrient Level: ${p.nutritionMonitor.nutrientLevel}');
    }
  }

  void showHistoricalLogs() {
    print('[Dashboard] Historical logs are not implemented in this demo.');
  }
}

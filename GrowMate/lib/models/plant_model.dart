import 'water_monitor_model.dart';
import 'sunlight_monitor_model.dart';
import 'nutrition_model.dart';

class Plant {
  String plantId;
  String plantName;
  String location;
  String healthStatus;

  WaterSupplyMonitor waterMonitor;
  SunlightMonitor sunlightMonitor;
  NutritionMonitor nutritionMonitor;

  Plant({
    required this.plantId,
    required this.plantName,
    required this.location,
    this.healthStatus = 'Unknown',
    required this.waterMonitor,
    required this.sunlightMonitor,
    required this.nutritionMonitor,
  });

  void updateHealthStatus() {
    healthStatus = 'Healthy';
    print("[Plant] $plantName health updated -> $healthStatus");
  }

  String getPlantProfile() {
    return "Plant: $plantName | Location: $location | Status: $healthStatus";
  }
}

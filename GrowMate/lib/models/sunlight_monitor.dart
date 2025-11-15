class SunlightMonitor {
double sunlightHours; // measured during the day
double optimalHours;


SunlightMonitor({required this.sunlightHours, this.optimalHours = 6.0});


// Simple tracking method (would be replaced by sensor data in a real app)
void trackSunlight(double newHours) {
sunlightHours = newHours;
}


String suggestPlacement() {
if (sunlightHours < optimalHours) return 'Move to brighter spot.';
return 'Placement OK.';
}


@override
String toString() => 'Sunlight(hours: ${sunlightHours.toStringAsFixed(1)}/${optimalHours})';
}
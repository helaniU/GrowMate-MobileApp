class SunlightMonitor {
  // Measured sunlight hours during the day
  double sunlightHours;

  // Optimal sunlight hours for the plant
  final double optimalHours;

  // Optional: track history (could be useful for charts or analytics later)
  final List<double> _history = [];

  SunlightMonitor({required this.sunlightHours, this.optimalHours = 6.0});

  /// Update sunlight hours and save to history
  void trackSunlight(double newHours) {
    sunlightHours = newHours;
    _history.add(newHours);
  }

  /// Returns a simple suggestion based on sunlight hours
  String suggestPlacement() {
    if (sunlightHours < optimalHours) return 'Move to a brighter spot 🌞';
    if (sunlightHours > optimalHours * 1.2) return 'Consider some shade 🌿';
    return 'Placement is optimal ✅';
  }

  /// Returns a ratio of current sunlight vs optimal (0.0 to 1.0)
  double sunlightRatio() => (sunlightHours / optimalHours).clamp(0.0, 1.0);

  /// Returns a summary string
  @override
  String toString() =>
      'Sunlight(hours: ${sunlightHours.toStringAsFixed(1)} / $optimalHours)';

  /// Optional: get history (read-only)
  List<double> get history => List.unmodifiable(_history);
}

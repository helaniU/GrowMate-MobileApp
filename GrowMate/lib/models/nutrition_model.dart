class NutritionMonitor {
String nutrientLevel; // e.g. 'low', 'optimal', 'high'


NutritionMonitor({this.nutrientLevel = 'unknown'});


String assessNutrition() {
// simple mapping; replace with numeric checks if you have data
return nutrientLevel;
}


String recommendFertilizer() {
if (nutrientLevel == 'low') return 'Use balanced NPK fertilizer once a month.';
if (nutrientLevel == 'optimal') return 'No fertilizer needed.';
return 'Test soil or monitor frequently.';
}


@override
String toString() => 'Nutrition(level: $nutrientLevel)';
}
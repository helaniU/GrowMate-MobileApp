import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// Model
class NutritionMonitor {
  String nutrientLevel; // 'low', 'optimal', 'high'
  int nitrogen, phosphorus, potassium; // example numeric levels

  NutritionMonitor({
    this.nutrientLevel = 'unknown',
    this.nitrogen = 50,
    this.phosphorus = 50,
    this.potassium = 50,
  });

  String assessNutrition() => nutrientLevel;

  String recommendFertilizer() {
    if (nutrientLevel == 'low') return 'Use balanced NPK fertilizer once a month.';
    if (nutrientLevel == 'optimal') return 'No fertilizer needed.';
    return 'Test soil or monitor frequently.';
  }

  @override
  String toString() => 'Nutrition(level: $nutrientLevel)';
}

// Page
class NutritionMonitorPage extends StatelessWidget {
  final NutritionMonitor nutrition = NutritionMonitor(
      nutrientLevel: 'low', nitrogen: 35, phosphorus: 60, potassium: 45);

  NutritionMonitorPage({super.key});

  Color getColor(int value) {
    if (value < 40) return Colors.red;
    if (value < 70) return Colors.yellow.shade700;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Monitor'),
        backgroundColor: const Color(0xFF98FF98),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant Health Score
            Center(
              child: CircularPercentIndicator(
                radius: 80,
                lineWidth: 12,
                percent: ((nutrition.nitrogen + nutrition.phosphorus + nutrition.potassium) / 300),
                center: Text(
                  'Health\n${((nutrition.nitrogen + nutrition.phosphorus + nutrition.potassium)/3).round()}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 24),

            // Nutrient Cards
            Text('Macro Nutrients', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                nutrientCard('Nitrogen', nutrition.nitrogen),
                nutrientCard('Phosphorus', nutrition.phosphorus),
                nutrientCard('Potassium', nutrition.potassium),
              ],
            ),
            const SizedBox(height: 24),

            // Fertilizer Recommendation
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Fertilizer Recommendation', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(nutrition.recommendFertilizer()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nutrition History Chart (mock data)
            Text('Nutrition History', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: LineChart(LineChartData(
                borderData: FlBorderData(show: true),
                gridData: FlGridData(show: true),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                      return Text('Day ${value.toInt()}');
                    }),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, nutrition.nitrogen.toDouble()),
                      FlSpot(1, 45),
                      FlSpot(2, 50),
                      FlSpot(3, 55),
                      FlSpot(4, nutrition.nitrogen.toDouble()),
                    ],
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.blue, // <-- use 'color' instead of 'colors'
                    dotData: FlDotData(show: true),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for nutrient card
  Widget nutrientCard(String title, int value) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Container(
              height: 10,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(5),
              ),
              child: FractionallySizedBox(
                widthFactor: value / 100,
                child: Container(
                  decoration: BoxDecoration(
                    color: getColor(value),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text('$value%', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

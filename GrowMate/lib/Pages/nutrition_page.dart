import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'sunlight_monitor_page.dart';
import 'water_monitor_page.dart';
import 'plant_page.dart';

class NutritionMonitor {
  String nutrientLevel;
  int nitrogen, phosphorus, potassium;

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
}

class NutritionMonitorPage extends StatefulWidget {
  final String plantName;
  final String plantImage;
  final NutritionMonitor nutrition;

  const NutritionMonitorPage({
    super.key,
    required this.plantName,
    required this.plantImage,
    required this.nutrition,
  });

  @override
  State<NutritionMonitorPage> createState() => _NutritionMonitorPageState();
}

class _NutritionMonitorPageState extends State<NutritionMonitorPage> {
  int _selectedIndex = 3; // Nutrients page

  void _onNavItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlantPage(
              plantName: widget.plantName,
              plantImage: widget.plantImage,
            ),
          ),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => WaterMonitorPage(
              plantName: widget.plantName,
              plantImage: widget.plantImage,
            ),
          ),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => SunlightMonitorPage(
              plantName: widget.plantName,
              plantImage: widget.plantImage,
            ),
          ),
        );
        break;
      case 3:
        break;
    }
  }

  Color getNutrientColor(String nutrient) {
    switch (nutrient) {
      case 'Nitrogen':
        return Colors.blue;
      case 'Phosphorus':
        return Colors.orange;
      case 'Potassium':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Color _getSelectedColor(int index) {
    switch (index) {
      case 0:
        return Colors.green.shade700;
      case 1:
        return Colors.blue.shade700;
      case 2:
        return Colors.yellow.shade700;
      case 3:
        return Colors.brown.shade700;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (widget.plantImage.endsWith('.png') || widget.plantImage.endsWith('.jpg')) {
      imageProvider = AssetImage(widget.plantImage);
    } else {
      imageProvider = FileImage(File(widget.plantImage));
    }

    final total = widget.nutrition.nitrogen +
        widget.nutrition.phosphorus +
        widget.nutrition.potassium;
    final healthPercent = (total / 300);

    return Scaffold(
      backgroundColor: const Color(0xFFF9FFF5),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.brown.shade500, Colors.brown.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Nutrition Monitor',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Courier',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Plant Image
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image(
                  image: imageProvider,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Health Score
            Center(
              child: CircularPercentIndicator(
                radius: 80,
                lineWidth: 12,
                percent: healthPercent,
                center: Text(
                  'Health\n${(total / 3).round()}%',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey.shade200,
                animation: true,
                animationDuration: 800,
              ),
            ),
            const SizedBox(height: 24),

            // Nutrient Cards
            Text(
              'Macro Nutrients',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700, // Set text color to brown
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                nutrientCard('Nitrogen', widget.nutrition.nitrogen),
                nutrientCard('Phosphorus', widget.nutrition.phosphorus),
                nutrientCard('Potassium', widget.nutrition.potassium),
              ],
            ),
            const SizedBox(height: 24),

            // Fertilizer Recommendation
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [Colors.brown.shade200, Colors.brown.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.eco, size: 40, color: Colors.brown),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.nutrition.recommendFertilizer(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nutrition History Chart
            Text(
              'Nutrition History',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade700, // Set text color to brown
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  borderData: FlBorderData(
                    show: true,
                    border: const Border(
                      bottom: BorderSide(color: Colors.grey),
                      left: BorderSide(color: Colors.grey),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) => Text('Day ${value.toInt()}'),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        FlSpot(0, widget.nutrition.nitrogen.toDouble()),
                        FlSpot(1, widget.nutrition.phosphorus.toDouble()),
                        FlSpot(2, widget.nutrition.potassium.toDouble()),
                        FlSpot(3, widget.nutrition.nitrogen.toDouble()),
                        FlSpot(4, widget.nutrition.phosphorus.toDouble()),
                      ],
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.orange, Colors.green],
                      ),
                      barWidth: 4,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                          radius: 5,
                          color: spot.y < 40
                              ? Colors.red
                              : spot.y < 70
                              ? Colors.yellow
                              : Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        selectedItemColor: _getSelectedColor(_selectedIndex),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Details',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.water_drop),
            label: 'Water',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
            label: 'Sunlight',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Nutrients',
          ),
        ],
      ),
    );
  }

  Widget nutrientCard(String title, int value) {
    Color color = getNutrientColor(title);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Container(
        width: 110,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              title == 'Nitrogen'
                  ? Icons.water_drop
                  : title == 'Phosphorus'
                  ? Icons.bolt
                  : Icons.grass,
              size: 28,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Stack(
              children: [
                Container(
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: value / 100,
                  child: Container(
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color.withOpacity(0.7), color],
                      ),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '$value%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

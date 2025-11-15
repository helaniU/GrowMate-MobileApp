import 'package:flutter/material.dart';

class NutritionMonitorPage extends StatelessWidget {
  const NutritionMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nutrition Monitor'), backgroundColor: const Color(0xFF98FF98)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text('Nutrition monitoring (demo)', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Show nutrient levels, fertilizer suggestions, and history.'),
          ],
        ),
      ),
    );
  }
}

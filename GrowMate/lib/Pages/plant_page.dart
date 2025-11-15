import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantPage extends StatelessWidget {
  const PlantPage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF1B5E20);
    final plant = ModalRoute.of(context)?.settings.arguments as Plant?;

    return Scaffold(
      appBar: AppBar(title: const Text('Plant Details'), backgroundColor: const Color(0xFF98FF98)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: plant == null
            ? const Center(child: Text('No plant selected.'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(plant.plantName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: darkGreen)),
            const SizedBox(height: 8),
            Text('Location: ${plant.location}'),
            const SizedBox(height: 8),
            Text('Health: ${plant.healthStatus}'),
            const SizedBox(height: 12),
            Text('Water: ${plant.waterMonitor.waterLevel.toStringAsFixed(1)}%'),
            Text('Last watered: ${plant.waterMonitor.lastWatered}'),
            const SizedBox(height: 8),
            Text('Sunlight: ${plant.sunlightMonitor.sunlightHours}h'),
            Text('Optimal sunlight: ${plant.sunlightMonitor.optimalHours}h'),
            const SizedBox(height: 8),
            Text('Nutrients: ${plant.nutritionMonitor.nutrientLevel}'),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF98FF98), foregroundColor: darkGreen),
              onPressed: () {
                // Example: send watering alert or take action
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Action sent (demo)')));
              },
              child: const Text('Take Action'),
            )
          ],
        ),
      ),
    );
  }
}


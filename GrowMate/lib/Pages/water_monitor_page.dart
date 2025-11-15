import 'package:flutter/material.dart';

class WaterMonitorPage extends StatelessWidget {
  const WaterMonitorPage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF1B5E20);
    return Scaffold(
      appBar: AppBar(title: const Text('Water Monitor'), backgroundColor: const Color(0xFF98FF98)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Text('Water monitor overview (demo)', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('Show sensor values, set schedules, and trigger alerts from here.'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // <-- Add this in pubspec.yaml (fl_chart: ^0.68.0 or latest)

class SunlightMonitorPage extends StatefulWidget {
  const SunlightMonitorPage({super.key});

  @override
  State<SunlightMonitorPage> createState() => _SunlightMonitorPageState();
}

class _SunlightMonitorPageState extends State<SunlightMonitorPage> {
  // Example plant list
  final List<String> plants = ['Rose', 'Sunflower', 'Aloe Vera', 'Tulip', 'Cactus'];

  String? selectedPlant;
  double sunlightHours = 0.0;
  final TextEditingController _controller = TextEditingController();

  // Ideal sunlight hours for healthy growth
  final double idealHours = 6.0;

  @override
  Widget build(BuildContext context) {
    double ratio = (sunlightHours / idealHours).clamp(0.0, 1.0);
    String sunlightStatus = sunlightHours < idealHours
        ? 'Low Sunlight'
        : 'High Sunlight';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sunlight Monitor'),
        backgroundColor: const Color(0xFF98FF98),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar with dropdown
            Autocomplete<String>(
              optionsBuilder: (TextEditingValue value) {
                if (value.text.isEmpty) {
                  return const Iterable<String>.empty();
                }
                return plants.where((plant) =>
                    plant.toLowerCase().contains(value.text.toLowerCase()));
              },
              onSelected: (String selection) {
                setState(() => selectedPlant = selection);
              },
              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Search Plant',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.search),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            if (selectedPlant != null) ...[
              Text('Selected Plant: $selectedPlant',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),

              const SizedBox(height: 20),

              // 🌞 Input sunlight hours
              TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Enter sunlight hours (e.g. 5.5)',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      setState(() {
                        sunlightHours = double.tryParse(_controller.text) ?? 0.0;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🌡️ Display status (Low / High)
              Center(
                child: Text(
                  sunlightStatus,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: sunlightHours < idealHours ? Colors.orange : Colors.green,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🟢 Donut Chart
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    centerSpaceRadius: 50,
                    sections: [
                      PieChartSectionData(
                        value: ratio * 100,
                        color: Colors.yellow.shade600,
                        title: '${(ratio * 100).toStringAsFixed(1)}%',
                        radius: 60,
                        titleStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      PieChartSectionData(
                        value: (1 - ratio) * 100,
                        color: Colors.grey.shade300,
                        title: '',
                        radius: 60,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),
              Center(
                child: Text(
                  'Sunlight Coverage: ${sunlightHours.toStringAsFixed(1)} / $idealHours hours',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../models/water_monitor_model.dart';
import '../models/notification_manager.dart';
import 'sunlight_monitor_page.dart';
import 'nutrition_page.dart';
import 'plant_page.dart';

class WaterMonitorPage extends StatefulWidget {
  final String plantName;
  final String plantImage;

  const WaterMonitorPage({
    super.key,
    required this.plantName,
    required this.plantImage,
  });

  @override
  State<WaterMonitorPage> createState() => _WaterMonitorPageState();
}

class _WaterMonitorPageState extends State<WaterMonitorPage> {
  int _selectedIndex = 1; // Water page index
  final User demoUser = User('Helani');

  late WaterSupplyMonitor monitor;

  @override
  void initState() {
    super.initState();
    // Initialize monitor with default values
    monitor = WaterSupplyMonitor(
      waterLevel: 45,
      schedule: 'Every 3 days',
      lastWatered: DateTime.now(),
    );
  }

  // Bottom navigation handler
  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

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
        break; // Already on Water page
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NutritionMonitorPage(
              plantName: widget.plantName,
              plantImage: widget.plantImage,
              nutrition: NutritionMonitor(
                nutrientLevel: 'low',
                nitrogen: 40,
                phosphorus: 60,
                potassium: 50,
              ),
            ),
          ),
        );

        break;
    }
  }

  // Color for selected nav item
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

  // Calculate next watering date
  DateTime getNextWatering(DateTime lastWatered, String schedule) {
    int days = 0;
    if (schedule.contains('day')) {
      days = int.parse(RegExp(r'\d+').firstMatch(schedule)!.group(0)!);
    } else if (schedule.contains('Weekly')) {
      days = 7;
    }
    return lastWatered.add(Duration(days: days));
  }

  // Progress color based on water level
  Color getProgressColor(double percent) {
    if (percent < 0.3) return Colors.red.shade400;
    if (percent < 0.7) return Colors.yellow.shade700;
    return Colors.blue.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final double progress = monitor.waterLevel / 100;
    final Color progressColor = getProgressColor(progress);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade600, Colors.blue.shade300],
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
        title: Text(
          'Water Monitor',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Courier',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Top Row: Plant Image & Name
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.plantImage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.plantName,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Water Progress
                CircularPercentIndicator(
                  radius: 120,
                  lineWidth: 12,
                  percent: progress,
                  center: Text(
                    '${monitor.waterLevel.toInt()}%',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  progressColor: progressColor,
                  backgroundColor: Colors.grey[200]!,
                  animation: true,
                ),
                const SizedBox(height: 20),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        final nm = NotificationManager();
                        monitor.sendWaterAlert(
                            nm, demoUser, Plant(widget.plantName));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Water alert sent!')),
                        );
                      },
                      icon: const Icon(Icons.notifications_active),
                      label: const Text('Send Alert'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          monitor.lastWatered = DateTime.now();
                          monitor.waterLevel = 100;
                        });
                      },
                      icon: const Icon(Icons.water_drop),
                      label: const Text('Water Now'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreenAccent[600],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Bottom info
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Last Watered: ${monitor.lastWatered.toLocal()}'
                            .split(' ')[0],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Next Watering: ${getNextWatering(monitor.lastWatered, monitor.schedule).toLocal()}'
                            .split(' ')[0],
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Schedule: ${monitor.schedule}',
                        style:
                        const TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
            label: 'Nutrition',
          ),
        ],
      ),
    );
  }
}

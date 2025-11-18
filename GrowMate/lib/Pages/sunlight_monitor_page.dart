import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/sunlight_monitor_model.dart';
import 'water_monitor_page.dart';

class SunlightMonitorPage extends StatefulWidget {
  final String plantName;
  final dynamic plantImage; // Can be asset path (String) or File

  const SunlightMonitorPage({
    super.key,
    required this.plantName,
    required this.plantImage,
  });

  @override
  State<SunlightMonitorPage> createState() => _SunlightMonitorPageState();
}

class _SunlightMonitorPageState extends State<SunlightMonitorPage> {
  final TextEditingController _controller = TextEditingController();
  SunlightMonitor monitor = SunlightMonitor(sunlightHours: 0.0);

  int _selectedIndex = 2; // Sunlight tab

  void _onNavItemTapped(int index) {
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pop(context); // go back to Dashboard
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
        break; // Already on Sunlight
      case 3:
        Navigator.pushNamed(context, '/nutrition',
            arguments: {'plantName': widget.plantName, 'plantImage': widget.plantImage});
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
  @override
  Widget build(BuildContext context) {
    double ratio = (monitor.sunlightHours / monitor.optimalHours).clamp(0.0, 1.0);

    String sunlightStatus = monitor.sunlightHours < monitor.optimalHours
        ? 'Low Sunlight'
        : 'Optimal Sunlight';

    return Scaffold(
      backgroundColor: const Color(0xFFF2F7F1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade500, Colors.green.shade300],
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
          'Sunlight Monitor',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Courier',
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Plant Image
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: widget.plantImage is String
                  ? Image.asset(
                widget.plantImage,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              )
                  : Image.file(
                widget.plantImage,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 25),

            // Input sunlight hours
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter sunlight hours (e.g. 5.5)',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check_circle, color: Colors.green),
                  onPressed: () {
                    setState(() {
                      monitor.trackSunlight(double.tryParse(_controller.text) ?? 0.0);
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Sunlight Status
            Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                decoration: BoxDecoration(
                  color: monitor.sunlightHours < monitor.optimalHours
                      ? Colors.orange.shade100
                      : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Text(
                  sunlightStatus,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: monitor.sunlightHours < monitor.optimalHours
                        ? Colors.orange
                        : Colors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Pie Chart
            SizedBox(
              height: 230,
              child: PieChart(
                PieChartData(
                  centerSpaceRadius: 55,
                  sectionsSpace: 2,
                  sections: [
                    PieChartSectionData(
                      value: ratio * 100,
                      color: Colors.yellow.shade600,
                      title: '${(ratio * 100).toStringAsFixed(1)}%',
                      radius: 70,
                      titleStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    PieChartSectionData(
                      value: 100 - ratio * 100,
                      color: Colors.grey.shade300,
                      radius: 60,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Sunlight: ${monitor.sunlightHours.toStringAsFixed(1)} / ${monitor.optimalHours} hrs',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.green),
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
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
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
}

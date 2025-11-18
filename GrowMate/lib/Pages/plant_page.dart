import 'dart:io';
import 'package:flutter/material.dart';
import 'sunlight_monitor_page.dart';
import 'water_monitor_page.dart';
import 'nutrition_page.dart';

const darkGreen = Color(0xFF2E7D32);

class PlantPage extends StatefulWidget {
  final String plantName;
  final String plantImage; // asset path or file path

  const PlantPage({super.key, required this.plantName, required this.plantImage});

  @override
  State<PlantPage> createState() => _PlantPageState();
}

class _PlantPageState extends State<PlantPage> {
  int _selectedIndex = 0; // For bottom navigation bar

  void _onNavItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pop(context);
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NutritionMonitorPage(),
          ),
        );
        break;
    }
  }

  Widget buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: darkGreen, size: 20),
          const SizedBox(width: 12),
          Text(
            "$title: ",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine if image is asset or file
    ImageProvider imageProvider;
    if (widget.plantImage.endsWith('.png') || widget.plantImage.endsWith('.jpg')) {
      imageProvider = AssetImage(widget.plantImage);
    } else {
      imageProvider = FileImage(File(widget.plantImage));
    }

    // For demo, placeholder plant details (replace with real data if needed)
    final Map<String, String> plantDetails = {
      "id": "001",
      "species": "Ficus",
      "addedDate": "2025-11-18",
      "growthStage": "Seedling",
      "waterRecommendation": "200ml/day",
      "sunlightRecommendation": "4-6 hours/day",
      "soilType": "Loamy",
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plantName),
        backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Plant Name
            Text(
              widget.plantName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),

            const SizedBox(height: 20),

            // Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailRow(Icons.tag, "Plant ID", plantDetails["id"]!),
                  buildDetailRow(Icons.local_florist, "Species", plantDetails["species"]!),
                  buildDetailRow(Icons.calendar_today, "Added On", plantDetails["addedDate"]!),
                  buildDetailRow(Icons.auto_graph, "Growth Stage", plantDetails["growthStage"]!),
                  buildDetailRow(Icons.water_drop, "Water Need", plantDetails["waterRecommendation"]!),
                  buildDetailRow(Icons.wb_sunny, "Sunlight Need", plantDetails["sunlightRecommendation"]!),
                  buildDetailRow(Icons.landscape, "Soil Type", plantDetails["soilType"]!),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Take Action button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
              ),
              child: const Text(
                "Take Action",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        selectedItemColor: Colors.green.shade700,
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

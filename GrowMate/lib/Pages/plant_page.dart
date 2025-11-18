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
  int _selectedIndex = 0; // Bottom navigation index

  void _onNavItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pop(context); // Back to dashboard
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

    // Placeholder plant details
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: darkGreen,
                      size: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Circular Plant Image
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                  border: Border.all(color: Colors.green.shade400, width: 4),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Plant Name Box
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: darkGreen, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  widget.plantName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 30),

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

              // Take Action Button
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
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        selectedItemColor: Colors.green.shade700,
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
}

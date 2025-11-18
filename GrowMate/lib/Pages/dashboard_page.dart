import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_monitor_app/pages/plant_page.dart';
import 'dart:io';
import 'signin_page.dart';

class DashboardPage extends StatefulWidget {
  final String userName;

  const DashboardPage({super.key, required this.userName});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _plants = [
    {'name': 'Aloe Vera', 'image': 'assets/images/aloe_vera.png'},
    {'name': 'Rose', 'image': 'assets/images/rose.png'},
    {'name': 'Cactus', 'image': 'assets/images/cactus.png'},
    {'name': 'Perennial Flower', 'image': 'assets/images/perennial.png'},
  ];
  // ---------------------------------------------------------------------
// ADD NEW PLANT
// ---------------------------------------------------------------------
  void _addNewPlant() async {
    String plantId = '';
    String plantName = '';
    String species = '';
    String growthStage = 'Seedling';
    String waterNeed = 'Medium';
    String sunlightNeed = 'Medium';
    String soilType = 'Loamy';
    DateTime addedOn = DateTime.now();
    XFile? pickedImage;

    final List<String> growthStages = ['Seedling', 'Vegetative', 'Flowering', 'Fruiting'];
    final List<String> waterOptions = ['Low', 'Medium', 'High'];
    final List<String> sunlightOptions = ['Low', 'Medium', 'High'];
    final List<String> soilOptions = ['Sandy', 'Loamy', 'Clay', 'Peaty', 'Silty'];

    await showDialog(
      context: context,
      builder: (context) => Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 350,
            child: AlertDialog(
              title: const Text(
                'Add New Plant',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
              content: DefaultTextStyle(
                style: const TextStyle(color: Colors.green), // all text green by default
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Plant ID
                    TextField(
                      decoration: const InputDecoration(labelText: 'Plant ID'),
                      onChanged: (value) => plantId = value,
                    ),
                    const SizedBox(height: 8),
                    // Plant Name
                    TextField(
                      decoration: const InputDecoration(labelText: 'Plant Name'),
                      onChanged: (value) => plantName = value,
                    ),
                    const SizedBox(height: 8),
                    // Species
                    TextField(
                      decoration: const InputDecoration(labelText: 'Species'),
                      onChanged: (value) => species = value,
                    ),
                    const SizedBox(height: 8),
                    // Added On (Date Picker)
                    Row(
                      children: [
                        const Text('Added On: '),
                        TextButton(
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: addedOn,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) setState(() => addedOn = picked);
                          },
                          child: Text(
                            '${addedOn.year}-${addedOn.month}-${addedOn.day}',
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Growth Stage Dropdown
                    DropdownButtonFormField<String>(
                      value: growthStage,
                      decoration: const InputDecoration(labelText: 'Growth Stage', labelStyle: TextStyle(color: Colors.green)),
                      style: const TextStyle(color: Colors.black), // selected value black
                      items: growthStages
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => growthStage = value!,
                    ),
                    const SizedBox(height: 8),
                    // Water Need Dropdown
                    DropdownButtonFormField<String>(
                      value: waterNeed,
                      decoration: const InputDecoration(labelText: 'Water Need', labelStyle: TextStyle(color: Colors.green)),
                      style: const TextStyle(color: Colors.black),
                      items: waterOptions
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => waterNeed = value!,
                    ),
                    const SizedBox(height: 8),
                    // Sunlight Need Dropdown
                    DropdownButtonFormField<String>(
                      value: sunlightNeed,
                      decoration: const InputDecoration(labelText: 'Sunlight Need', labelStyle: TextStyle(color: Colors.green)),
                      style: const TextStyle(color: Colors.black),
                      items: sunlightOptions
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => sunlightNeed = value!,
                    ),
                    const SizedBox(height: 8),
                    // Soil Type Dropdown
                    DropdownButtonFormField<String>(
                      value: soilType,
                      decoration: const InputDecoration(labelText: 'Soil Type', labelStyle: TextStyle(color: Colors.green)),
                      style: const TextStyle(color: Colors.black),
                      items: soilOptions
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => soilType = value!,
                    ),
                    const SizedBox(height: 10),
                    // Select Image
                    ElevatedButton.icon(
                      onPressed: () async {
                        final img = await _picker.pickImage(source: ImageSource.gallery);
                        if (img != null) pickedImage = img;
                      },
                      icon: const Icon(Icons.image),
                      label: const Text('Select Image'),
                    ),
                  ],
                ),
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel', style: TextStyle(color: Colors.green)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (plantName.isEmpty || plantId.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter Plant ID and Name')),
                      );
                      return;
                    }

                    File? plantImageFile;
                    if (pickedImage != null) plantImageFile = File(pickedImage!.path);

                    setState(() {
                      _plants.add({
                        'id': plantId,
                        'name': plantName,
                        'species': species,
                        'addedOn': addedOn,
                        'growthStage': growthStage,
                        'waterNeed': waterNeed,
                        'sunlightNeed': sunlightNeed,
                        'soilType': soilType,
                        'image': plantImageFile,
                      });
                    });

                    Navigator.pop(context);
                  },
                  child: const Text('Add Plant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // ---------------------------------------------------------------------
// PLANT CARD
// ---------------------------------------------------------------------
  Widget _buildPlantCard(Map<String, dynamic> plant) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PlantPage(
              plantName: plant['name'],
              plantImage: plant['image'] is String
                  ? plant['image']
                  : (plant['image'] as File).path, // if user added from gallery
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade100,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: plant['image'] is String
                  ? Image.asset(
                plant['image'],
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              )
                  : Image.file(
                plant['image'],
                width: 110,
                height: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              plant['name'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ---------------------------------------------------------------------
  // LOGOUT
  // ---------------------------------------------------------------------
  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const SignInPage()),
    );
  }

  // ---------------------------------------------------------------------
  // UI BUILD
  // ---------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _addNewPlant,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.green.shade700,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: const Text(
            " ✙ Add New Plant",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade800,
                    Colors.green.shade500,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ${widget.userName}",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Text(
                        "Let's grow your plant 🌱",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _logout,
                    icon: const Icon(Icons.logout, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                ),
                itemCount: _plants.length,
                itemBuilder: (_, index) => _buildPlantCard(_plants[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

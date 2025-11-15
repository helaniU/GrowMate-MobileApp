import 'package:flutter/material.dart';
import 'sunlight_monitor_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<Map<String, String>> _modules = [
    {'name': 'Sunlight Monitor', 'emoji': '☀️'},
    {'name': 'Water Monitor', 'emoji': '💧'},
    {'name': 'Soil Health', 'emoji': '🌱'},
    {'name': 'Plant Growth Tracker', 'emoji': '🌿'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Garden Dashboard",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Courier',
          ),
        ),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.yellow.shade100, Colors.green.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Centered header + grid
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min, // only take required space
                  children: [
                    // Header
                    const Text(
                      "Welcome!",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontFamily: 'Courier',
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "💚 Select a module to explore your plants💚",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,

                      ),
                    ),
                    const SizedBox(height: 20),

                    // Modules grid
                    SizedBox(
                      height: 400, // adjust for number of modules
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _modules.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemBuilder: (context, index) {
                          final module = _modules[index];
                          return GestureDetector(
                            onTap: () {
                              if (module['name'] == 'Sunlight Monitor') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                      const SunlightMonitorPage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${module['name']} is coming soon!'),
                                  ),
                                );
                              }
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 6,
                              shadowColor: Colors.green.shade200,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.green.shade300,
                                      Colors.yellow.shade200
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        module['emoji']!,
                                        style: const TextStyle(fontSize: 45),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        module['name']!,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,

                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Logout button fixed at bottom
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logged out successfully!')),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              label: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

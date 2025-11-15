import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF1B5E20);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: const Color(0xFF98FF98)),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: Switch(value: true, onChanged: (_) {}),
          ),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Theme (demo)'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            subtitle: const Text('Smart Plant Monitor — Demo App'),
            onTap: () {},
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF98FF98), foregroundColor: darkGreen),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
            child: const Text('Sign Out'),
          )
        ],
      ),
    );
  }
}

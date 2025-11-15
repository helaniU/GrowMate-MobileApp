import 'package:flutter/material.dart';
import '../models/user.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app you'd pass user and show real notifications.
    final demoUser = User(name: 'Helani', email: 'helani@example.com', password: '1234');

    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'), backgroundColor: const Color(0xFF98FF98)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text('Notifications (demo)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                demoUser.receiveNotification('This is a demo notification.');
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Demo notification received')));
              },
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF98FF98), foregroundColor: const Color(0xFF1B5E20)),
              child: const Text('Trigger Demo Notification'),
            ),
            const SizedBox(height: 16),
            Text('Stored notifications: ${demoUser.notifications.length}'),
          ],
        ),
      ),
    );
  }
}

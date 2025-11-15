class NotificationManager {
  // No need to store notificationId/type/message in manager itself
  // The manager should handle sending/scheduling instead.

  void sendNotification(User user, {
    String type = 'info',
    required String message,
  }) {
    print('[Notification][$type] -> ${user.name}: $message');
    user.receiveNotification(message);
  }

  void scheduleReminder(Duration delay, void Function() callback) {
    print('[NotificationManager] Scheduling reminder in ${delay.inSeconds}s');
    Future.delayed(delay, callback);
  }
}

// Example User class (to make your code compile & work)
class User {
  final String name;

  User(this.name);

  void receiveNotification(String message) {
    print('$name received: $message');
  }
}

// Example usage
void main() {
  final manager = NotificationManager();
  final user = User('Helani');

  manager.sendNotification(user, message: 'Welcome to the app!');

  manager.scheduleReminder(Duration(seconds: 3), () {
    manager.sendNotification(user, type: 'reminder', message: 'Time to check back!');
  });
}

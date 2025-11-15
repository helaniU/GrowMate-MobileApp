class User {
  String name;
  String email;
  String password;

  List<dynamic> plants = []; // temporarily dynamic until Plant is imported
  List<String> notifications = [];
  User({
    required this.name,
    required this.email,
    required this.password,
  });

  void register() {
    print("[User] $name registered.");
  }

  void login() {
    print("[User] $name logged in.");
  }

  void addPlant(dynamic plant) {
    plants.add(plant);
    print("[User] $name added a plant: ${plant.plantName}");
  }

  void receiveNotification(String message) {
    print("[User] $name received: $message");
  }

  void viewDashboard(dynamic dashboard) {
    dashboard.displayMonitors();
    dashboard.showHistoricalLogs();
  }
}

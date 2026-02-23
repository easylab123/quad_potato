import 'package:flutter/material.dart';

void main() {
  runApp(const AnnaUniversitySWSApp());
}

class AnnaUniversitySWSApp extends StatelessWidget {
  const AnnaUniversitySWSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anna University – Single Window System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anna University – UG Admissions (SWS)'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Login", style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child:
                const Text("Register", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildFeaturesSection(),
            _buildAnnouncementSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // 🔹 Drawer Navigation
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              "SWS Navigation",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: Text("Home")),
          ListTile(leading: Icon(Icons.person_add), title: Text("Registration")),
          ListTile(leading: Icon(Icons.login), title: Text("Candidate Login")),
          ListTile(leading: Icon(Icons.list), title: Text("Choice Filling")),
          ListTile(leading: Icon(Icons.school), title: Text("Seat Allotment")),
          ListTile(leading: Icon(Icons.help), title: Text("Help Desk")),
        ],
      ),
    );
  }

  // 🔹 Hero Banner
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.blueAccent],
        ),
      ),
      child: Column(
        children: const [
          Text(
            "Single Window System for UG Admissions",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "Centralized Online Counselling for Engineering Admissions",
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🔹 Feature Cards
  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _featureCard(Icons.app_registration, "Online Registration"),
          _featureCard(Icons.lock_open, "Candidate Login"),
          _featureCard(Icons.format_list_numbered, "Choice Filling"),
          _featureCard(Icons.schedule, "Counselling Schedule"),
          _featureCard(Icons.school, "Seat Allotment"),
          _featureCard(Icons.announcement, "Rank List"),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title) {
    return SizedBox(
      width: 220,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 40, color: Colors.indigo),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Announcements
  Widget _buildAnnouncementSection() {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          Text(
            "Latest Announcements",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Rank List Published – 2025"),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Choice Filling Starts from July 15"),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("Counselling Schedule Updated"),
          ),
        ],
      ),
    );
  }

  // 🔹 Footer
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: Colors.indigo,
      padding: const EdgeInsets.all(15),
      child: const Text(
        "© Anna University | Single Window System | Government of Tamil Nadu",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

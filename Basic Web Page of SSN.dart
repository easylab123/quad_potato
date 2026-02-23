import 'package:flutter/material.dart';

void main() {
  runApp(const SSNWebApp());
}

class SSNWebApp extends StatelessWidget {
  const SSNWebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SSN College of Engineering',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: const SSNHomePage(),
    );
  }
}

class SSNHomePage extends StatelessWidget {
  const SSNHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNavBar(),
            _buildHeroSection(),
            _buildAboutSection(),
            _buildDepartmentsSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ---------------- NAVIGATION BAR ----------------
  Widget _buildNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      color: Colors.blue.shade900,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "SSN College of Engineering",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: const [
              _NavItem(title: "Home"),
              _NavItem(title: "About"),
              _NavItem(title: "Departments"),
              _NavItem(title: "Admissions"),
              _NavItem(title: "Contact"),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- HERO SECTION ----------------
  Widget _buildHeroSection() {
    return Container(
      height: 350,
      width: double.infinity,
      color: Colors.blue.shade100,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Welcome to SSN College of Engineering",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 15),
            Text(
              "Excellence in Education, Research & Innovation",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- ABOUT SECTION ----------------
  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: const [
          Text(
            "About SSN",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "SSN College of Engineering is a premier institution committed "
            "to providing high-quality technical education and fostering "
            "innovation, research, and leadership among students.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ---------------- DEPARTMENTS ----------------
  Widget _buildDepartmentsSection() {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.grey.shade200,
      child: Column(
        children: [
          const Text(
            "Departments",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 1.5,
            children: const [
              _DepartmentCard("Computer Science & Engineering"),
              _DepartmentCard("Electronics & Communication"),
              _DepartmentCard("Electrical & Electronics"),
              _DepartmentCard("Mechanical Engineering"),
              _DepartmentCard("Civil Engineering"),
              _DepartmentCard("Information Technology"),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- FOOTER ----------------
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue.shade900,
      child: const Center(
        child: Text(
          "© 2026 SSN College of Engineering | Chennai",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// ---------------- NAV ITEM ----------------
class _NavItem extends StatelessWidget {
  final String title;
  const _NavItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

// ---------------- DEPARTMENT CARD ----------------
class _DepartmentCard extends StatelessWidget {
  final String title;
  const _DepartmentCard(this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const ECITamilApp());
}

class ECITamilApp extends StatelessWidget {
  const ECITamilApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'இந்திய தேர்தல் ஆணையம்',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildHeroSection(),
            _buildVoterServices(),
            _buildElectionInfo(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      color: Colors.deepOrange.shade800,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "இந்திய தேர்தல் ஆணையம்",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: const [
              _NavItem("முகப்பு"),
              _NavItem("வாக்காளர் சேவைகள்"),
              _NavItem("தேர்தல்கள்"),
              _NavItem("உதவி"),
              _NavItem("தொடர்பு"),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- HERO SECTION ----------------
  Widget _buildHeroSection() {
    return Container(
      height: 280,
      width: double.infinity,
      color: Colors.orange.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "உங்கள் வாக்கு – உங்கள் உரிமை",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "சுதந்திரமான மற்றும் நியாயமான தேர்தலுக்கான வாக்காளர் சேவைகள்",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  // ---------------- VOTER SERVICES ----------------
  Widget _buildVoterServices() {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          const Text(
            "வாக்காளர் சேவைகள்",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 1.3,
            children: const [
              _ServiceCard(
                title: "வாக்காளர் பதிவு",
                description:
                    "புதிய வாக்காளர் அடையாள அட்டை பெற விண்ணப்பிக்கவும்.",
                icon: Icons.how_to_vote,
              ),
              _ServiceCard(
                title: "வாக்காளர் விவரங்கள் தேடல்",
                description:
                    "தேர்தல் பட்டியலில் உங்கள் பெயரை சரிபார்க்கவும்.",
                icon: Icons.search,
              ),
              _ServiceCard(
                title: "வாக்குப்பதிவு நிலையம்",
                description:
                    "உங்கள் வாக்குச்சாவடி விவரங்களை அறியவும்.",
                icon: Icons.location_on,
              ),
              _ServiceCard(
                title: "e-EPIC பதிவிறக்கம்",
                description:
                    "டிஜிட்டல் வாக்காளர் அட்டையை பதிவிறக்கம் செய்யவும்.",
                icon: Icons.download,
              ),
              _ServiceCard(
                title: "வாக்காளர் விழிப்புணர்வு",
                description:
                    "வாக்குரிமை மற்றும் கடமைகளை அறிந்துகொள்ளவும்.",
                icon: Icons.campaign,
              ),
              _ServiceCard(
                title: "புகார் பதிவு",
                description:
                    "தேர்தல் தொடர்பான புகார்களை பதிவு செய்யவும்.",
                icon: Icons.report_problem,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- ELECTION INFO ----------------
  Widget _buildElectionInfo() {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.grey.shade200,
      child: Column(
        children: const [
          Text(
            "வரவிருக்கும் தேர்தல்கள்",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "பாராளுமன்ற • சட்டமன்ற • உள்ளாட்சி தேர்தல்கள்",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // ---------------- FOOTER ----------------
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.deepOrange.shade800,
      child: const Center(
        child: Text(
          "© 2026 இந்திய தேர்தல் ஆணையம் | அதிகாரப்பூர்வ வாக்காளர் இணையதளம்",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

// ---------------- NAV ITEM ----------------
class _NavItem extends StatelessWidget {
  final String title;
  const _NavItem(this.title);

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

// ---------------- SERVICE CARD ----------------
class _ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _ServiceCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.deepOrange),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const ECIVoterApp());
}

class ECIVoterApp extends StatelessWidget {
  const ECIVoterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Election Commission of India',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'Roboto',
      ),
      home: const ECIHomePage(),
    );
  }
}

class ECIHomePage extends StatelessWidget {
  const ECIHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildHeroSection(),
            _buildVoterServices(),
            _buildPollingInfo(),
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
            "Election Commission of India",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: const [
              _NavItem("Home"),
              _NavItem("Voter Services"),
              _NavItem("Elections"),
              _NavItem("FAQs"),
              _NavItem("Contact"),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- HERO SECTION ----------------
  Widget _buildHeroSection() {
    return Container(
      height: 300,
      width: double.infinity,
      color: Colors.orange.shade100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text(
            "Your Vote. Your Voice.",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Empowering Democracy Through Free & Fair Elections",
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
            "Voter Services",
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
                title: "Voter Registration",
                description:
                    "Apply for new voter ID or update details online.",
                icon: Icons.how_to_vote,
              ),
              _ServiceCard(
                title: "Search Voter ID",
                description:
                    "Verify your name in the electoral roll.",
                icon: Icons.search,
              ),
              _ServiceCard(
                title: "Polling Station Info",
                description:
                    "Find your polling booth and election details.",
                icon: Icons.location_on,
              ),
              _ServiceCard(
                title: "Download e-EPIC",
                description:
                    "Get a digital copy of your voter ID.",
                icon: Icons.download,
              ),
              _ServiceCard(
                title: "Election Awareness",
                description:
                    "Know your rights, duties, and voting process.",
                icon: Icons.campaign,
              ),
              _ServiceCard(
                title: "Grievance Redressal",
                description:
                    "Report issues related to elections.",
                icon: Icons.report_problem,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- POLLING INFO ----------------
  Widget _buildPollingInfo() {
    return Container(
      padding: const EdgeInsets.all(40),
      color: Colors.grey.shade200,
      child: Column(
        children: const [
          Text(
            "Upcoming Elections",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "General Elections • Assembly Elections • Local Body Elections",
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
          "© 2026 Election Commission of India | Official Voter Portal",
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

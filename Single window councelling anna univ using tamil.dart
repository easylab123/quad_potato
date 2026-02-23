import 'package:flutter/material.dart';

void main() {
  runApp(const AnnaUniversityTamilSWS());
}

class AnnaUniversityTamilSWS extends StatelessWidget {
  const AnnaUniversityTamilSWS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'அண்ணா பல்கலைக்கழகம் – ஒற்றை சாளர முறை',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const HomePageTamil(),
    );
  }
}

class HomePageTamil extends StatelessWidget {
  const HomePageTamil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('அண்ணா பல்கலைக்கழகம் – UG சேர்க்கை'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("உள்நுழைவு",
                style: TextStyle(color: Colors.white)),
          ),
          TextButton(
            onPressed: () {},
            child: const Text("பதிவு",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(),
            _buildFeatures(),
            _buildAnnouncements(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // 🔹 Drawer
  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: const [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              "ஒற்றை சாளர முறை (SWS)",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
          ),
          ListTile(leading: Icon(Icons.home), title: Text("முகப்பு")),
          ListTile(
              leading: Icon(Icons.app_registration),
              title: Text("பதிவு")),
          ListTile(
              leading: Icon(Icons.login),
              title: Text("மாணவர் உள்நுழைவு")),
          ListTile(
              leading: Icon(Icons.list),
              title: Text("விருப்பத் தேர்வு")),
          ListTile(
              leading: Icon(Icons.school),
              title: Text("இருப்பு ஒதுக்கீடு")),
          ListTile(
              leading: Icon(Icons.help),
              title: Text("உதவி மையம்")),
        ],
      ),
    );
  }

  // 🔹 Hero Section
  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo, Colors.blue],
        ),
      ),
      child: Column(
        children: const [
          Text(
            "UG சேர்க்கைக்கான ஒற்றை சாளர முறை",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            "பொறியியல் கல்விக்கான மையப்படுத்தப்பட்ட ஆன்லைன் கலந்தாய்வு",
            style: TextStyle(color: Colors.white70, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // 🔹 Feature Cards
  Widget _buildFeatures() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _featureCard(Icons.app_registration, "ஆன்லைன் பதிவு"),
          _featureCard(Icons.login, "மாணவர் உள்நுழைவு"),
          _featureCard(Icons.format_list_numbered, "விருப்பத் தேர்வு"),
          _featureCard(Icons.schedule, "கலந்தாய்வு அட்டவணை"),
          _featureCard(Icons.school, "இருப்பு ஒதுக்கீடு"),
          _featureCard(Icons.announcement, "தரவரிசைப் பட்டியல்"),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title) {
    return SizedBox(
      width: 230,
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
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Announcements
  Widget _buildAnnouncements() {
    return Container(
      width: double.infinity,
      color: Colors.grey.shade100,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          Text(
            "அறிவிப்புகள்",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("2025 தரவரிசைப் பட்டியல் வெளியிடப்பட்டது"),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("விருப்பத் தேர்வு ஜூலை 15 முதல் தொடங்கும்"),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text("கலந்தாய்வு அட்டவணை புதுப்பிக்கப்பட்டது"),
          ),
        ],
      ),
    );
  }

  // 🔹 Footer
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      color: Colors.indigo,
      child: const Text(
        "© அண்ணா பல்கலைக்கழகம் | தமிழக அரசு",
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}

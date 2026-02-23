import 'package:flutter/material.dart';

void main() {
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Library Management System',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LibraryHomePage(),
    );
  }
}

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> books = [
    {
      "title": "Data Structures",
      "author": "Mark Allen",
      "issued": false,
    },
    {
      "title": "Operating Systems",
      "author": "Silberschatz",
      "issued": true,
    },
    {
      "title": "Flutter Development",
      "author": "Google",
      "issued": false,
    },
    {
      "title": "Machine Learning",
      "author": "Tom Mitchell",
      "issued": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library Management System"),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDashboard(),
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 10),
            _buildBookList(),
          ],
        ),
      ),
    );
  }

  // ---------------- DASHBOARD ----------------
  Widget _buildDashboard() {
    int totalBooks = books.length;
    int issuedBooks =
        books.where((book) => book['issued'] == true).length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _dashboardCard("Total Books", totalBooks, Icons.menu_book),
        _dashboardCard("Issued", issuedBooks, Icons.assignment_turned_in),
      ],
    );
  }

  Widget _dashboardCard(String title, int count, IconData icon) {
    return Card(
      elevation: 4,
      child: SizedBox(
        width: 150,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.indigo),
            const SizedBox(height: 8),
            Text(
              "$count",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  // ---------------- SEARCH ----------------
  Widget _buildSearchBar() {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: "Search book...",
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        setState(() {});
      },
    );
  }

  // ---------------- BOOK LIST ----------------
  Widget _buildBookList() {
    List<Map<String, dynamic>> filteredBooks = books.where((book) {
      return book["title"]
          .toLowerCase()
          .contains(searchController.text.toLowerCase());
    }).toList();

    return Expanded(
      child: ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          final book = filteredBooks[index];

          return Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.book),
              title: Text(book["title"]),
              subtitle: Text("Author: ${book["author"]}"),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      book["issued"] ? Colors.red : Colors.green,
                ),
                onPressed: () {
                  setState(() {
                    book["issued"] = !book["issued"];
                  });
                },
                child: Text(
                  book["issued"] ? "Return" : "Issue",
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MovieRatingPage(),
    );
  }
}

class Movie {
  String name;
  double rating;

  Movie({required this.name, this.rating = 0});
}

class MovieRatingPage extends StatefulWidget {
  @override
  _MovieRatingPageState createState() => _MovieRatingPageState();
}

class _MovieRatingPageState extends State<MovieRatingPage> {
  final TextEditingController controller = TextEditingController();
  List<Movie> movies = [];

  void addMovie() {
    if (controller.text.trim().isEmpty) return;

    setState(() {
      movies.add(Movie(name: controller.text.trim()));
      controller.clear();
    });
  }

  void updateRating(int index, double value) {
    setState(() {
      movies[index].rating = value;
    });
  }

  Widget buildStar(int movieIndex, int starIndex) {
    return IconButton(
      icon: Icon(
        starIndex <= movies[movieIndex].rating
            ? Icons.star
            : Icons.star_border,
        color: Colors.amber,
      ),
      onPressed: () => updateRating(movieIndex, starIndex.toDouble()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movie Rating App')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Input field
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Enter movie name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: addMovie,
                  child: Text('Add'),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Movie list
            Expanded(
              child: movies.isEmpty
                  ? Center(child: Text('No movies added'))
                  : ListView.builder(
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movies[index].name,
                                  style: TextStyle(fontSize: 18),
                                ),
                                Row(
                                  children: List.generate(
                                    5,
                                    (starIndex) => buildStar(
                                        index, starIndex + 1),
                                  ),
                                ),
                                Text(
                                  'Rating: ${movies[index].rating.toInt()} / 5',
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
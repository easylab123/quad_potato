import 'package:flutter/material.dart';
import 'api_service.dart';
import 'post.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostScreen(),
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final ApiService apiService = ApiService();
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    posts = apiService.getPosts();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("REST API Example")),

      body: FutureBuilder<List<Post>>(
        future: posts,
        builder: (context, snapshot) {

          if (snapshot.hasData) {

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {

                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].body),
                );

              },
            );

          } else if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
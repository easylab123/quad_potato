import 'dart:convert';
import 'package:http/http.dart' as http;
import 'post.dart';

class ApiService {

  final String url = "https://jsonplaceholder.typicode.com/posts";

  // GET METHOD
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load posts");
    }
  }

  // POST METHOD
  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to create post");
    }
  }

  // PUT METHOD
  Future<Post> updatePost(int id, Post post) async {
    final response = await http.put(
      Uri.parse("$url/$id"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(post.toJson()),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to update post");
    }
  }

  // DELETE METHOD
  Future<void> deletePost(int id) async {
    final response = await http.delete(Uri.parse("$url/$id"));

    if (response.statusCode != 200) {
      throw Exception("Failed to delete post");
    }
  }
}
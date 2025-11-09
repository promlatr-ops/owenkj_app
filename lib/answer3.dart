import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      title: json['title']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
    );
  }
}

class PostList extends StatefulWidget {
  static const routeName = '/assignment3';

  const PostList({super.key});

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final res = await http.get(uri).timeout(const Duration(seconds: 100));
    if (res.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(res.body);
      final fetchedPosts = jsonList.map((json) => Post.fromJson(json)).toList();
      setState(() {
        posts = List<Post>.from(fetchedPosts);
      });
    } else {
      throw Exception('Failed to load posts: ${res.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          final post = posts[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(post.id.toString()),
            ),
            title: Text(post.title),
            subtitle: Text(post.body),
          );
        },
      ),
    );
  }
}

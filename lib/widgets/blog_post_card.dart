import 'package:flutter/material.dart';
import '../models/blog_post.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPost post;

  const BlogPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(post.title),
        subtitle: Text('${post.date.toLocal()}'.split(' ')[0]),
        onTap: () {
          // Navigate to a detailed blog post view if desired
        },
      ),
    );
  }
}

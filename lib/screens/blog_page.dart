import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../services/blog_service.dart';
import '../widgets/blog_post_card.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final BlogService blogService = BlogService();
  late Future<List<BlogPost>> _futurePosts; // For asynchronous loading of posts

  @override
  void initState() {
    super.initState();
    _futurePosts = blogService.getAllPosts(); // Fetch the posts from the service
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Blog'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List<BlogPost>>(
        future: Future.value(_futurePosts),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Loading indicator
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Error loading blog posts')); // Error message
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No blog posts available')); // No data message
          }

          final List<BlogPost> posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return BlogPostCard(post: posts[index]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new-blog-post');
        },
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../services/blog_service.dart';

class NewBlogPostPage extends StatelessWidget {
  final BlogService blogService;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NewBlogPostPage({super.key, required this.blogService});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Blog Post'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: 'Content'),
              maxLines: 10,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate the input fields before submitting
                if (titleController.text.isEmpty ||
                    contentController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please fill in both title and content')),
                  );
                  return;
                }

                final newPost = BlogPost(
                  title: titleController.text,
                  content: contentController.text,
                  date: DateTime.now(),
                );

                blogService.addPost(newPost).then((_) {
                  // Show success message and pop the page
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Blog post added successfully')),
                  );
                  Navigator.pop(context);
                }).catchError((error) {
                  // Handle any errors that occur during post submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add blog post: $error')),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

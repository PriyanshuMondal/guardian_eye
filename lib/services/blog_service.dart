import '../models/blog_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BlogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BlogPost>> getAllPosts() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('blogPosts').get();
      return querySnapshot.docs
          .map((doc) => BlogPost.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error fetching blog posts: $e');
    }
  }
  Future<void> addPost(BlogPost post) async {
    try {
      await _firestore.collection('blogPosts').add(post.toMap());
    } catch (e) {
      throw Exception('Failed to add blog post: $e');
    }
  }
}

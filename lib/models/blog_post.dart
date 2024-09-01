import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPost {
  final String title;
  final String content;

  final DateTime date;

  BlogPost({
    required this.title,
    required this.content,
    required this.date,
  });

  factory BlogPost.fromMap(Map<String, dynamic> data) {
    return BlogPost(
      title: data['title'],
      content: data['content'],
      date: (data['date'] as Timestamp).toDate(),
    );
  }
    Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date.toIso8601String(), // Convert DateTime to a string
    };
  }
}


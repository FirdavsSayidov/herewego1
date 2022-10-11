import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:herewego/model/post_model.dart';

class RTDBService with ChangeNotifier {
  static final _database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>?> addPost(Post post) async {
    _database.child("posts").push().set(post.toJson());
    return _database.onChildAdded;
  }

  static List<Post> items = [];
  static Future<List<Post>> getAllPosts(String id) async {
    final query = _database.child("posts");
    await query.once().then((snapshot) {
      final v = snapshot.snapshot.children;
      for(var i in v){
        Map map = i.value as Map;
        items.add(Post(map['userId'],map['title'],map['content']));
      }
    });
    return items;
  }
}

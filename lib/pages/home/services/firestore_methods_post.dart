import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../shared/resources/storage_methods.dart';
import '../models/post.dart';
import '../models/reel.dart';

class FirestoreMethodsPost {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> uploadPost(String description, File file, String uid,
      String username, String profImage) async {
    try {
      String postId = Uuid().v1();

      String photoUrl =
          await StorageMethods().upLoadImageToStorage('posts', file, true);
      Post post = Post(
          description: description,
          uid: uid,
          username: username,
          postId: postId,
          dataPublished: DateTime.now(),
          postUrl: photoUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );

      return true;
    } catch (err) {
      print(err.toString());
      return false;
    }
  }

  Future<bool> uploadReel(String description, File video, String uid,
      String username, String profImage) async {
    try {
      String reelId = Uuid().v1();
      String reelUrl =
          await StorageMethods().upLoadImageToStorage('reels', video, true);
      Reel reel = Reel(
          description: description,
          uid: uid,
          username: username,
          reelId: reelId,
          dataPublished: DateTime.now(),
          reelUrl: reelUrl,
          profImage: profImage,
          likes: []);

      _firestore.collection('reels').doc(reelId).set(
            reel.toJson(),
          );
      return true;
    } catch (err) {
      print(err.toString());
    }
    return false;
  }

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> likeReel(String reelId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        _firestore.collection('reels').doc(reelId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        _firestore.collection('reels').doc(reelId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }

    return false;
  }

  Future<bool> reelComment(String reelId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = Uuid().v1();
        _firestore
            .collection('reels')
            .doc(reelId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }
}

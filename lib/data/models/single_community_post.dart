import 'dart:convert';

import 'package:savio/data/models/user.dart';

class SingleCommunityPost {
  final int id;
  final User author;
  final int upvotes;
  final int downvotes;
  final int score;
  final bool is_bookmarked;
  final int? vote;
  final String title;
  final String content;
  final String created_at;
  final String updated_at;
  final String? image;
  SingleCommunityPost({
    required this.id,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.score,
    required this.is_bookmarked,
    required this.vote,
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.image,
  });

  SingleCommunityPost copyWith({
    int? id,
    User? author,
    int? upvotes,
    int? downvotes,
    int? score,
    bool? is_bookmarked,
    int? vote,
    String? title,
    String? content,
    String? created_at,
    String? updated_at,
    String? image,
  }) {
    return SingleCommunityPost(
      id: id ?? this.id,
      author: author ?? this.author,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      score: score ?? this.score,
      is_bookmarked: is_bookmarked ?? this.is_bookmarked,
      vote: vote ?? this.vote,
      title: title ?? this.title,
      content: content ?? this.content,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author.toMap(),
      'upvotes': upvotes,
      'downvotes': downvotes,
      'score': score,
      'is_bookmarked': is_bookmarked,
      'vote': vote,
      'title': title,
      'content': content,
      'created_at': created_at,
      'updated_at': updated_at,
      'image': image,
    };
  }

  factory SingleCommunityPost.fromMap(Map<String, dynamic> map) {
    return SingleCommunityPost(
      id: map['id'].toInt() as int,
      author: User.fromMap(map['author'] as Map<String,dynamic>),
      upvotes: map['upvotes'].toInt() as int,
      downvotes: map['downvotes'].toInt() as int,
      score: map['score'].toInt() as int,
      is_bookmarked: map['is_bookmarked'] as bool,
      vote: map['vote'].toInt() as int,
      title: map['title'] as String,
      content: map['content'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleCommunityPost.fromJson(String source) => SingleCommunityPost.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SingleCommunityPost(id: $id, author: $author, upvotes: $upvotes, downvotes: $downvotes, score: $score, is_bookmarked: $is_bookmarked, vote: $vote, title: $title, content: $content, created_at: $created_at, updated_at: $updated_at, image: $image)';
  }

  @override
  bool operator ==(covariant SingleCommunityPost other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.author == author &&
      other.upvotes == upvotes &&
      other.downvotes == downvotes &&
      other.score == score &&
      other.is_bookmarked == is_bookmarked &&
      other.vote == vote &&
      other.title == title &&
      other.content == content &&
      other.created_at == created_at &&
      other.updated_at == updated_at &&
      other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      author.hashCode ^
      upvotes.hashCode ^
      downvotes.hashCode ^
      score.hashCode ^
      is_bookmarked.hashCode ^
      vote.hashCode ^
      title.hashCode ^
      content.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      image.hashCode;
  }
}

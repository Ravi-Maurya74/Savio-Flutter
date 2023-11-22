import 'dart:convert';

import 'package:savio/data/models/user.dart';

class Comment {
  final int id;
  final User author;
  final int upvotes;
  final int downvotes;
  final int score;
  final int? vote;
  final String content;
  final String created_at;
  final String updated_at;
  final int depth;
  final int post;
  final int? parent;
  Comment({
    required this.id,
    required this.author,
    required this.upvotes,
    required this.downvotes,
    required this.score,
    required this.vote,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.depth,
    required this.post,
    required this.parent,
  });

  Comment copyWith({
    int? id,
    User? author,
    int? upvotes,
    int? downvotes,
    int? score,
    int? vote,
    String? content,
    String? created_at,
    String? updated_at,
    int? depth,
    int? post,
    int? parent,
  }) {
    return Comment(
      id: id ?? this.id,
      author: author ?? this.author,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      score: score ?? this.score,
      vote: vote == -5 ? null : vote ?? this.vote,
      content: content ?? this.content,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      depth: depth ?? this.depth,
      post: post ?? this.post,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author.toMap(),
      'upvotes': upvotes,
      'downvotes': downvotes,
      'score': score,
      'vote': vote,
      'content': content,
      'created_at': created_at,
      'updated_at': updated_at,
      'depth': depth,
      'post': post,
      'parent': parent,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'].toInt() as int,
      author: User.fromMap(map['author'] as Map<String, dynamic>),
      upvotes: map['upvotes'].toInt() as int,
      downvotes: map['downvotes'].toInt() as int,
      score: map['score'].toInt() as int,
      vote: map['vote'] != null ? map['vote'].toInt() : null,
      content: map['content'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      depth: map['depth'].toInt() as int,
      post: map['post'].toInt() as int,
      parent: map['parent'] != null ? map['parent'].toInt() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(id: $id, author: $author, upvotes: $upvotes, downvotes: $downvotes, score: $score, vote: $vote, content: $content, created_at: $created_at, updated_at: $updated_at, depth: $depth, post: $post, parent: $parent)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.author == author &&
        other.upvotes == upvotes &&
        other.downvotes == downvotes &&
        other.score == score &&
        other.vote == vote &&
        other.content == content &&
        other.created_at == created_at &&
        other.updated_at == updated_at &&
        other.depth == depth &&
        other.post == post &&
        other.parent == parent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        author.hashCode ^
        upvotes.hashCode ^
        downvotes.hashCode ^
        score.hashCode ^
        vote.hashCode ^
        content.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        depth.hashCode ^
        post.hashCode ^
        parent.hashCode;
  }
}

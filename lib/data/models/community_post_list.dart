import 'dart:convert';

import 'package:savio/data/models/user.dart';

class CommunityPostList {
  final int id;
  final User author;
  final int score;
  final int? vote;
  final String detail_url;
  final String title;
  final String content;
  final String created_at;
  final String updated_at;
  final String? image;
  CommunityPostList({
    required this.id,
    required this.author,
    required this.score,
    required this.vote,
    required this.detail_url,
    required this.title,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.image,
  });

  CommunityPostList copyWith({
    int? id,
    User? author,
    int? score,
    int? vote,
    String? detail_url,
    String? title,
    String? content,
    String? created_at,
    String? updated_at,
    String? image,
  }) {
    return CommunityPostList(
      id: id ?? this.id,
      author: author ?? this.author,
      score: score ?? this.score,
      vote: vote ?? this.vote,
      detail_url: detail_url ?? this.detail_url,
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
      'score': score,
      'vote': vote,
      'detail_url': detail_url,
      'title': title,
      'content': content,
      'created_at': created_at,
      'updated_at': updated_at,
      'image': image,
    };
  }

  factory CommunityPostList.fromMap(Map<String, dynamic> map) {
    return CommunityPostList(
      id: map['id'].toInt() as int,
      author: User.fromMap(map['author'] as Map<String, dynamic>),
      score: map['score'].toInt() as int,
      vote: map['vote'].toInt() as int,
      detail_url: map['detail_url'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommunityPostList.fromJson(String source) =>
      CommunityPostList.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CommunityPostList(id: $id, author: $author, score: $score, vote: $vote, detail_url: $detail_url, title: $title, content: $content, created_at: $created_at, updated_at: $updated_at, image: $image)';
  }

  @override
  bool operator ==(covariant CommunityPostList other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.author == author &&
        other.score == score &&
        other.vote == vote &&
        other.detail_url == detail_url &&
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
        score.hashCode ^
        vote.hashCode ^
        detail_url.hashCode ^
        title.hashCode ^
        content.hashCode ^
        created_at.hashCode ^
        updated_at.hashCode ^
        image.hashCode;
  }
}

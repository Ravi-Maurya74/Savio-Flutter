import 'dart:convert';

class Comment {
  final int id;
  final String content;
  final String created_at;
  final String updated_at;
  final int depth;
  final int author;
  final int post;
  final int? parent;
  Comment({
    required this.id,
    required this.content,
    required this.created_at,
    required this.updated_at,
    required this.depth,
    required this.author,
    required this.post,
    required this.parent,
  });

  Comment copyWith({
    int? id,
    String? content,
    String? created_at,
    String? updated_at,
    int? depth,
    int? author,
    int? post,
    int? parent,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      created_at: created_at ?? this.created_at,
      updated_at: updated_at ?? this.updated_at,
      depth: depth ?? this.depth,
      author: author ?? this.author,
      post: post ?? this.post,
      parent: parent ?? this.parent,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'content': content,
      'created_at': created_at,
      'updated_at': updated_at,
      'depth': depth,
      'author': author,
      'post': post,
      'parent': parent,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id'].toInt() as int,
      content: map['content'] as String,
      created_at: map['created_at'] as String,
      updated_at: map['updated_at'] as String,
      depth: map['depth'].toInt() as int,
      author: map['author'].toInt() as int,
      post: map['post'].toInt() as int,
      parent: map['parent'] != null ? map['parent'].toInt() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) => Comment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, created_at: $created_at, updated_at: $updated_at, depth: $depth, author: $author, post: $post, parent: $parent)';
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.content == content &&
      other.created_at == created_at &&
      other.updated_at == updated_at &&
      other.depth == depth &&
      other.author == author &&
      other.post == post &&
      other.parent == parent;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      content.hashCode ^
      created_at.hashCode ^
      updated_at.hashCode ^
      depth.hashCode ^
      author.hashCode ^
      post.hashCode ^
      parent.hashCode;
  }
}
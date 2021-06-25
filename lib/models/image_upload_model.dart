class CoreImage {
  final String? id;
  final String? imgUrl;
  final int? updatedAt;

  CoreImage({
    this.id,
    this.imgUrl,
    this.updatedAt,
  });

  CoreImage copyWith({
    final String? id,
    final String? imgUrl,
    final int? updatedAt,
  }) {
    return CoreImage(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static CoreImage fromJson(final Map<String, dynamic> data) {
    return CoreImage(
      id: data['id'],
      imgUrl: data['image_urls'] ?? [],
      updatedAt: data['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_urls': imgUrl,
      'updated_at': updatedAt,
    };
  }
}

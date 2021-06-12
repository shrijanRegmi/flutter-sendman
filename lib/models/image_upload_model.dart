class ImgUpload {
  final String? id;
  final String? imgUrl;
  final int? updatedAt;

  ImgUpload({
    this.id,
    this.imgUrl,
    this.updatedAt,
  });

  ImgUpload copyWith({
    final String? id,
    final String? imgUrl,
    final int? updatedAt,
  }) {
    return ImgUpload(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static ImgUpload fromJson(final Map<String, dynamic> data) {
    return ImgUpload(
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

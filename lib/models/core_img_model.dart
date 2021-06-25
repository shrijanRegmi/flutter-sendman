class CoreImage {
  final String? uid;
  final String? id;
  final List<String>? imgUrls;
  final int? updatedAt;
  final int? disDate;
  final String? disTime;

  CoreImage({
    this.uid,
    this.id,
    this.imgUrls,
    this.updatedAt,
    this.disDate,
    this.disTime,
  });

  CoreImage copyWith({
    final String? uid,
    final String? id,
    final List<String>? imgUrl,
    final int? updatedAt,
    final int? disDate,
    final String? disTime,
  }) {
    return CoreImage(
      uid: uid ?? this.uid,
      id: id ?? this.id,
      imgUrls: imgUrl ?? this.imgUrls,
      updatedAt: updatedAt ?? this.updatedAt,
      disDate: disDate ?? this.disDate,
      disTime: disTime ?? this.disTime,
    );
  }

  static CoreImage fromJson(final Map<String, dynamic> data) {
    return CoreImage(
      uid: data['uid'],
      id: data['id'],
      imgUrls: data['image_urls'] != null
          ? List<String>.from(data['image_urls'])
          : [],
      updatedAt: data['updated_at'],
      disDate: data['dis_date'],
      disTime: data['dis_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'id': id,
      'image_urls': imgUrls,
      'updated_at': updatedAt,
      'dis_date': disDate,
      'dis_time': disTime,
    };
  }
}

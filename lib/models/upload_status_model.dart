class UploadStatus {
  final int total;
  final int uploading;
  final bool done;
  final double progress;

  UploadStatus({
    required this.total,
    required this.uploading,
    this.done = false,
    this.progress = 0.0,
  });

  UploadStatus copyWith({
    final int? total,
    final int? uploading,
    final bool? done,
    final double? progress,
  }) {
    return UploadStatus(
      total: total ?? this.total,
      uploading: uploading ?? this.uploading,
      done: done ?? this.done,
      progress: progress ?? this.progress,
    );
  }
}

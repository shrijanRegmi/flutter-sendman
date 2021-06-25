class UploadStatus {
  final int total;
  final int uploaded;
  final bool done;
  final double progress;

  UploadStatus({
    required this.total,
    required this.uploaded,
    this.done = false,
    this.progress = 0.0,
  });

  UploadStatus copyWith({
    final int? total,
    final int? uploaded,
    final bool? done,
    final double? progress,
  }) {
    return UploadStatus(
      total: total ?? this.total,
      uploaded: uploaded ?? this.uploaded,
      done: done ?? this.done,
      progress: progress ?? this.progress,
    );
  }
}

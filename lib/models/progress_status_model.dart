class ProgressStatus {
  final String title;
  final int total;
  final int uploading;
  final bool done;
  final double progress;

  ProgressStatus({
    required this.title,
    required this.total,
    required this.uploading,
    this.done = true,
    this.progress = 0.0,
  });

  ProgressStatus copyWith({
    final String? title,
    final int? total,
    final int? uploading,
    final bool? done,
    final double? progress,
  }) {
    return ProgressStatus(
      title: title ?? this.title,
      total: total ?? this.total,
      uploading: uploading ?? this.uploading,
      done: done ?? this.done,
      progress: progress ?? this.progress,
    );
  }
}

class PageResult<T> {
  const PageResult({
    required this.content,
    required this.number,
    required this.totalPages,
    required this.totalElements,
    required this.first,
    required this.last,
  });

  final List<T> content;
  final int number;
  final int totalPages;
  final int totalElements;
  final bool first;
  final bool last;

  factory PageResult.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    return PageResult<T>(
      content: (json['content'] as List<dynamic>? ?? const [])
          .map((item) => fromJson(Map<String, dynamic>.from(item as Map)))
          .toList(),
      number: (json['number'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] as num?)?.toInt() ?? 0,
      totalElements: (json['totalElements'] as num?)?.toInt() ?? 0,
      first: json['first'] as bool? ?? true,
      last: json['last'] as bool? ?? true,
    );
  }
}

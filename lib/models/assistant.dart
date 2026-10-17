class Assistant {
  final String id;
  final String message;
  final bool is_assistant;
  final String image;
  final String hour_message;
  final String created_at;
  final String updated_at;

  Assistant({
    required this.id,
    required this.message,
    required this.is_assistant,
    required this.image,
    required this.hour_message,
    required this.created_at,
    required this.updated_at,
  });

  factory Assistant.fromJson(Map<String, dynamic> json) {
    String formatHour(String? value) {
      if (value == null || value.isEmpty) return '';

      try {
        final parts = value.split(':');
        return '${parts[0]}:${parts[1]}';
      } catch (e) {
        return '';
      }
    }

    return Assistant(
      id: json['id'] ?? '',
      message: json['message'] ?? '',
      is_assistant: json['is_assistant'] == true,
      image: json['image'] ?? '',
      hour_message: formatHour(json['hour_message']),
      created_at: json['created_at'] ?? '',
      updated_at: json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'is_assistant': is_assistant,
      'image': image,
      'hour_message': hour_message,
      'created_at': created_at,
      'updated_at': updated_at,
    };
  }
}

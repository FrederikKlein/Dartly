class Player {
  final String id;
  final String name;
  final bool isEnabled;

  Player({
    required this.id,
    required this.name,
    this.isEnabled = true,
  });

  Player copyWith({
    String? id,
    String? name,
    bool? isEnabled,
  }) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Player &&
        other.id == id &&
        other.name == name &&
        other.isEnabled == isEnabled;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isEnabled.hashCode;
}
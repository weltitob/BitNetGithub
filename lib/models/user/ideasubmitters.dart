class IdeaSubmitterTop3Model {
  final String name;
  final String idea;
  final String id;
  final int placement;

  IdeaSubmitterTop3Model({
    required this.name,
    required this.idea,
    required this.id,
    required this.placement,
  });

  factory IdeaSubmitterTop3Model.fromJson(Map<String, dynamic> json) {
    return IdeaSubmitterTop3Model(
      name: json['name'],
      idea: json['idea'],
      id: json['id'],
      placement: json['placement'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'idea': idea,
      'id': id,
      'placement': placement,
    };
  }
}
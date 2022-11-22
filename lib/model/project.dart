class Project {
  String name;
  String description;
  String ownerId;
  List<String> colab;

  Project(this.name, this.description, this.ownerId) : colab = [];

  Project.fromJson(Map<String, dynamic> json)
      : name = json['name']! as String,
        description = json['description']! as String,
        ownerId = json['ownerId']! as String,
        colab = (json['colab']! as List).cast<String>();

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'description': description,
      'ownerId': ownerId,
      'colab': colab,
    };
  }
}

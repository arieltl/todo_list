import 'package:todo_list/model/section.dart';

class Project {
  final String id;
  String name;
  String description;
  String ownerId;
  List<String> colab;
  List<Section> sections;

  Project(this.name, this.description, this.ownerId)
      : id = "",
        sections = [],
        colab = [];

  Project.fromDb(this.id, this.name, this.description, this.ownerId, this.colab,
      this.sections);
}
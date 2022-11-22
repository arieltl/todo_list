import 'package:flutter/cupertino.dart';

class HomePageData extends ChangeNotifier {
  List<String> _sections = ["1", "2", "3"];
  List<String> _projects = ["tecweb", "eletromag", "cfc"];
  int _selectedSection = 0;
  int _selectedProject = 0;
  String _selectedProjectid = "";
  String _selectedSectionid = "";
  int _mode = 0;
  List<String> get sections =>
      _sections.map((e) => "${projects[selectedProject]} $e").toList();
  List<String> get projects => _projects;
  int get selectedSection => _selectedSection;
  int get selectedProject => _selectedProject;
  int get mode => _mode;
  String get selectedProjectid => _selectedProjectid;
  String get selectedSectionid => _selectedSectionid;

  void addSection(String section) {
    _sections.add(section);
    notifyListeners();
  }
  set mode (int mode) {
    _mode = mode;
    notifyListeners();
  }
  setMode(int mode){
    _mode = mode;
    notifyListeners();
  }
  set sections(List<String> sections) {
    _sections = sections;
    notifyListeners();
  }
  set projects(List<String> projects) {
    _projects = projects;
    notifyListeners();
  }
  set selectedSection(int selectedSection) {
    _selectedSection = selectedSection;
    notifyListeners();
  }
  set selectedProject(int selectedProject) {
    _selectedProject = selectedProject;
    notifyListeners();
  }

  set selectedProjectid (String id){
    _selectedProjectid = id;
    notifyListeners();
  }

  set selectedSectionid (String id){
    _selectedSectionid = id;
    notifyListeners();
  }
}

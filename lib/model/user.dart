class User {
  String name;
  String userName;
  final String id;

  User(this.name, this.userName) : id = "";
  User.fromDb(this.name, this.userName, this.id);
}

class User {
  User({required this.name, required this.userName, required this.email});

  final String name;
  final String userName;
  final String email;

  User.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name']! as String,
          userName: json['userName']! as String,
          email: json['email']! as String,
        );

  Map<String, dynamic> toJson() => {
        'name': name,
        'userName': userName,
        'email': email,
      };
}

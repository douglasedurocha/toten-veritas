class UserModel{
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password
  });

  final int id;
  final String name;
  final String email;
  final String password;

  static UserModel fromMap(Map<String, Object?> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String
    );
  }

}

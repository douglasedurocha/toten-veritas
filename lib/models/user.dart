class UserModel{
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.balance,
  });

  final int id;
  final String name;
  final String email;
  final double balance;

  static UserModel fromMap(Map<String, Object?> map) {
    return UserModel(
      id: map['id'] as int,
      name: map['username'] as String,
      email: map['email'] as String,
      balance: double.parse(map['balance'] as String),
    );
  }

}

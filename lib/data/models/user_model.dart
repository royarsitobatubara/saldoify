class UserModel {
  final int? id;
  final String name;
  final String profile;
  final int balance;
  final String password;

  UserModel({
    this.id,
    required this.name,
    required this.profile,
    required this.balance,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile': profile,
      'balance': balance,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      profile: map['profile'],
      balance: map['balance'],
      password: map['password'],
    );
  }
}

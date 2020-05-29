class User {
  final int id;
  final String firstName;
  final String lastName;

  const User({
    this.id,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: int.parse(json['id']),
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String);
  }
}

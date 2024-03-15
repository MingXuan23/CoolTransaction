class User{
  final int? id;
  final String email;
  final String password;
  final String name;

  User(this.id, this.email, this.password,this.name);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id']??0,
      json['email']??"",
      json['password']??"",
      json['name']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
      'name': name,
    };
  }
}
class UserData {
  final String? id;
  final String? name;
  final String? roleName;

  UserData({this.id, this.name, this.roleName});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      name: json['name'],
      roleName: json['role_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'role_name': roleName};
  }
}

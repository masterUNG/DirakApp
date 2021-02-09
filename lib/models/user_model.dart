import 'dart:convert';

class UserModel {
  final String name;
  final String typeuser;
  UserModel({
    this.name,
    this.typeuser,
  });

  UserModel copyWith({
    String name,
    String typeuser,
  }) {
    return UserModel(
      name: name ?? this.name,
      typeuser: typeuser ?? this.typeuser,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'typeuser': typeuser,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return UserModel(
      name: map['name'],
      typeuser: map['typeuser'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(name: $name, typeuser: $typeuser)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserModel &&
      o.name == name &&
      o.typeuser == typeuser;
  }

  @override
  int get hashCode => name.hashCode ^ typeuser.hashCode;
}

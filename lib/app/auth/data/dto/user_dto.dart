class UserModel {
  final String email;
  final String fullname;
  final DateTime createdAt;
  final String userId;
  const UserModel({
    required this.email,
    required this.fullname,
    required this.createdAt,
    required this.userId
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      email: json['email'] ,
      fullname: json['fullname'] ,
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt'] ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userId':userId,
      'fullname': fullname,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

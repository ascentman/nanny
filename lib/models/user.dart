class UserModel {
  String email;
  String uid;
  String username;
  DateTime timestamp;

  UserModel({
    required this.email,
    required this.uid,
    required this.username,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'username': username,
      'timestamp': timestamp,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      uid: map['uid'] as String,
      username: map['username'] as String,
      timestamp: map['timestamp'] as DateTime,
    );
  }
}

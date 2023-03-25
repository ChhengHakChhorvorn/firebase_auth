class User{
  final String? userId;
  final String userName;
  final String password;
  final String email;

  User({this.userId,required this.userName, required this.password, required this.email});

  Map<String,dynamic> toJson() => {
    'userId': userId,
    'userName': userName,
    'email' : email,
    'password' : password
  };

  static User fromJson(Map<String,dynamic> json)=> User(
    userName: json['userName'],
    password: json['password'],
    email: json['email'],
    userId: json['userId'].toString()
  );
}
enum UserType { PARTICULAR, PROFESSIONAL }

class User {

  User({this.name, this.email, this.password});

  String name;
  String email;
  String password;

  String phone;

  UserType userType = UserType.PARTICULAR;


}
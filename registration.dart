class registration {
  final String username;
  final String firstName;
  final String lastName;
  final String password;
  static const String TABLENAME = "registration";

  registration({this.username, this.firstName, this.lastName,this.password});

  Map<String, dynamic> toMap() {
    return {'email': username, 'firstName': firstName, 'lastName': lastName,'password':password};
  }
}
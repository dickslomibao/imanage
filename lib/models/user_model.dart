class UserModel {
  String firstname;
  String lastname;
  String photoUrl;
  String email;
  String username;
  String password;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.photoUrl = "",
    required this.username,
  });

  Map<String, dynamic> toFireStore() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
      'photo_url': photoUrl,
      'email': email,
    };
  }

  Map<String, dynamic> toFireStoreUpdate() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'username': username,
    };
  }
}

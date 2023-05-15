
class AppUser{

  String uid;
  String firstName;
  String lastName;
  String email;


  AppUser({this.uid, this.firstName, this.lastName, this.email});


  AppUser.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        uid = json['uid'];

  Map<String, dynamic> toJson() =>
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'uid': uid,
      };
}
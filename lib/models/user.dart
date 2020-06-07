class User {
  int userID;
  String userName;
  String userSurname;
  String userPassword;
  String userMail;
  String faculty;
  String department;
  String birthDate;
  String joinDate;
  int deleted;
  String profilePic;

  User(
      this.userName,
      this.userSurname,
      this.userPassword,
      this.userMail,
      this.faculty,
      this.department,
      this.birthDate,
      this.joinDate,
      this.deleted,
      this.profilePic);

  User.withId(
      this.userID,
      this.userName,
      this.userSurname,
      this.userPassword,
      this.userMail,
      this.faculty,
      this.department,
      this.birthDate,
      this.joinDate,
      this.deleted,
      this.profilePic);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["user_id"] = userID;
    map["user_name"] = userName;
    map["user_surname"] = userSurname;
    map["user_password"] = userPassword;
    map["user_mail"] = userMail;
    map["faculty"] = faculty;
    map["department"] = department;
    map["birtDate"] = birthDate;
    map["joinDate"] = joinDate;
    map["deleted"] = deleted;
    map["profilePic"] = profilePic;

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this.userID = map["user_id"];
    this.userName = map["user_name"];
    this.userSurname = map["user_surname"];
    this.userPassword = map["user_password"];
    this.userMail = map["user_mail"];
    this.faculty = map["faculty"];
    this.department = map["department"];
    this.birthDate = map["birtDate"];
    this.joinDate = map["joinDate"];
    this.deleted = map["deleted"];
    this.profilePic = map["profilePic"];
  }

  @override
  String toString() {
    return "User\n ID: $userID,\n Name: $userName,\n Surname: $userName,\n Password: $userPassword,\n Mail: $userMail,\n Faculty: $faculty,\n Department: $department,\n Birth Date: $birthDate,\n Join Date: $joinDate,\n Profile picture: $profilePic";
  }
}

class Community {
  int commId;
  String commPassword;
  String commName;
  String commDesc;
  String dateCreated;
  String supervisor;
  String contactInfo;
  String officeAddress;
  String commManager;
  String instagram;
  String twitter;
  String phone;
  int acceptNewUser;
  int freezeComm;

  Community(
      this.commPassword,
      this.commName,
      this.commDesc,
      this.dateCreated,
      this.supervisor,
      this.contactInfo,
      this.officeAddress,
      this.commManager,
      this.instagram,
      this.twitter,
      this.phone,
      this.acceptNewUser,
      this.freezeComm);

  Community.withID(
      this.commId,
      this.commPassword,
      this.commName,
      this.commDesc,
      this.dateCreated,
      this.supervisor,
      this.contactInfo,
      this.officeAddress,
      this.commManager,
      this.instagram,
      this.twitter,
      this.phone,
      this.acceptNewUser,
      this.freezeComm);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["comm_id"] = commId;
    map["comm_password"] = commPassword;
    map["comm_name"] = commName;
    map["comm_desc"] = commDesc;
    map["date_created"] = dateCreated;
    map["supervisor"] = supervisor;
    map["contactInfo"] = contactInfo;
    map["office_address"] = officeAddress;
    map["comm_manager"] = commManager;
    map["instagram"] = instagram;
    map["twitter"] = twitter;
    map["phone"] = phone;
    map["acceptNewUser"] = acceptNewUser;
    map["freeze_comm"] = freezeComm;

    return map;
  }

  Community.fromMap(Map<String, dynamic> map) {
    this.commId = map["comm_id"];
    this.commPassword = map["comm_password"];
    this.commName = map["comm_name"];
    this.commDesc = map["comm_desc"];
    this.dateCreated = map["date_created"];
    this.supervisor = map["supervisor"];
    this.contactInfo = map["contactInfo"];
    this.officeAddress = map["office_address"];
    this.commManager = map["comm_manager"];
    this.instagram = map["instagram"];
    this.twitter = map["twitter"];
    this.phone = map["phone"];
    this.acceptNewUser = map["acceptNewUser"];
    this.freezeComm = map["freeze_comm"];
  }

  @override
  String toString() {
    return "Community\n ID: $commId,\n Password: $commPassword,\n Name: $commName,\n Description: $commDesc,\n Created date: $dateCreated,\n Supervisor: $supervisor,\n Contact info: $contactInfo,\n Office address: $officeAddress,\n Community Manager: $commManager,\n Instagram: $instagram\n, Twitter: $twitter";
  }
}

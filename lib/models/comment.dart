class Comment {
  int commentId;
  int userId;
  String userName;
  String userSurname;
  int eventId;
  String dateTime;
  String text;
  int deleted;

  Comment(
    this.userId,
    this.userName,
    this.userSurname,
    this.eventId,
    this.dateTime,
    this.text,
    this.deleted,
  );

  Comment.withID(
    this.commentId,
    this.userId,
    this.userName,
    this.userSurname,
    this.eventId,
    this.dateTime,
    this.text,
    this.deleted,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["Comment_id"] = commentId;
    map["user_id"] = userId;
    map["event_id"] = eventId;
    map["date_time"] = dateTime;
    map["text"] = text;
    map["deleted"] = deleted;

    return map;
  }

  Comment.fromMap(Map<String, dynamic> map) {
    this.commentId = map["Comment_id"];
    this.userId = map["user_id"];
    this.userName = map["user_name"];
    this.userSurname = map["user_surname"];
    this.eventId = map["event_id"];
    this.dateTime = map["date_time"];
    this.text = map["text"];
    this.deleted = map["deleted"];
  }

  @override
  String toString() {
    return "Comment : \nComment_id :${commentId} \nuser_id :${userId} \nuserName :${userName} \nuserSurname :${userSurname} \neventId :${eventId} \ndateTime :${dateTime} \ntext :${text} \ndeleted : ${deleted}";
  }
}

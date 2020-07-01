class Comment {
  int comment_id;
  int user_id;
  int event_id;
  String date_time;
  String text;
  int deleted;

  Comment(
    this.user_id,
    this.event_id,
    this.date_time,
    this.text,
    this.deleted,
  );

  Comment.withID(
    this.comment_id,
    this.user_id,
    this.event_id,
    this.date_time,
    this.text,
    this.deleted,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["Comment_id"] = comment_id;
    map["user_id"] = user_id;
    map["event_id"] = event_id;
    map["date_time"] = date_time;
    map["text"] = text;
    map["deleted"] = deleted;

    return map;
  }

  Comment.fromMap(Map<String, dynamic> map) {
    this.comment_id = map["Comment_id"];
    this.user_id = map["user_id"];
    this.event_id = map["event_id"];
    this.date_time = map["date_time"];
    this.text = map["text"];
    this.deleted = map["deleted"];
  }
}

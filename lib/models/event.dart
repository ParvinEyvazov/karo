class Event {
  String community_name;
  int eventID;
  String eventTitle;
  String eventDesc;
  String eventDateTime;
  String eventLocation;
  int quota;
  int delete;

  Event(
    this.community_name,
    this.eventTitle,
    this.eventDesc,
    this.eventDateTime,
    this.eventLocation,
    this.quota,
    this.delete,
  );

  Event.withID(
    this.community_name,
    this.eventID,
    this.eventTitle,
    this.eventDesc,
    this.eventDateTime,
    this.eventLocation,
    this.quota,
    this.delete,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map["event_id"] = eventID;
    map["event_title"] = eventTitle;
    map["event_desc"] = eventDesc;
    map["event_datetime"] = eventDateTime;
    map["event_location"] = eventLocation;
    map["quota"] = quota;
    map["deleted"] = delete;

    return map;
  }

  Event.fromMap(Map<String, dynamic> map) {
    this.community_name = map["community_name"];
    this.eventID = map["event_id"];
    this.eventTitle = map["event_title"];
    this.eventDesc = map["event_desc"];
    this.eventDateTime = map["event_datetime"];
    this.eventLocation = map["event_location"];
    this.quota = map["quota"];
    this.delete = map["delete"];
  }
}

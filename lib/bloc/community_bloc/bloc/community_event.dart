part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();
}

// PROFILE-DAKI - JOINED COMMUNITY GOSTERME UCUN - ID ALIR, LIST DONECEK
class FetchAllJoinedCommunityEvent extends CommunityEvent {
  int user_id;

  FetchAllJoinedCommunityEvent({@required this.user_id})
      : assert(user_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

// EXPLORE-DAKI - COMMUNITY GOSTERME KISMI - Id alir Liste donecek
class FetchAllNonJoinedCommunityEvent extends CommunityEvent {
  int user_id;

  FetchAllNonJoinedCommunityEvent({@required this.user_id})
      : assert(user_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//-SINGLE COMMUNITY PAGE - JOINED ONE
class FetchSingleJoinedCommunityEvent extends CommunityEvent {
  int comm_id;

  //tam emin deyilem
  FetchSingleJoinedCommunityEvent({@required this.comm_id});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//FROM EXPLORE-SINGLE COMMUNITY PAGE - NON JOINED ONE
class FetchSingleNonJoinedCommunityEvent extends CommunityEvent {
  int comm_id;

  //tam emin deyilem
  FetchSingleNonJoinedCommunityEvent({@required this.comm_id});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//COMMUNITY PROGFILE PAGEDE BILGILER UCUN
class FetchSingleCommunityEvent extends CommunityEvent {
  int community_id;
  FetchSingleCommunityEvent({@required this.community_id});
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

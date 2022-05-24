abstract class ContactEvent {}

class OnContact extends ContactEvent {
  final String name;
  final String email;
  final String comment;

OnContact({this.name,this.email,this.comment, });
}

class AfterContact extends ContactEvent {
  AfterContact();
}
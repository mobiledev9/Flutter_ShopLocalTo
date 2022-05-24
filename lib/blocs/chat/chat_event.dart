abstract class ChatEvent {}

class OnChat extends ChatEvent {
  final String name;
  final String email;
  final String comment;

OnChat({this.name,this.email,this.comment, });
}

class AfterChat extends ChatEvent {
  AfterChat();
}
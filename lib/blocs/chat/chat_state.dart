abstract class ChatState {}

class InitialChatState extends ChatState {}

class ChatLoading extends ChatState {}

class ChatFail extends ChatState {
  final String message;

  ChatFail(this.message);
}

class ChatSuccess extends ChatState {

}

class AfterChatLoading extends ChatState {}

class AfterChatFail extends ChatState {
  final String message;

  AfterChatFail(this.message);
}

class AfterChatSuccess extends ChatState {}

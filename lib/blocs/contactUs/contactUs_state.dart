abstract class ContactState {}

class InitialContactState extends ContactState {}

class ContactLoading extends ContactState {}

class ContactFail extends ContactState {
  final String message;

  ContactFail(this.message);
}

class ContactSuccess extends ContactState {

}

class AfterContactLoading extends ContactState {}

class AfterContactFail extends ContactState {
  final String message;

  AfterContactFail(this.message);
}

class AfterContactSuccess extends ContactState {}

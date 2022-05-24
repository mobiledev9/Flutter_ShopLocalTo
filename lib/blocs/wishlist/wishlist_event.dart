part of 'wishlist_bloc.dart';

@immutable
abstract class WishListEvent {}

class WishListOnEvent extends WishListEvent {
  final int id;

  WishListOnEvent({this.id});

}

class WishListOffEvent extends WishListEvent {
  final int id;
  WishListOffEvent({this.id});
}


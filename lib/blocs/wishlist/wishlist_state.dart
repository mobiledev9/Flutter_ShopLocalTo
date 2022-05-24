
part of 'wishlist_bloc.dart';

@immutable
abstract class WishListState {}

class WishListOnState extends WishListState {}

class WishListOffState extends WishListState {}

class InitialWishListState extends WishListState {}
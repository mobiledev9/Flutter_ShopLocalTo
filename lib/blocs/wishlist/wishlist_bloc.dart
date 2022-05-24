import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shoplocalto/api/api.dart';
import 'package:shoplocalto/blocs/authentication/bloc.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
 final AuthBloc authBloc;

  WishListBloc({
    @required this.authBloc,
  }) : assert(authBloc != null);
  bool value = false;

  @override
  WishListState get initialState => InitialWishListState();

  @override
  Stream<WishListState> mapEventToState(WishListEvent event) async* {
    if (event is WishListOffEvent) {
      final dynamic result = await Api.removewishList(
        id: event.id,
      );
      if(result['status']=='success'){
        print(result['status']);
        value = value;
      }
      value = value;
      yield WishListOffState();
    }
    if (event is WishListOnEvent) {
      final dynamic result = await Api.addwishList(
        id: event.id,
      );
      if(result['status']=='success'){
        print(result['status']);
         value = !value;
      }
     value = !value;
      yield WishListOnState();
    }
  }

  getValue() => value;

}
import 'package:todo_app/models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}

class ShopIntialState extends ShopStates {}
class ShopChangeBottonNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}
class ShopSuccesHomeDataState extends ShopStates {}
class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingCategoriesDataState extends ShopStates {}
class ShopSuccesCategoriesDataState extends ShopStates {}
class ShopErrorCategoriesDataState extends ShopStates {}

class ShopLoadingChangeFavoritesDataState extends ShopStates {}
class ShopSuccesChangeFavoritesDataState extends ShopStates {
  final ChangeFavorites changeFavorites;

  ShopSuccesChangeFavoritesDataState(this.changeFavorites);
}
class ShopErrorChangeFavoritesDataState extends ShopStates {}

class ShopLoadingFavoritesDataState extends ShopStates {}
class ShopSuccesFavoritesDataState extends ShopStates {}
class ShopErrorFavoritesDataState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}
class ShopSuccesUserDataState extends ShopStates {}
class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserDataState extends ShopStates {}
class ShopSuccesUpdateUserDataState extends ShopStates {}
class ShopErrorUpdateUserDataState extends ShopStates {}
class ChangeFavorites {
  late bool status;
  late String message;

  ChangeFavorites.fromJson(Map<String, dynamic> json){
    status = json['status'];
    message = json['message'];
  }

}
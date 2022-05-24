

class LogoModel {
  // List<NeighbourImages> images; 
  int id;
  String imageUrl;



  LogoModel({
    this.id,
   this.imageUrl,
  });
}

List<LogoModel> logos = [
  LogoModel(
    id:1,
    imageUrl: "assets/socialicons/facebook.png",
    ),
  LogoModel(
    id:2,
    imageUrl: "assets/socialicons/instagram.png",
  ),
];
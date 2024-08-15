class PhotoModel{
  String imgSrc;
  String photographer;
 PhotoModel({
   required this.imgSrc,
   required this.photographer,
});
 static PhotoModel ApiToApp(Map<String,dynamic> photoMap)
  {
    return PhotoModel(imgSrc: photoMap["src"]["portrait"] , photographer: photoMap["photographer"]);
  }
}
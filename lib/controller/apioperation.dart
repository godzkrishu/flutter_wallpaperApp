import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:wallpaperapp/models/categoryModel.dart';
import 'package:wallpaperapp/models/photomodel.dart';

class ApiOperation {
  static List<PhotoModel> searchedWallpaper = []; //list of object of photomodels
  static List<PhotoModel> trendingWallpapers = []; //list of object of photomodels
  static List<CategoryModel> catModleList=[];
  static String apiKey = "tIYFYi8J1sm6cDYYHEo0U25ZRt9Eh2rIJChX8XE7ADbsP6nDSWStFIm4";

static Future<List<CategoryModel>> catWallpaper() async{
  List cateogryName = [
    "Cars",
    "Nature",
    "Bikes",
    "Street",
    "City",
    "Flowers"
  ];
  catModleList.clear();
  cateogryName.forEach((catName) async
  {
  List<PhotoModel> photo= await searchWallpaper(catName);//give list of img
  final _random= new Random();
  PhotoModel randomPhoto= photo[0+_random.nextInt(11-0)];//select random photo in range 0-11
   catModleList.add(CategoryModel(catImgUrl: randomPhoto.imgSrc, catName:catName));
  });

return catModleList;


}
  ///searchWallpaper
  static Future<List<PhotoModel>> searchWallpaper(String query) async {
  String apiUrl = "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1";
    var url = Uri.parse(apiUrl);
    Response response = await get(url, headers: {
      "authorization": apiKey,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> bodyData = jsonDecode(response.body);
      List photos = bodyData["photos"];
      searchedWallpaper.clear();// erase previous data
      photos.forEach((element) {
        searchedWallpaper.add(PhotoModel.ApiToApp(element)); // Ensure this method exists in PhotoModel
      });
      return searchedWallpaper;
    } else {
      print("Failed to load search wallpapers: ${response.statusCode}");
      return [];
    }
  }

/////getWallpaper  Method  for Trending wallpaper
  static Future<List<PhotoModel>> getWallpaper() async {
    String apiUrl = "https://api.pexels.com/v1/curated?per_page=80";
    var url = Uri.parse(apiUrl);
    Response response = await get(url, headers: {
      "authorization": apiKey,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> bodyData = jsonDecode(response.body);
      List photos = bodyData["photos"];
      trendingWallpapers.clear();
      photos.forEach((element) {
        trendingWallpapers.add(PhotoModel.ApiToApp(element)); // Ensure this method exists in PhotoModel
      });
      return trendingWallpapers;
    } else {
      print("Failed to load trending wallpapers: ${response.statusCode}");
      return [];
    }
  }
}

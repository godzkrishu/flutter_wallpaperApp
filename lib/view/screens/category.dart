import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaperapp/controller/apioperation.dart';
import 'package:wallpaperapp/models/categoryModel.dart';
import 'package:wallpaperapp/models/photomodel.dart';
import 'package:wallpaperapp/view/screens/fullscreen.dart';
import 'package:wallpaperapp/view/widget/catBlock.dart';
import 'package:wallpaperapp/view/widget/customappbar.dart';
import 'package:wallpaperapp/view/widget/searchbar.dart';
class CategoryScreen extends StatefulWidget {
  String catName;
  String catImgUrl;
  CategoryScreen ({super.key,
    required this.catName,
    required this.catImgUrl
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<PhotoModel> catWallList;
  bool isLoading=true;
  getCatWall() async
  {
    catWallList=await ApiOperation.searchWallpaper(widget.catName);
    setState(() {
      isLoading=false;
    });
  }
   @override
  void initState() {
    // TODO: implement initState
     getCatWall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar
        (
        centerTitle:true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title:CustomAppBar(word1: "Ultra",word2: "Wall",),
      ),
      body: isLoading? Center(child: CircularProgressIndicator(),)
          :SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: "categoryAnimation",
           child: Stack(
                children: [
                  Image.network(
           
                    height: 300,
                      width: MediaQuery.of(context).size.width,//take screen width
                        fit: BoxFit.fill,
                      widget.catImgUrl ??
                      "https://img.freepik.com/free-photo/view-heart-shape-with-assortment-food-categories_23-2150825044.jpg?t=st=1723225041~exp=1723228641~hmac=ec633a2bd6f3d85b4d3b316bef7af744387ee5b017f196e83e174c8a92e4df88&w=1480"
                       ),
                  Container(  // to cover the image
                    height: 300,
                    width: MediaQuery.of(context).size.width,//take screen width
                    color: Colors.black38,
                  ),
                  //text on the image
                  Positioned(
                    top: 50,
                    left: 150,
                    child: Column(
                      children: [
                         const Text(
                             "Category",
                           style: TextStyle(fontWeight: FontWeight.w600,fontSize:30, color: Colors.white70),
                         ),
                        Text(
                          widget.catName ,
                          style: const TextStyle(fontWeight: FontWeight.bold,fontSize:40, color: Colors.white),
                        ),
                      ],
                    ),
                  )
           
                ],
              ),
         ),
            SizedBox(height: 20,),
          ///grid view
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),

              height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 300,//height of the box of grid
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                ) ,
                itemCount: 300,
                itemBuilder: (context,index)
                {

                  return InkWell(
                    onTap: ()
                    {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FullScreen(imgUrl: catWallList[index].imgSrc)));
                    },
                    child: Hero(
                      tag: "fullscreenAnimation",
                      child: Container(
                        height: 400,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.amberAccent,
                             ),
                      
                        child:
                        ClipRRect(
                          //used for clip image in rectangle shape
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              height: 400,
                              width: 50,
                              fit: BoxFit.cover,
                              catWallList[index].imgSrc??
                              "https://img.freepik.com/premium-psd/state-art-smartphone-design-mock-up_23-2149543586.jpg?w=740"),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),

    );
  }
}

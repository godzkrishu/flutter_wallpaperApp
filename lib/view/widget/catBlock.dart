import 'package:flutter/material.dart';
import 'package:wallpaperapp/view/screens/category.dart';
class CatBlock extends StatelessWidget {
  String imgUrl;
  String catName;
 CatBlock({super.key,
   required this.imgUrl,
   required this.catName,
 });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryScreen(catName: catName, catImgUrl: imgUrl)));
      },
      child: Hero(
        tag: "categoryAnimation",// use this tag on  second screen also
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 10
          ),
        
          child: Stack(
            children: [
              ClipRRect(//clip the image
                  borderRadius:BorderRadius.circular(12),
                  child: Image.network(
                    height: 100,
                      width: 200,
                      fit: BoxFit.fill,
                      imgUrl?? "https://img.freepik.com/free-photo/futuristic-style-possums-wearing-clothing_23-2151039133.jpg?t=st=1722958243~exp=1722961843~hmac=1fe4fd53b281c00874f696dd4310b0a3894ad55ddcc9f33706278b1792c3b83e&w=1800")
              ),
              Container(
                width: 200,
                height:100 ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black26,
                ),
              ),
              Positioned(// this is  box that can be anywhere in screen by left , right .. property
                left: 100,
                top: 40,
                child: Text(
                  catName??"AI",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

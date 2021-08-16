import 'package:flutter/material.dart';
import 'package:foood/models/Category.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Loading.dart';


class CategoryWidget extends StatelessWidget {
  final CategoryModel categore;

  const CategoryWidget({Key? key, required this.categore}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Stack(
        children: <Widget>[
          Container(
            width: 140,
            height: 160,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(child: Align(
                      alignment: Alignment.center,
                      child: Loading(),
                    )),
                    Center(
                      child: FadeInImage.memoryNetwork(placeholder: kTransparentImage, image: categore.image!),
                    )
                  ],
                )),
          ),

          Container(
            width: 140,
            height: 160,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.05),
                    Colors.black.withOpacity(0.025),
                  ],
                )),
          ),

          Positioned.fill(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(categore.name!, style:TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w300,))))
        ],
      ),
    );
  }
}
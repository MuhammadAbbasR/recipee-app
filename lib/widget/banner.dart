import 'package:flutter/material.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key});



  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 170,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.green
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text("Cook the best \nrecipes at home",
                  style: TextStyle(
                    height: 1.1,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,

                  ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 33),
                        elevation: 0
                      ),
                      onPressed: () {

                  },
                      child: Text("Explore",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      )

                  ),

                ],
              )
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipeapp/widget/MyButton.dart';
import 'package:recipeapp/widget/textfield.dart';


class LoginScreen extends StatelessWidget {
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              Icons.lock_open_rounded,
              size: 100,
              color: Colors.black,
            ),

            SizedBox(height: 25,),

            Text("Recipe App",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black
            ),
            ),
            SizedBox(height: 25,),
            Textfield(
              controller: emailController,
              hinttext: 'Email',
              obscuretext: false,),
            SizedBox(height: 25,),
            Textfield(
              controller: passwordController,
              hinttext: 'password',
              obscuretext: true),
            SizedBox(height: 25,),
            MyButton(onTap: (){

            }, text: "Sign in"),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member ?",
                style: TextStyle(
                  color: Colors.black,
                 // fontWeight: FontWeight.bold,
                ),

                ),
                SizedBox(width: 4,),

                GestureDetector(
                  onTap: (){

                  },
                  child: Text("Register Now",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}

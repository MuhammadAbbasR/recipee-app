import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(

      backgroundColor: Colors.green.shade400,
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 100),
          child: Icon(
            Icons.lock_open_rounded,
            size: 80,
            color: Colors.white,
          ),
          ),

          Padding(padding: EdgeInsets.all(25),

          child: Divider(
            color: Colors.white,
          ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text("LOGOUT",
              style: TextStyle(
                color: Colors.white
              ),
              ),
              leading: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          )

        ],
      ),



    );
  }
}

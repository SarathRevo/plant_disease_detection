import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Agri Doctor"),
        backgroundColor: Colors.green,
      ),
      body: Container(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(


              child:Row(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 30,top: 30,left:10,right: 10),
                  margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  child: Column(
                    children: [
                      Text("Open Camera",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),) ,
                      GestureDetector(
                        child: Icon(
                          Icons.camera,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(bottom: 30,top: 30,left:10,right: 10),
                  margin: EdgeInsets.only(left: 70.0),
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  child: Column(
                    children: [
                      Text("Open Gallery",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),) ,
                      GestureDetector(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ),

              ],



              )
            ),





          ],
        ),
      ),

    );
  }
}

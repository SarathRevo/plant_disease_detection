

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading=true;
  late File? _image;
  late List _output;
  final picker=ImagePicker();
  void initState(){
    super.initState();
    loadModel().then((value){
      setState((){

      });
    });
  }
  detectImage(File image) async {
    print("in detect");

    var output=await Tflite.runModelOnImage(path: image.path,numResults: 4,threshold: 0.6);
    setState(() {
      print("in set state");
      _output=output!;
      print(_output);
      _loading=false;
      print(_loading);
    });
  }
  loadModel() async{
    print("in load model");
    await Tflite.loadModel(model: 'assets/model.tflite',labels: 'assets/model.txt',numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);
  }
  @override
  void dispose(){
    super.dispose();
  }
  pickImage() async{
    var image=await picker.pickImage(source: ImageSource.camera,);
    if(image==null) return null;
    setState(() {
      _image=File(image.path);
    });
    detectImage(File(_image!.path));
  }
  pickGalleryImage() async{
    var image=await picker.pickImage(source: ImageSource.gallery);
    if(image==null) return null;
    setState(() {
      _image=File(image.path);
    });
    print("in detect");
    print(image.path);
    var output=await Tflite.runModelOnImage(path: image.path,numResults: 4,threshold: 0.6);
    setState(() {
      print("in set state");
      _output=output!;
      print(_output);
      _loading=false;
    });
  }



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
              height: 20,
            ),
            Center(
              child: Text("Select Plant Image",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.red),),
            ),
            SizedBox(
              height: 10,
            ),

            Container(


              child:Row(
              children: [

                Container(
                  padding: EdgeInsets.only(bottom: 30,top: 30,left:10,right: 10),
                  margin: EdgeInsets.only(left: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white70
                  ),
                  child: Column(
                    children: [

                      Text("Open Camera",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),) ,
                      GestureDetector(
                        onTap: pickImage,

                        child: Icon(
                          Icons.camera,
                          color: Colors.black,
                          size: 50,

                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(bottom: 30,top: 30,left:10,right: 10),
                  margin: EdgeInsets.only(left: 70.0),
                  decoration: BoxDecoration(
                      color: Colors.white70
                  ),
                  child: Column(
                    children: [
                      Text("Open Gallery",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),) ,
                      GestureDetector(
                        onTap: pickGalleryImage,
                        child: Icon(
                          Icons.image,
                          color: Colors.black,
                          size: 50,
                        ),
                      )
                    ],
                  ),
                ),


              ],



              )
            ),
            SizedBox(
              height: 80,
            ),
            Center(
                child: _loading ?
                Container(
                  width: 350,
                  child: Column(children: [
                    Image.asset('assets/agri.png'),
                    //   SizedBox(height: 10,)
                  ],),
                ):Container(
                  child: Column(
                    children: [
                      Container(
                          height: 250,
                          child: Image.file(File(_image!.path))
                      ),
                      SizedBox(height: 10,),
                      _output !=null && _output.length!=0 ? Text('Your plant is predicted as',style: TextStyle(color: Colors.black,fontSize: 20),) : Container(),
                      SizedBox(
                        height: 10,
                      ),
                      _output!=null && _output[0]['label']!='Healthy'? Text('${_output[0]['label']}',style: TextStyle(color: Colors.red,fontSize: 20,fontWeight: FontWeight.bold),) : Text('${_output[0]['label']}',style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                )
            ),





          ],
        ),
      ),

    );
  }
}

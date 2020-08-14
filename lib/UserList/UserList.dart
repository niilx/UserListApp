import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:userlist/ProjectResource.dart';
import 'package:userlist/UserDetails/UserDetails.dart';
import 'package:userlist/UserList/ProviderDataModel.dart';


class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  var combiner;
  @override
  initState() {
     combiner = Provider.of<ProviderData>(context, listen: false);
     combiner.checkInternetConnection();
     combiner.getDatas();

    super.initState();
  }

  @override
  dispose(){
  super.dispose();
  }



  getUserList(){

    getItem(int index, var data){
      String name= "", _color = "";
      int year = 0;
      try{ name = data.response[index]["name"]; }catch(e){ print(e);}
      try{
        _color = data.response[index]["color"];
        if(_color.isNotEmpty){
          _color = "0xff"+_color.substring(1);
        }
      }catch(e){ print(e);}
      try{ year = data.response[index]["year"]; }catch(e){ print(e);}

      return InkWell(
        onTap: (){
          print(data.response[index]);
          Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(userData: data.response[index],)));
        },
        child: Card(
            color: Color(int.tryParse(_color)),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text("Name: ",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      Text(name,style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: <Widget>[
                      Text("Year: ",style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                      Text(year.toString(),style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white),),
                    ],
                  ),
                  SizedBox(height: 5,),
                ],
              ),
            )
        ),
      );
    }



    return Consumer<ProviderData>(
      builder: (context,data,child){
        print("test");
        print(data.response);
        return Container(
          padding: EdgeInsets.all(15),
          child: data.response==null?
          Center(child: CircularProgressIndicator()):
          data.internetCheck==false?
          Center(child: Text("No internet connection")):

          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: data.response.length,
            itemBuilder: (BuildContext context, int index){
              return getItem(index, data);
            },
          ),
        );
      },

    );
  }


  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Title(child: Text("User List"),color: Colors.white, ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(ProjectResource.screenWidth*0.05),
          ),
        ),
      ),
      body: SafeArea(
        child: getUserList(),
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        combiner.getMoreDatas();
      }, label: Text("See more user")),
    );
  }



}
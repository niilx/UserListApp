import 'package:flutter/material.dart';
import 'package:userlist/ProjectResource.dart';

final globalScaffoldUserDetailsKey = GlobalKey<ScaffoldState>();

class UserDetails extends StatefulWidget {
  dynamic userData;
  UserDetails({this.userData});
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose(){
    super.dispose();
  }


  //Designing user details
  _getUserDetails(){
    var textStyle1 = TextStyle(fontWeight: FontWeight.bold, color: Colors.black);
    var textStyle2 = TextStyle(fontWeight: FontWeight.normal, color: Colors.black54);
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: CircleAvatar(maxRadius: 55, child: Icon(Icons.person,size:30,),)
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Text("ID: ",style: textStyle1 ),
                Text(widget.userData["id"].toString(),style: textStyle2 ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Text("Name: ",style: textStyle1,),
                Text(widget.userData["name"].toString(),style: textStyle2,),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Text("Year: ",style: textStyle1,),
                Text(widget.userData["year"].toString(),style: textStyle2,),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Text("Color: ",style: textStyle1,),
                Text(widget.userData["color"].toString(),style: textStyle2,),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: <Widget>[
                Text("Pantone Value: ",style: textStyle1,),
                Text(widget.userData["pantone_value"].toString(),style: textStyle2,),
              ],
            ),
          ),
          Expanded(flex: 50,child: Container(),)
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    ProjectResource.setScreenSize(context);
    return Scaffold(
      key: globalScaffoldUserDetailsKey,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Title(child: Text("User Details"),color: Colors.white, ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(ProjectResource.screenWidth*0.05),
          ),
        ),
      ),
      body: SafeArea(
        child: _getUserDetails(),
      ),
    );
  }
}

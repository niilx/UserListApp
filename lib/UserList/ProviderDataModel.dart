import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:userlist/ProjectResource.dart';

class ProviderData extends ChangeNotifier{

  List< Map<String,dynamic> > response = List() ;
  List< Map<String,dynamic> > moreData = List() ;

  int pageNo;

  getData() => response;


  bool internetCheck = true;



  checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com').timeout(
          const Duration(seconds: 15));

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internetCheck = true;
      }
    } on SocketException catch (_) {
      print(_);
      internetCheck = false;
    } on TimeoutException catch (_) {
      internetCheck = false;
    }
  }

  checkInternetConnection(){
    checkInternet();
  }


  getDatas() async{
    pageNo = 1;
   await getListData();
    print("Here:");
    print(response);
    notifyListeners();
  }

  getMoreDatas() async{
    pageNo ++;
    await getListData();
    notifyListeners();
  }

  getListData() async {
    String url = ProjectResource.baseUrl+"/api/unknown/?page="+pageNo.toString();
    try {
      var result = await http.get(url).timeout(const Duration(seconds: 15));
      print("URL: $url");
      print(result.body);
     var list =  json.decode(utf8.decode(result.bodyBytes));
     if(list["data"].length == 0){
       print("NO MORE DATA");
       ProjectResource.showToast("NO MORE USER..", false, "center");
     }
     for(int i = 0; i<list["data"].length; i++){
       if(response.contains(list["data"][i])){}else {
         response.add(list["data"][i]);
       }
     }
    }
    catch (exception, stacktrace) {
      print(exception);
      print(stacktrace);
    }
  }

}
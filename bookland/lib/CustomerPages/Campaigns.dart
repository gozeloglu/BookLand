import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_paginator/flutter_paginator.dart';
import 'package:bookland/elements/appBar.dart';
import 'package:bookland/elements/bottomNavigatorBar.dart';


int total = 0;
SplayTreeSet campaignSet = new SplayTreeSet();
var globalCampaignsContext;
int deletedcampaignId = -1;

List<String> imgURLlist = ["https://images-na.ssl-images-amazon.com/images/I/51pQPZjF-hL._AC_SL1000_.jpg",
  "https://thumbs.dreamstime.com/b/celebration-background-golden-champagne-bottle-confetti-stars-party-streamers-christmas-birthday-wedding-flat-lay-161039153.jpg",
  "https://images.unsplash.com/photo-1513151233558-d860c5398176?ixlib=rb-1.2.1&w=1000&q=80",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSomn0EWJ4eTQu4mTWneupKdB1GxebNqvL0hzfWhz2jmli9fR8e&usqp=CAU",
  "https://i.pinimg.com/originals/b7/c6/07/b7c6079ee7e5dc09dfeec57393c719ba.jpg"];

class CampaignsStateless extends StatelessWidget {
  CampaignsStateless(int campaignId) {
    deletedcampaignId = campaignId;
    if (campaignSet.contains(deletedcampaignId)) {
      campaignSet.remove(deletedcampaignId);
    }
  }

  @override
  Widget build(BuildContext context) {
    globalCampaignsContext = context;
    GlobalKey<PaginatorState> paginatorGlobalKey = GlobalKey();


    return Scaffold(
      appBar: MyAppBar(pageTitle: "Campaigns", loginIcon: false,
        back: false,
        filter_list: false,
        search: true, ),
      body: Paginator.listView(
        key: paginatorGlobalKey,
        pageLoadFuture: sendCampaignDataRequest,
        pageItemsGetter: listCampaignGetter,
        listItemBuilder: listCampaignBuilder,
        loadingWidgetBuilder: loadingWidgetMaker,
        errorWidgetBuilder: errorWidgetMaker,
        emptyListWidgetBuilder: emptyListWidgetMaker,
        totalItemsGetter: totalPagesGetter,
        pageErrorChecker: pageErrorChecker,
        scrollPhysics: BouncingScrollPhysics(),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          paginatorGlobalKey.currentState.changeState(
              pageLoadFuture: sendCampaignDataRequest, resetState: true);
        },
        child: Icon(Icons.refresh),
      ),


      bottomNavigationBar: MyBottomNavigatorBar(),

    );
  }

  void getTotalCount() async {
    try {
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      var urlcampaignCount = "http://10.0.2.2:8080/getCampaignCount";

      String _urlcampaignCount = Uri.encodeFull(urlcampaignCount);
      http.Response responseCount = await http.get(
        _urlcampaignCount,
        headers: <String, String>{'authorization': basicAuth},
      );

      if (responseCount.statusCode == 200) {
        total = json.decode(responseCount.body);

      } else {
        print(responseCount.statusCode);
        throw Exception("Campaigns are not retrieved!");
      }
    } catch (e) {
      print("SocketException");
      throw Exception(e);
    }
  }

  Future<CampaignsData> sendCampaignDataRequest(int page) async {
    try {
      getTotalCount();
      var url = "http://10.0.2.2:8080/getCampaigns/$page/10";
      print(url);
      String username = 'Daryl';
      String password = 'WalkingDead';
      String basicAuth =
          'Basic ' + base64Encode(utf8.encode('$username:$password'));
      String _url = Uri.encodeFull(url);
      http.Response response = await http.get(
        _url,
        headers: <String, String>{'authorization': basicAuth},
      );
      return CampaignsData.fromResponse(response);
    } catch (e) {
      if (e is IOException) {
        return CampaignsData.withError("Please check your internet connection.");
      } else {
        print(e.toString());
        return CampaignsData.withError("Something went wrong.");
      }
    }
  }

  List<dynamic> listCampaignGetter(CampaignsData campaignData) {
    List<dynamic> CampaignNameList = [];
    List<int> isbnList = [];
    for (int i = 0; i < campaignData.campaignidsList.length; i++) {
      String val =  "\n\t\t\t\t\t\t\t\t\t\t\t"+campaignData.campaignNameList[i] +
       "\n\n" +
          "Coupon Code\t"+campaignData.couponcodesList[i] +
           "\n" +
          "Chance to Get\t\%"+campaignData.couponDiscountList[i] + "\tDiscount"+
          "\n" +
          "Only For\t"+campaignData.participantQuantityList[i]+ "\tPerson !"+
          "\n\n" +
          "Expiration Date:\t"+campaignData.endDateList[i];




      CampaignNameList.add(val);
    }

    return CampaignNameList;
  }

  Widget loadingWidgetMaker() {
    return Container(
      alignment: Alignment.center,
      height: 160.0,
      child: CircularProgressIndicator(),
    );
  }

  Widget listCampaignBuilder(value, int index) {

      return Container(
          width: 500,
          height: 200,
          //color: Colors.greenAccent,
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(imgURLlist[index%5]),
                  fit: BoxFit.cover),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1.0),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child : ListTile(
            leading: Text("\t\t\t"),
          title: Text(value,style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),) ,
          onTap: () {
            Timer(Duration(seconds: 1), () {
                showDialog(
                  context: globalCampaignsContext,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      backgroundColor: Colors.yellowAccent,
                      title: new Text("Let's Go"),
                      content: new Text("Come on, don't miss this opportunity and start exploring great books with us :)"),
                      actions: <Widget>[
                        // usually buttons at the bottom of the dialog
                        new FlatButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );

            });


          }))
      ;

  }

  Widget errorWidgetMaker(CampaignsData campaignsData, retryListener) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(campaignsData.errorMessage),
        ),
        FlatButton(
          onPressed: retryListener,
          child: Text("Retry"),
        )
      ],
    );
  }

  Widget emptyListWidgetMaker(CampaignsData campsData) {
    campaignSet.clear();
    campsData.campaignidsList.clear();
    campsData.couponcodesList.clear();
    campsData.couponDiscountList.clear();
    campsData.participantQuantityList.clear();
    campsData.campaignNameList.clear();
    campsData.endDateList.clear();
    return Center(
      child: Text("No campaign in the list"),
    );
  }

  int totalPagesGetter(CampaignsData campsData) {
    // TODO This should be fixed
    return total;
  }

  bool pageErrorChecker(CampaignsData campsData) {
    return campsData.statusCode != 200;
  }
}

class CampaignsData {
  List<dynamic> campaignidsList = new List<dynamic>();
  List<dynamic> couponcodesList = new List<dynamic>();
  List<dynamic> couponDiscountList = new List<dynamic>();
  List<dynamic> participantQuantityList = new List<dynamic>();
  List<dynamic> campaignNameList = new List<dynamic>();
  List<dynamic> endDateList = new List<dynamic>();

  int statusCode;
  String errorMessage;
  int nItems;

  int campaignId;
  String couponCode;
  String coupondiscount;
  String participantQuantity;
  String campaignName;
  String endDate;

  CampaignsData.fromResponse(http.Response response) {
    this.statusCode = response.statusCode;
    List jsonData = json.decode(response.body);
    //print(jsonData);

    // isbnSet.clear();
    if (campaignSet.contains(deletedcampaignId)) {
      campaignSet.remove(deletedcampaignId);
    }

    for (int i = 0; i < jsonData.length; i++) {
      campaignidsList.add(jsonData[i]["campaignId"].toString());
      couponcodesList.add(jsonData[i]["couponCode"].toString());
      couponDiscountList.add(jsonData[i]["couponDiscount"].toString());
      participantQuantityList.add(jsonData[i]["participantQuantity"].toString());
      campaignNameList.add(jsonData[i]["campaignName"]);
      endDateList.add(jsonData[i]["endDate"]);
    }

    nItems = campaignidsList.length;
  }

  CampaignsData.withError(String errorMessage) {
    this.errorMessage = errorMessage;
  }
}

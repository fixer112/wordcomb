import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import './listview.dart';
//import 'package:admob_flutter/admob_flutter.dart';

void main() {
  //Admob.initialize('ca-app-pub-8524957116437815~5437189004');
  runApp(new MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue,
      fontFamily: 'Montserrat',
    ),
    home: new Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController wordController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int wordLength;
  String word;
  List words = [];
  Map jsonWord;
  //int _clicks = 1;
  bool enableClick = true;
  //String appID = "ca-app-pub-8524957116437815~5437189004";
  // String topbannerID = "ca-app-pub-8524957116437815/9731657232";
  // String bottombannerID = "ca-app-pub-8524957116437815/6824693800";
  // String middlebannerID = "ca-app-pub-8524957116437815/1369364756";
  // String intID = "ca-app-pub-8524957116437815/1141407699";
  // String testID = "ca-app-pub-3940256099942544/6300978111";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;

  int maxSec = 10;

  /* AdmobInterstitial interstitialAd = AdmobInterstitial(
    adUnitId: 'ca-app-pub-3940256099942544/1033173712',
  ); */

  _loadJson() async {
    String jsonCrossword = await DefaultAssetBundle.of(context)
        .loadString('assets/json/words.json');
    //return await DefaultAssetBundle.of(context).loadString('assets/data/crossword.json');
    //return jsonCrossword;
    jsonWord = jsonDecode(jsonCrossword);
    // var data = await Request().getDick();
    // print(data.body);
  }

  Future<List> permutation(String str, String prefix,
      int lengthOfPermutationString, Stopwatch time) async {
    //print(maxSec);
    if (time.elapsed.inSeconds >= maxSec) {
      return words;
    }
    if (prefix.length == lengthOfPermutationString) {
      if (jsonWord[prefix] != null) {
        words.add(prefix);
      }

      //});

    } else {
      for (int i = 0; i < str.length; i++) {
        String ros = str.substring(0, i) + str.substring(i + 1);

        // Recurvise call
        permutation(ros, prefix + str[i], lengthOfPermutationString, time);
      }
    }
    words = words.toSet().toList();
    return words;
  }

  @override
  void initState() {
    super.initState();
    //loading = false;
    _loadJson();
  }

  @override
  void dispose() {
    wordController.dispose();
    lengthController.dispose();
    //interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("wordCombo"),
      ),
      //backgroundColor: Colors.blue,
      body: Container(
        child: Column(
          children: <Widget>[
            /* AdmobBanner(
              adUnitId: testID,
              adSize: AdmobBannerSize.BANNER,
            ), */
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    wordLength = value.length;
                  });
                },
                controller: wordController,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  labelText: "Type Word to Unscramble",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      //mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      //verticalDirection: VerticalDirection.up,
                      children: [
                        Container(
                          width: width / 3,
                          child: Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: lengthController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Cannot be empty';
                                }
                                if (int.parse(value) > wordLength) {
                                  return 'Cannot be greater than $wordLength';
                                }
                                /* if (int.parse(value) > 6) {
                                  return 'Cannot be greater than 6';
                                } */
                                return null;
                              },
                              keyboardType: TextInputType.numberWithOptions(),
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                labelText: "Lenght",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(
                                    color: Colors.blue,
                                    width: 3.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          width: width / 3,

                          //margin: EdgeInsets.only(left: 10),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                maxSec = value != "" ? int.parse(value) : 10;
                              });
                            },
                            //controller: wordController,
                            keyboardType: TextInputType.numberWithOptions(),
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
                              labelText:
                                  "Max Excecution time. 10sec is default",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 3.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  loading
                      ? Container(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Center(
                          child: RaisedButton(
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text("Find"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                // final snackBar = SnackBar(content: Text('Loading Unscrambled Words......'));
                                // _scaffoldKey.currentState.showSnackBar(snackBar);

                                // if ((_clicks % 5 == 0 || _clicks == 2) &&
                                //     enableClick) {
                                //   interstitialAd.load();
                                //   interstitialAd.show();
                                // }
                                // if (_clicks >= 10) {
                                //   enableClick = false;
                                // }
                                // _clicks++;
                                //print("clicking $_clicks");

                                //setState(() {
                                word = wordController.text.toLowerCase();
                                // });
                                words = [];

                                setState(() {
                                  loading = true;
                                });
                                //print(maxSec);
                                await Future.delayed(Duration(seconds: 1));

                                final stop = Stopwatch()..start();
                                permutation(word, "",
                                        int.parse(lengthController.text), stop)
                                    .then((List list) {
                                  print("time:${stop.elapsed}");
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.all(10.0)),

            /* AdmobBanner(
              adUnitId: testID,
              adSize: AdmobBannerSize.BANNER,
            ), */
            Center(
              child: Column(
                children: [
                  Text("Note: Default execution time is 10 seconds.",
                      style: TextStyle(color: Colors.red)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Total Unscrambled Words : " + words.length.toString()),
                ],
              ),
            ),
            Expanded(
              child: Lister(data: words),
            ),
            /* AdmobBanner(
              adUnitId: testID,
              adSize: AdmobBannerSize.BANNER,
            ), */
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:free_space_demo/common/api.dart';
import 'package:free_space_demo/model/Aminities.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:free_space_demo/model/Result.dart';
import 'package:free_space_demo/model/Series.dart';

void main() {
  runApp(DashboardScreen());
}

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DashboardScreen();
  }
}

class _DashboardScreen extends State<DashboardScreen> {
  // Create series list with multiple series
  static List<charts.Series<Series, String>> _createSampleData(Result dataObj) {
    List<Series> todayData = [];
    List<Series> previousData = [];
    for (int i = 0; i < dataObj.occupancyList.length; i++) {
      todayData.add(new Series(
          time: dataObj.occupancyList[i].Time,
          value: int.parse(dataObj.occupancyList[i].Today)));

      previousData.add(new Series(
          time: dataObj.occupancyList[i].Time,
          value: int.parse(dataObj.occupancyList[i].Previous)));
    }
    return [
      new charts.Series<Series, String>(
        id: 'Today',
        domainFn: (Series sales, _) => sales.time,
        measureFn: (Series sales, _) => sales.value,
        data: todayData,
      ),
      new charts.Series<Series, String>(
        id: 'Previous',
        domainFn: (Series sales, _) => sales.time,
        measureFn: (Series sales, _) => sales.value,
        data: previousData,
      ),
    ];
  }

  bool _loading;
  var dataResult;
  var seriesList;

  void getAminities() async {
    API api = API();
    await api.getDataFromAPI();
    dataResult = api.dataObj;
    seriesList = _createSampleData(dataResult);
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _loading = true;
    getAminities();
    setUpTimedFetch();
  }

  setUpTimedFetch() {
    Timer.periodic(Duration(milliseconds: 30000), (timer) {
      setState(() {
        _loading = true;
        getAminities();
      });
    });
  }

  barChart() {
    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      barGroupingType: charts.BarGroupingType.stacked,
      defaultRenderer: charts.BarRendererConfig(
        groupingType: charts.BarGroupingType.stacked,
        strokeWidthPx: 1.0,
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.NoneRenderSpec(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                        padding: new EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              child: Row(children: [
                                Expanded(
                                    flex: 1, //
                                    child: Container(
                                      padding: EdgeInsets.only(right: 10.0),
                                      decoration: new BoxDecoration(
                                          border: new Border(
                                              right: new BorderSide(
                                                  width: 2.0,
                                                  color: Colors.white24))),
                                      child: ClipOval(
                                        child: Hero(
                                          tag: dataResult.ProfileIamge,
                                          child: Image.network(
                                            dataResult.ProfileIamge,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 7, //
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hello,",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  getColorFromHex("#2f2b35")),
                                          textAlign: TextAlign.left,
                                        ),
                                        Text(
                                          dataResult.Name,
                                          //"Grayce Lemke",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color:
                                                  getColorFromHex("#2f2b35")),
                                        ),
                                      ],
                                    )),
                                Expanded(
                                    flex: 1, //
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {});
                                        },
                                        child: Icon(
                                          Icons.notifications_none,
                                          color: getColorFromHex("#03d693"),
                                        ))),
                              ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: getColorFromHex("#f8f6f9"),
                                  ),
                                  color: getColorFromHex("#f8f6f9"),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              padding: new EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Today's Scheduler",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: getColorFromHex("#2f2b35")),
                                    ),
                                    ButtonTheme(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: RaisedButton(
                                        onPressed: () {},
                                        child: Text("Group A",
                                            style: new TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.white)),
                                      ),
                                      buttonColor: getColorFromHex("#f88a3b"),
                                      height: 30,
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                            flex: 8, //
                                            child: Text(
                                              "Work from Office",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: getColorFromHex(
                                                      "#2f2b35")),
                                            )),
                                        Expanded(
                                            flex: 2, //
                                            child: new InkWell(
                                              onTap: () {},
                                              child: new Container(
                                                //width: 100.0,
                                                height: 35.0,
                                                decoration: new BoxDecoration(
                                                  color: getColorFromHex(
                                                      "#03d693"),
                                                  border: new Border.all(
                                                      color: getColorFromHex(
                                                          "#03d693"),
                                                      width: 2.0),
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: new Center(
                                                  child: new Text(
                                                    'Change',
                                                    style: new TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 5, 5),
                                        child: Text(
                                          "Details",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  getColorFromHex("#2f2b35")),
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 5, 5),
                                        child: Text(
                                          "OFFICE ADDRESS",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  getColorFromHex("#2f2b35")),
                                        )),
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 5, 5),
                                        child: Text(
                                          dataResult.Address,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  getColorFromHex("#2f2b35")),
                                        )),
                                    Container(
                                        padding: new EdgeInsets.fromLTRB(
                                            0, 10, 10, 10),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "AMENITIES",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: getColorFromHex(
                                                        "#2f2b35")),
                                              ),
                                              SizedBox(
                                                  height: 195,
                                                  child: buildArticleList(
                                                      dataResult
                                                          .aminitiesList)),
                                            ])),
                                    Container(
                                        padding: new EdgeInsets.fromLTRB(
                                            0, 10, 10, 10),
                                        child: Column(children: [
                                          Text("BUILDING OCCUPANCY",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: getColorFromHex(
                                                      "#2f2b35"))),
                                        ])),
                                    SizedBox(height: 200, child: barChart()),
                                  ]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: getColorFromHex("#f8f6f9"),
                                    ),
                                    color: getColorFromHex("#f8f6f9"),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                padding: new EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Scan SPOT tag to check-in!",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: getColorFromHex("#2f2b35")),
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Container(
                                          height: 40.0,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: getColorFromHex(
                                                      "#03d693"),
                                                  style: BorderStyle.solid,
                                                  width: 1.0,
                                                ),
                                                color:
                                                    getColorFromHex("#03d693"),
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Center(
                                                    child: Text(
                                                      "Check-In",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily:
                                                            'Montserrat',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 1,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ],
                                ))
                          ],
                        )))));
  }

  Widget buildListTile(List<Aminities> articles, int pos) {
    return ListTile(
      leading: ClipOval(
        child: Hero(
          tag: pos,
          child: Image.network(
            articles[pos].icon,
            fit: BoxFit.fill,
            height: 40.0,
            width: 40.0,
          ),
        ),
        // ),
      ),
      title: Text(
        articles[pos].title,
        style: TextStyle(color: getColorFromHex("#2f2b35"), fontSize: 14),
      ),
    );
  }

  Widget buildCard(List<Aminities> articles, int pos) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: getColorFromHex("#e4e4e4"),
          ),
          color: getColorFromHex("#e4e4e4"),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: buildListTile(articles, pos),
    );
  }

  Widget buildArticleList(List<Aminities> articles) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (ctx, pos) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
          child: InkWell(
            child: buildCard(articles, pos),
            onTap: () {},
          ),
        );
      },
    );
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');

    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }

    return Color(int.parse(hexColor, radix: 16));
  }
}

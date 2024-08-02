// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unnecessary_string_interpolations, sized_box_for_whitespace, avoid_unnecessary_containers, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/custom_colors.dart';
import 'package:weatherapp/services/GetLocation.dart';
import 'package:weatherapp/services/API/GetData.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GetLocation _getLocation = GetLocation();
  final GetData _getData = GetData();
  Map<String, dynamic> _weatherData = {};
  String todayDate = DateFormat('yMMMMd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    await _getLocation.getUserLocation();
    Map<String, dynamic> weatherData = await _getData.fetchData(
      latitude: _getLocation.latitude,
      longitude: _getLocation.longitude,
    );
    setState(() {
      _weatherData = weatherData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _weatherData.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SafeArea(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.topLeft,
                          child: Text(
                            _weatherData['locationName'],
                            style: TextStyle(
                                fontSize: 35,
                                height: 2,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.topLeft,
                          child: Text(
                            todayDate,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                                height: 1.5),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.topLeft,
                          child: Image.asset(
                            '${splitIcon(_weatherData['iconName'])}',
                            width: 100,
                            height: 100,
                          ),
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: CustomColors.dividerLine,
                        ),
                        Container(
                          height: 50,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          alignment: Alignment.topLeft,
                          child: Text(
                            _weatherData['temperatureCelsius'].toString() + '°',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(
                            'assets/icons/windspeed.png',
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(
                            'assets/icons/clouds.png',
                          ),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: CustomColors.cardColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Image.asset(
                            'assets/icons/humidity.png',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 60,
                          child: Text(
                            '${_weatherData['windKph'].toString()} KM/H',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 60,
                          child: Text(
                            '${_weatherData['cloud'].toString()} %',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                          width: 60,
                          child: Text(
                            '${_weatherData['humidity'].toString()} %',
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        'Hourly Weather',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //Print Hourly Data
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 180,
                      child: _weatherData['hourlyData'] == Null
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                // var hourData =
                                //     _weatherData['hourlyData'][index];
                                return Container(
                                  //Create card for show hourly weather data
                                  height: 120,
                                  margin: EdgeInsets.only(left: 5, right: 5),
                                  padding: EdgeInsets.all(10),
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: CustomColors.cardColor),
                                  child: Column(
                                    children: [
                                      //Print date And Time
                                      Text('Time',
                                          style: TextStyle(
                                            fontSize: 14,
                                          )),
                                      SizedBox(height: 5),
                                      Image.asset(
                                        'assets/icons/clouds.png',
                                        width: 60,
                                        height: 60,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Temp' + '°',
                                        style: TextStyle(fontSize: 25),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              itemCount: 5,
                              padding: EdgeInsets.all(2),
                            ),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  String splitIcon(String url) {
    String path = url.replaceFirst(RegExp(r'^/+'), '');
    print(_weatherData['hourlyData']);
    print('assets/$path');
    return 'assets/$path';
  }
}

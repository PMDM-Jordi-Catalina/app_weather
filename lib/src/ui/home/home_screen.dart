import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:tiempo_app/src/model/Forecast.dart';

import '../../service/tiempo_service.dart';

class HomeScreen extends StatefulWidget {
  final TiempoService service = TiempoService();
  Position? position = null;
  DateTime? lastDate = null;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? ciudad = null;
  String parseDate(String date) {
    DateTime fecha = DateTime.parse(date);
    return DateFormat('MMMM, d').format(fecha).toString();
  }

  bool esDelMismoDia(String fechaString, String fechaAnteriorString) {
    DateTime fecha = DateTime.parse(fechaString);
    DateTime fechaAnterior = DateTime.parse(fechaAnteriorString);

    return fecha.year == fechaAnterior.year &&
        fecha.month == fechaAnterior.month &&
        fecha.day == fechaAnterior.day;
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("error");
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<List<Forecast>> getWeather() async {
    final position = await determinePosition();
    return widget.service.getFiveDays(position, ciudad);
  }

  @override
  void initState() {
    // TODO: implement initState
    // getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: getWeather(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Something was wrong"),
              );
            }

            if (snapshot.data!.length > 0) {
              return Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/cloud-in-blue-sky.jpg"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              leading: IconButton(
                                icon: const Icon(Icons.menu),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 100, left: 20, right: 20),
                            child: TextField(
                              onChanged: (value) => ciudad = value,
                              style: const TextStyle(color: Colors.white),
                              textInputAction: TextInputAction.search,
                              onSubmitted: (value) => setState(() {}),
                              decoration: InputDecoration(
                                  suffix: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: "Buscar".toUpperCase(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  )),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: SizedBox(
                              height: 10,
                              width: 20,
                              child: OverflowBox(
                                minWidth: 1.0,
                                minHeight: 1.0,
                                maxWidth: MediaQuery.of(context).size.width,
                                maxHeight: MediaQuery.of(context).size.height,
                                child: Stack(children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    width: 400,
                                    height: 220,
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: 15, left: 20, right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    (snapshot.data?[0].city
                                                                .name) !=
                                                            null
                                                        ? snapshot
                                                            .data![0].city.name
                                                            .toUpperCase()
                                                        : '',
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily:
                                                            "flutterfonts"),
                                                  ),
                                                ),
                                                Center(
                                                  child: Text(
                                                    DateFormat()
                                                        .add_MMMMEEEEd()
                                                        .format(
                                                          DateTime.now(),
                                                        ),
                                                    style: TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "flutterfonts"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 50),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      (snapshot.data?[0]
                                                                  .weather !=
                                                              null)
                                                          ? snapshot
                                                              .data![0]
                                                              .weather[0]
                                                              .description
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 16,
                                                          fontFamily:
                                                              "flutterfonts"),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      (snapshot.data?[0].main !=
                                                              null)
                                                          ? "${(snapshot.data![0].main.temp - 273.15).round().toString()}\u2103"
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 50,
                                                          fontFamily:
                                                              "flutterfonts"),
                                                    ),
                                                    Text(
                                                      (snapshot.data?[0].main !=
                                                              null)
                                                          ? "min: ${(snapshot.data![0].main.tempMin - 273.15).round().toString()}\u2103 / max: ${(snapshot.data![0].main.tempMax - 273.15).round().toString()}\u2103 "
                                                          : "",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              "flutterfonts"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(right: 20),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: 120,
                                                      height: 110,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://openweathermap.org/img/wn/${snapshot.data![0].weather[0].icon}@2x.png"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      child: Text(
                                                        (snapshot.data?[0]
                                                                    .wind !=
                                                                null)
                                                            ? "viento ${snapshot.data![0].wind.speed} m/s"
                                                            : "",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                "flutterfonts"),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            padding: EdgeInsets.only(top: 120),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Otra Ciudad".toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "flutterfonts",
                                          color: Colors.black45,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    height: 150,
                                    child: ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      separatorBuilder: (context, index) =>
                                          VerticalDivider(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      itemCount: snapshot.data!.length - 1,
                                      itemBuilder: (context, index) {
                                        Forecast? forecast;
                                        (snapshot.data!.length > 0)
                                            ? forecast =
                                                snapshot.data![index + 1]
                                            : forecast = null;
                                        if (esDelMismoDia(forecast!.dtTxt,
                                            snapshot.data![index].dtTxt)) {
                                          return SizedBox();
                                        }
                                        return Container(
                                          width: 140,
                                          height: 150,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    (forecast != null)
                                                        ? parseDate(
                                                            forecast.dtTxt)
                                                        : "",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black45,
                                                        fontFamily:
                                                            "flutterfonts"),
                                                  ),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    (forecast != null)
                                                        ? "${(forecast.main.temp - 273.15).round().toString()}\u2103"
                                                        : "",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black45,
                                                        fontFamily:
                                                            "flutterfonts"),
                                                  ),
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://openweathermap.org/img/wn/${forecast!.weather[0].icon}@2x.png"),
                                                          fit: BoxFit.cover),
                                                    ),
                                                  ),
                                                  Text(
                                                    textAlign: TextAlign.center,
                                                    (forecast != null)
                                                        ? forecast.weather[0]
                                                            .description
                                                            .toLowerCase()
                                                            .replaceAllMapped(
                                                                RegExp(r'\b\w'),
                                                                (match) => match
                                                                    .group(0)!
                                                                    .toUpperCase())
                                                        : "",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black45,
                                                        fontFamily:
                                                            "flutterfonts"),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          ciudad = null;
                        });
                      },
                      child: Text("No se ha encontrado la ciudad solicitada"),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}

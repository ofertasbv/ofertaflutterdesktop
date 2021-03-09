import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/endereco_controller.dart';
import 'package:nosso/src/core/model/endereco.dart';

class EnderecoLocation extends StatefulWidget {
  Endereco endereco;

  EnderecoLocation({Key key, this.endereco}) : super(key: key);

  @override
  _EnderecoLocationState createState() =>
      _EnderecoLocationState(endereco: this.endereco);
}

class _EnderecoLocationState extends State<EnderecoLocation> {
  var enderecoController = GetIt.I.get<EnderecoController>();

  _EnderecoLocationState({this.endereco});

  double distanciaKilomentros = 0;

  Geolocator geolocator;
  Position position;

  Endereco endereco;

  Completer<GoogleMapController> completer = Completer<GoogleMapController>();

  List<Marker> allMarkers = [];

  @override
  void initState() {
    super.initState();
    getLocation();
    enderecoController.getAll();
  }

  MapType mapType = MapType.normal;
  static const LatLng center = const LatLng(-4.253467, -49.944051);

  LatLng lastMapPosition = center;

  onMapTypeButtonPressedNormal() {
    setState(() {
      mapType = MapType.normal;
    });
  }

  onMapTypeButtonPressedTerra() {
    setState(() {
      mapType = MapType.terrain;
    });
  }

  onMapTypeButtonPressedSatelite() {
    setState(() {
      mapType = MapType.satellite;
    });
  }

  onMapTypeButtonPressedHibrido() {
    setState(() {
      mapType = MapType.hybrid;
    });
  }

  onCamaraMove(CameraPosition position) {
    lastMapPosition = position.target;
  }

  criarMapa(GoogleMapController controller) {
    completer.complete(controller);
  }

  markers(Endereco e) {
    return Marker(
      markerId: MarkerId(e.logradouro),
      position: LatLng(e.latitude, e.longitude),
      infoWindow: InfoWindow(title: e.logradouro, snippet: e.numero),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );
  }

  static final CameraPosition posicaoCamera = CameraPosition(
    bearing: 192.833,
    target: LatLng(-4.253467, -49.944051),
    tilt: 54,
    zoom: 14.0,
  );

  getLocation() async {
    try {
      geolocator = Geolocator();
      LocationOptions locationOptions =
          LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
      Geolocator.getPositionStream().listen((Position position) {
        this.position = position;
      });
    } catch (e) {
      print('ERROR:$e');
    }
  }

  Future<void> goToPosition() async {
    final GoogleMapController controller = await completer.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(posicaoCamera));
  }

  movimentarCamera(double latitude, double longitude) async {
    GoogleMapController googleMapController = await completer.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 16.0,
          tilt: 20,
        ),
      ),
    );
  }

  calcularDistancia(double latMercado, double longMercado) async {
    return await Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      latMercado,
      longMercado,
    );
  }

  testeDistancia() async {
    double distanceInMeters = await Geolocator.distanceBetween(
        52.2165157, 6.9437819, 52.3546274, 4.8285838);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localzação comercial"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            height: double.infinity,
            padding: EdgeInsets.only(top: 0),
            child: Observer(
              builder: (context) {
                List<Endereco> enderecos = enderecoController.enderecos;

                if (enderecoController.error != null) {
                  return Text("Não foi possível buscar endereços");
                }

                if (enderecos == null) {
                  return GoogleMap(
                    onTap: (valor) {
                      print("Lat: ${valor.latitude}, Long: ${valor.longitude}");
                      endereco.latitude = valor.latitude;
                      endereco.longitude = valor.longitude;
                    },
                    indoorViewEnabled: true,
                    mapToolbarEnabled: true,
                    buildingsEnabled: true,
                    tiltGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    zoomGesturesEnabled: true,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    rotateGesturesEnabled: true,
                    trafficEnabled: false,
                    onCameraMove: onCamaraMove,
                    mapType: mapType,
                    onMapCreated: criarMapa,
                    initialCameraPosition: CameraPosition(
                        target: position != null
                            ? LatLng(position.latitude, position.longitude)
                            : lastMapPosition,
                        zoom: 13,
                        tilt: 54),
                    markers: markers(endereco),
                  );
                }

                allMarkers = enderecos.map((e) {
                  return Marker(
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueYellow),
                      infoWindow: InfoWindow(
                        title: e.logradouro,
                        snippet: e.logradouro + ", " + e.numero,
                      ),
                      markerId: MarkerId(e.logradouro),
                      position: LatLng(e.latitude ?? 0.0, e.longitude ?? 0.0),
                      onTap: () {
                        showDialogAlert(context, e);
                      });
                }).toList();

                return GoogleMap(
                  onTap: (valor) {
                    print("Lat: ${valor.latitude}, Long: ${valor.longitude}");
                    endereco.latitude = valor.latitude;
                    endereco.longitude = valor.longitude;
                  },
                  indoorViewEnabled: true,
                  mapToolbarEnabled: true,
                  buildingsEnabled: true,
                  tiltGesturesEnabled: true,
                  zoomControlsEnabled: false,
                  zoomGesturesEnabled: true,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  rotateGesturesEnabled: true,
                  trafficEnabled: false,
                  onCameraMove: onCamaraMove,
                  mapType: mapType,
                  onMapCreated: criarMapa,
                  initialCameraPosition: CameraPosition(
                      target: position != null
                          ? LatLng(position.latitude, position.longitude)
                          : lastMapPosition,
                      zoom: 16.0,
                      tilt: 54),
                  markers: Set.of(allMarkers),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60, right: 10),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      showDialogAlertTypeMap(context);
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    child: Icon(
                      Icons.map,
                      size: 25,
                    ),
                    tooltip: "tipo de mapa",
                    focusElevation: 5,
                    mini: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  showDialogAlert(BuildContext context, Endereco e) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Localização'),
          content: Container(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${e.logradouro}, ${e.numero}"),
                Text("${e.cidade.nome}"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text('DETALHES'),
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (BuildContext context) {
                //       return LojaDetalhes(
                //         loja: p,
                //       );
                //     },
                //   ),
                // );
              },
            ),
          ],
        );
      },
    );
  }

  showDialogAlertTypeMap(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tipo de mapa'),
          content: Container(
            height: 200,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            ConstantApi.urlNormal,
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                        ),
                        Text("Padrão"),
                      ],
                    ),
                  ),
                  onTap: () {
                    onMapTypeButtonPressedNormal();
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            ConstantApi.urlSatelite,
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                        ),
                        Text("Satélite"),
                      ],
                    ),
                  ),
                  onTap: () {
                    onMapTypeButtonPressedSatelite();
                    Navigator.of(context).pop();
                  },
                ),
                GestureDetector(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            ConstantApi.urlRelevo,
                            fit: BoxFit.cover,
                            height: 60,
                            width: 60,
                          ),
                        ),
                        Text(
                          "Híbrido",
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    onMapTypeButtonPressedHibrido();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showToast(String cardTitle, String unit) {
    Fluttertoast.showToast(
      msg:
          "Loja: $cardTitle - $unit - ${distanciaKilomentros.toStringAsPrecision(2)} km",
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.indigo,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}

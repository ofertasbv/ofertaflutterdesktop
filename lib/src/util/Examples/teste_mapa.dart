import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/loja_controller.dart';
import 'package:nosso/src/core/model/loja.dart';
import 'package:nosso/src/paginas/loja/loja_detalhes_tab.dart';

class TesteMapa extends StatefulWidget {
  const TesteMapa({
    Key key,
    this.androidFusedLocation,
  }) : super(key: key);
  final bool androidFusedLocation;

  @override
  _TesteMapaState createState() => _TesteMapaState();
}

class _TesteMapaState extends State<TesteMapa> {
  var lojaController = GetIt.I.get<LojaController>();
  var loja = Loja();
  var selectedCard = 'WEIGHT';

  Position posicaoAtual;
  List<LatLng> latLng = <LatLng>[];
  List<Marker> allMarkers = [];
  MapType mapType = MapType.normal;

  Completer<GoogleMapController> completer = Completer();

  @override
  void initState() {
    super.initState();
    localizacaoAtual();
    lojaController.getAll();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      posicaoAtual = null;
    });
    localizacaoAtual();
  }

  selectCard(cardTitle) {
    setState(() {
      selectedCard = cardTitle;
    });
  }

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

  void criarMapa(GoogleMapController controller) async {
    await completer.complete(controller);
  }

  localizacaoAtual() {
    Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).then((posicao) {
      if (mounted) {
        setState(() => posicaoAtual = posicao);
      }
    }).catchError((e) {
      //
    });
  }

  markers(Loja p) {
    return Marker(
      markerId: MarkerId(p.nome),
      position: LatLng(p.enderecos[0].latitude, p.enderecos[0].longitude),
      infoWindow: InfoWindow(title: p.nome, snippet: p.enderecos[0].logradouro),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
    );
  }

  movimentarCamera(double latitude, double longitude) async {
    GoogleMapController googleMapController = await completer.future;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 18.0,
          tilt: 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Localzação comercial"),
      ),
      body: posicaoAtual == null
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Center(child: CircularProgressIndicator()),
                  FloatingActionButton.extended(
                    onPressed: () {
                      //_getUserLocation();
                    },
                    label: Text('Localizando...'),
                  )
                ],
              ),
            )
          : Stack(
              children: [
                Observer(
                  builder: (context) {
                    List<Loja> lojas = lojaController.lojas;

                    if (lojaController.error != null) {
                      return Text("Não foi possível buscar lojas");
                    }

                    if (lojas == null) {
                      return GoogleMap(
                        onMapCreated: criarMapa,
                        mapType: mapType,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(
                            posicaoAtual.latitude,
                            posicaoAtual.longitude,
                          ),
                          zoom: 12.0,
                        ),
                        myLocationEnabled: true,
                        mapToolbarEnabled: false,
                      );
                    }

                    allMarkers = lojas.map((p) {
                      return Marker(
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueYellow),
                          infoWindow: InfoWindow(
                            title: p.nome,
                            snippet: p.enderecos[0].logradouro +
                                ", " +
                                p.enderecos[0].numero,
                          ),
                          markerId: MarkerId(p.nome),
                          position: LatLng(p.enderecos[0].latitude ?? 0.0,
                              p.enderecos[0].longitude ?? 0.0),
                          onTap: () {
                            showDialogAlert(context, p);
                          });
                    }).toList();

                    return GoogleMap(
                      onMapCreated: criarMapa,
                      mapType: mapType,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                          posicaoAtual.latitude,
                          posicaoAtual.longitude,
                        ),
                        zoom: 12.0,
                      ),
                      myLocationEnabled: true,
                      mapToolbarEnabled: false,
                      rotateGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      markers: Set.of(allMarkers),
                    );
                  },
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
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 110,
                    color: Colors.transparent,
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.only(bottom: 0),
                    child: Observer(
                      builder: (context) {
                        List<Loja> lojas = lojaController.lojas;

                        if (lojaController.error != null) {
                          return Text("Não foi possível buscar lojas");
                        }

                        if (lojas == null) {
                          return Center(
                            child: Text("não foi possível carregar lojas"),
                          );
                        }

                        return builderList(lojas);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  builderList(List<Loja> lojas) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: lojas.length,
      itemBuilder: (context, index) {
        Loja p = lojas[index];

        return GestureDetector(
          child: AnimatedContainer(
            duration: Duration(seconds: 1),
            decoration: BoxDecoration(
              color: p.nome == selectedCard ? Colors.yellow[200] : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            width: 240,
            padding: EdgeInsets.all(2),
            margin: EdgeInsets.only(left: 10),
            child: Row(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ConstantApi.urlArquivoProduto + p.foto,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(p.nome),
                      subtitle: Text(p.telefone),
                    ),
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            selectCard(p.nome);
            movimentarCamera(
              p.enderecos[0].latitude,
              p.enderecos[0].longitude,
            );
          },
        );
      },
    );
  }

  showDialogAlert(BuildContext context, Loja p) async {
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
                Text("${p.nome}"),
                Text("${p.enderecos[0].logradouro}, ${p.enderecos[0].numero}"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color: Colors.grey),
              ),
              color: Colors.white,
              textColor: Colors.grey,
              padding: EdgeInsets.all(10),
              child: const Text('CANCELAR'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color: Colors.blue),
              ),
              color: Colors.white,
              textColor: Colors.blue,
              padding: EdgeInsets.all(10),
              child: const Text('DETALHES'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return LojaDetalhesTab(p);
                    },
                  ),
                );
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
                          "Terra",
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    onMapTypeButtonPressedTerra();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
                side: BorderSide(color: Colors.grey),
              ),
              color: Colors.white,
              textColor: Colors.grey,
              padding: EdgeInsets.all(10),
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
}

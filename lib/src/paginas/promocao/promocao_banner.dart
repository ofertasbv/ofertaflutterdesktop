import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

// import 'package:gscarousel/gscarousel.dart';
import 'package:nosso/src/api/constants/constant_api.dart';
import 'package:nosso/src/core/controller/promocao_controller.dart';
import 'package:nosso/src/core/model/promocao.dart';
import 'package:nosso/src/paginas/produto/produto_page.dart';
import 'package:nosso/src/util/filter/produto_filter.dart';
import 'package:nosso/src/util/load/circular_progresso_mini.dart';
import 'package:flutter_multi_carousel/carousel.dart';

class PromocaoBanner extends StatefulWidget {
  @override
  _PromocaoBannerState createState() => _PromocaoBannerState();
}

class _PromocaoBannerState extends State<PromocaoBanner> {
  var promocaoController = GetIt.I.get<PromoCaoController>();
  var filter = ProdutoFilter();

  @override
  void initState() {
    promocaoController.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(builder: (context) {
        List<Promocao> promocoes = promocaoController.promocoes;
        if (promocaoController.error != null) {
          return Text("Não foi possível carregados dados");
        }

        if (promocoes == null) {
          return CircularProgressorMini();
        }

        return Container(
          height: 300,
          color: Colors.grey[400],
          child: Image.asset(
            ConstantApi.urlBanner,
            height: 300,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        );
      }),
    );
  }
}

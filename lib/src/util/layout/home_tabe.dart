// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:nosso/src/paginas/produto/produto_search.dart';
//
// class HomeTabe extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Widget _builderBodyBack() => Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color.fromARGB(255, 211, 118, 130),
//                 Color.fromARGB(255, 253, 181, 168),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//         );
//     return Stack(
//       children: <Widget>[
//         _builderBodyBack(),
//         CustomScrollView(
//           slivers: <Widget>[
//             SliverAppBar(
//               automaticallyImplyLeading: true,
//               pinned: true,
//               forceElevated: false,
//               actions: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.shopping_cart, color: Colors.white),
//                   onPressed: () {
//                     showSearch(
//                         context: context, delegate: ProdutoSearchDelegate());
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_alert, color: Colors.white),
//                   onPressed: () {
//                     showSearch(
//                         context: context, delegate: ProdutoSearchDelegate());
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.location_on, color: Colors.white),
//                   onPressed: () {
//                     showSearch(
//                         context: context, delegate: ProdutoSearchDelegate());
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.search, color: Colors.white),
//                   onPressed: () {
//                     showSearch(
//                         context: context, delegate: ProdutoSearchDelegate());
//                   },
//                 )
//               ],
//               floating: true,
//               snap: true,
//               backgroundColor: Colors.transparent,
//               elevation: 0.0,
//               flexibleSpace: FlexibleSpaceBar(
//                 title: const Text("Home"),
//                 centerTitle: false,
//               ),
//             ),
//             SliverFixedExtentList(
//               itemExtent: 150.0,
//               delegate: SliverChildListDelegate(
//                 [
//                   Container(
//                     color: Colors.red,
//                     child: Text("TESTE 1"),
//                   ),
//                   Container(color: Colors.purple),
//                   Container(color: Colors.green),
//                   Container(color: Colors.orange),
//                   Container(color: Colors.yellow),
//                   Container(color: Colors.pink),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

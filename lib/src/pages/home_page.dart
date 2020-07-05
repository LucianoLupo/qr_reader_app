import 'package:flutter/material.dart';
//import 'package:barcode_scan/barcode_scan.dart';

import 'package:qr_reader_app/src/pages/direcciones_page.dart';
import 'package:qr_reader_app/src/pages/mapas_page.dart';
import 'package:qr_reader_app/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: () {},
          )
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _bottomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: _scanQR,
      ),
    );
  }

  _scanQR() async {
    String futureString = 'https://lucianolupo.com/';
    print(futureString);

    // try {
    //   print("start scan");
    //   futureString = await BarcodeScanner.scan();
    //   print('Future String: ${futureString.rawContent}');
    // } catch (e) {
    //   futureString = e.toString();
    // }

    if (futureString != null) {
      final scan = ScanModel(value: futureString);
      DBProvider.db.newScan(scan);
    }
  }

  Widget _callPage(int pagActual) {
    switch (pagActual) {
      case 0:
        return MapasPage();
      case 1:
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }

  Widget _bottomNavBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Mapas")),
        BottomNavigationBarItem(
            icon: Icon(Icons.brightness_5), title: Text("Direcciones")),
      ],
    );
  }
}

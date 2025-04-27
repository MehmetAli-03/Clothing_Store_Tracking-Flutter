import 'package:ekonomi_app/gelirBilgisi.dart';
import 'package:ekonomi_app/giderBilgisi.dart';
import 'package:ekonomi_app/main.dart';
import 'package:ekonomi_app/stock_Bilgisi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Sayfalar
import 'ana_sayfa.dart';
import 'personel_bilgisi.dart';

class YanMenu extends StatelessWidget {


  const YanMenu();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              child: Image.asset("assets/mehmetkulek.jpg"),
            ),
            _drawerTile(context, Icons.home, 'Ana Sayfa', home_page()),
            _drawerTile(context, Icons.person, 'Personel Bilgisi', PersonelBilgisi()),
            _drawerTile(context, Icons.monetization_on, 'Şirket Gelirleri', Gelirbilgisi()),
            _drawerTile(context, Icons.money_off, 'Şirket Giderleri', Giderbilgisi()),
            _drawerTile(context, Icons.shopping_basket_outlined, 'Stok Takibi', stock_Bilgisi()),
            _drawerTile(context, Icons.exit_to_app, 'Çıkış Yap', home_page()),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(BuildContext context, IconData icon, String title, Widget sayfa) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.white),
          title: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => sayfa),
            );
          },
        ),
        Divider(color: Colors.white.withOpacity(0.5)),
      ],
    );
  }
}

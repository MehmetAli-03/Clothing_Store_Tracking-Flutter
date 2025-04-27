import 'package:ekonomi_app/gelirBilgisi.dart';
import 'package:ekonomi_app/giderBilgisi.dart';
import 'package:ekonomi_app/personel_bilgisi.dart';
import 'package:ekonomi_app/stock_Bilgisi.dart';
import 'package:ekonomi_app/yanMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'usersDao.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();

}

class _home_pageState extends State<home_page> {
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  int gelir = 0;
  int gider = 0;
  int personel = 0;
  int kazanc=0;
  int toplamStock1=0;
  int toplamPersonelGideri=0;


  @override
  void initState() {
    super.initState();
    verileriGetir();
  }
  void verileriGetir() async {
    var dao = usersDao();
    int toplamGelirDegeri = await dao.toplamGelir();
    int toplamGiderDegeri = await dao.toplamGider();
    int toplamPersonelDegeri = await dao.toplamPersonel();
    int toplamStock=await dao.toplamStock();
    int toplamPersonelGideri= await dao.toplamPersonelGideri();

    setState(() {
      gelir = toplamGelirDegeri;
      gider = (toplamGiderDegeri+toplamPersonelGideri);
      personel = toplamPersonelDegeri;
      kazanc=(toplamGelirDegeri-(toplamGiderDegeri+toplamPersonelGideri));
      toplamStock1=toplamStock;

    });
  }

  Widget build(BuildContext context) {
    DateTime now=DateTime.now();
    String formattedDate = DateFormat('dd.MM.yyyy').format(now);
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffold.currentState?.openDrawer();
          },
          icon: Icon(Icons.menu, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.black.withOpacity(.9),
        title: Text(
          "Ana Sayfa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      drawer: YanMenu(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Text(
                    "Merhaba Mehmet",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),

                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.date_range, size: 28),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
              child: Container(
                height: 5,
                width: double.infinity,
                child: SizedBox(height: 10),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1,
                children: [
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Gelirbilgisi()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: Colors.green,
                              size: 50,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Toplam Gelir",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${gelir} ₺",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()
                    {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Giderbilgisi()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.trending_down,
                              color: Colors.red,
                              size: 50,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Toplam Gider",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${gider}₺",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.euro,
                              color: Colors.yellow,
                              size: 40,
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Kar-Zarar",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "${kazanc}₺",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>PersonelBilgisi()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.blue, size: 50),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Personel", style: TextStyle(fontSize: 16)),
                                Text(
                                  "${personel}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>stock_Bilgisi()));
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_basket, color: Colors.blue, size: 50),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Stock Durumu", style: TextStyle(fontSize: 14)),
                                Text(
                                  "${toplamStock1} Adet",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alarm_add_rounded,
                            color: Colors.red,
                            size: 50,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Azalan Ürün",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "25 Adet Parfüm",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Son İşlemler Bölümü
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Son İşlemler",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 220,
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(
                            Icons.add_card_rounded,
                            color: Colors.green,
                          ),
                          title: Text(
                            "Satış Yapıldı",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          trailing: Text(
                            "20.04.2025",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.shopping_basket_outlined,
                            color: Colors.blue,
                          ),
                          title: Text(
                            "Stock Güncellendi",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          trailing: Text(
                            "20.04.2025",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.add_box_rounded,
                            color: Colors.red,
                          ),
                          title: Text(
                            "Gider Eklendi",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          trailing: Text(
                            "18.04.2025",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.add_card_rounded,
                            color: Colors.green,
                          ),
                          title: Text(
                            "Satış Yapıldı",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          trailing: Text(
                            "18.04.2025",
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

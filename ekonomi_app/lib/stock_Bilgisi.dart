import 'package:ekonomi_app/stock.dart';
import 'package:ekonomi_app/stock_kayit.dart';
import 'package:ekonomi_app/usersDao.dart';
import 'package:ekonomi_app/yanMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'StockGuncelle.dart';

class stock_Bilgisi extends StatefulWidget {
  const stock_Bilgisi({super.key});

  @override
  State<stock_Bilgisi> createState() => _stock_BilgisiState();
}

final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
int gelir = 0;

class _stock_BilgisiState extends State<stock_Bilgisi> {
  @override
  void initState() {
    setState(() {

    });
    super.initState();
    toplamStock();
  }

  Future<List<Stock>> tumStockGoster() async {
    return await usersDao().tumStock();
  }

  Future<void> sil(int kisi_id) async {
    await usersDao().StockSil(kisi_id);
    setState(() {});
  }

  void toplamStock() async {
    var dao = usersDao();
    int toplamAdetSayisi = await dao.toplamStock();

    setState(() {
      gelir = toplamAdetSayisi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      drawer: YanMenu(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.9),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () => _scaffold.currentState?.openDrawer(),
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
        title: Text(
          "Stock Bilgisi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade200],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + 50),
            Container(
              color: Colors.white.withOpacity(0.5),
              child: ListTile(
                leading: Icon(Icons.shopping_basket_outlined, color: Colors.blue),
                title: Text(
                  "Toplam Stock",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  gelir.toString(),
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Stock>>(
                future: tumStockGoster(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Hata: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("Stok bulunamadı"));
                  } else {
                    var stockListesi = snapshot.data!;
                    return ListView.builder(
                      itemCount: stockListesi.length,
                      itemBuilder: (context, index) {
                        var stock = stockListesi[index];

                        String imageAsset = "assets/default.png";
                        if (stock.stock_name.toLowerCase().contains("tshirt")) {
                          imageAsset = "assets/tshirt2.jpg";
                        } else if (stock.stock_name.toLowerCase().contains("ayakkabi")) {
                          imageAsset = "assets/ayakkabi.jpg";
                        } else if (stock.stock_name.toLowerCase().contains("parfum")) {
                          imageAsset = "assets/parfum2.jpg";
                        } else if (stock.stock_name.toLowerCase().contains("ceket")) {
                          imageAsset = "assets/ceket2.jpg";
                        } else if (stock.stock_name.toLowerCase().contains("gomlek")) {
                          imageAsset = "assets/gomlek2.jpg";
                        }

                        return Card(
                          color: Colors.white.withOpacity(0.6),
                          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ExpansionTile(
                            leading: ClipRRect(
                              // borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                imageAsset,
                                width: 90,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  stock.stock_name,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: Colors.black),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  stock.stock_tanitim ?? '',
                                  style: TextStyle(fontSize: 15, color: Colors.black87,fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Toplam: ${stock.stock_adet} Adet",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),
                                ),
                              ],
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ..._bedenSatirlari(stock),
                                    SizedBox(height: 12),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                              ),
                                              builder: (context) => StockDuzenleSheet(stock: stock),
                                            ).then((value) {
                                              if (value == true) {
                                                setState(() {});
                                                toplamStock(); // güncel toplamı yeniden al
                                              }
                                            });
                                          },

                                          icon: Icon(Icons.edit, color: Colors.blue),
                                          label: Text("Düzenle"),
                                        ),
                                        SizedBox(width: 10),
                                        TextButton.icon(
                                          onPressed: () {
                                            sil(stock.stock_id);
                                          },
                                          icon: Icon(Icons.delete, color: Colors.red),
                                          label: Text("Sil"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => StockKayit()),
          );
        },
        backgroundColor: Colors.black,
        tooltip: "Kayıt Ekle",
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> _bedenSatirlari(Stock stock) {
    bool ayakkabiMi = stock.stock_name.toLowerCase().contains("ayakkabi");

    if (ayakkabiMi) {
      return [
        bedenSatiri("44", stock.stock_XXl ?? ''),
        bedenSatiri("43", stock.stock_Xl ?? ''),
        bedenSatiri("42", stock.stock_L ?? ''),
        bedenSatiri("41", stock.stock_M ?? ''),
        bedenSatiri("40", stock.stock_S ?? ''),
      ];
    } else {
      return [
        bedenSatiri("XXL", stock.stock_XXl ?? ''),
        bedenSatiri("XL", stock.stock_Xl ?? ''),
        bedenSatiri("L", stock.stock_L ?? ''),
        bedenSatiri("M", stock.stock_M ?? ''),
        bedenSatiri("S", stock.stock_S ?? ''),
      ];
    }
  }

  Widget bedenSatiri(String beden, String adet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("$beden Beden", style: TextStyle(fontSize: 16)),
        Text("$adet Adet", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

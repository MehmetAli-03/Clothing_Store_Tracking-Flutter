import 'package:ekonomi_app/usersDao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'GelirEkle.dart';
import 'gelir.dart';
import 'yanMenu.dart';

class Gelirbilgisi extends StatefulWidget {
  const Gelirbilgisi({super.key});

  @override
  State<Gelirbilgisi> createState() => _GelirbilgisiState();
}

class _GelirbilgisiState extends State<Gelirbilgisi> {
  Future<void> sil(int gelir_id) async {
    await usersDao().GelirSil(gelir_id);
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

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
          "Gelir Bilgisi",
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
            SizedBox(height: kToolbarHeight + 24),

            // 🟩 Şık Toplam Gelir Kartı
            FutureBuilder<List<Gelir>>(
              future: usersDao().tumGelirler(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  double toplamGelir = snapshot.data!
                      .map((e) => double.tryParse(e.gelir_fiyat) ?? 0)
                      .reduce((a, b) => a + b);

                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Card(
                      color: Colors.green,
                      margin: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.attach_money_rounded,
                              color: Colors.white,),
                        title:  Text(
                            "Toplam Gelir :",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                            ),
                          ),
                          trailing: Text(
                            "${toplamGelir.toStringAsFixed(2)} ₺",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                      ),
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "Henüz gelir eklenmedi.",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),

            // 📋 Gelir Listesi
            Expanded(
              child: FutureBuilder<List<Gelir>>(
                future: usersDao().tumGelirler(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    var gelirListesi = snapshot.data!;
                    return ListView.builder(
                      itemCount: gelirListesi.length,
                      itemBuilder: (context, index) {
                        var gelir = gelirListesi[index];
                        return Card(
                          color: Colors.white.withOpacity(0.85),
                          margin: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.add_card_rounded,
                                color: Colors.green),
                            title: Text(gelir.gelir_name),
                            subtitle: Text(gelir.gelir_tarih),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${gelir.gelir_fiyat}₺",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                IconButton(
                                  icon:
                                  Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => sil(gelir.gelir_id),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        "Henüz gelir eklenmedi.",
                        style: TextStyle(color: Colors.white),
                      ),
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
            MaterialPageRoute(builder: (context) => GelirEkle()),
          );
        },
        backgroundColor: Colors.black,
        tooltip: "Gelir Ekle",
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

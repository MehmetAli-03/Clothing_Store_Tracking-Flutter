import 'package:ekonomi_app/GiderEkle.dart';
import 'package:ekonomi_app/gider.dart';
import 'package:ekonomi_app/usersDao.dart';
import 'package:flutter/material.dart';

import 'GelirEkle.dart';
import 'gelir.dart';
import 'yanMenu.dart';

class Giderbilgisi extends StatefulWidget {
  const Giderbilgisi({super.key});

  @override
  State<Giderbilgisi> createState() => _GiderbilgisiState();
}

class _GiderbilgisiState extends State<Giderbilgisi> {
  int toplamGider = 0;
  int toplamPersonelGider = 0;
  Future<void> sil(int gider_id) async {
    await usersDao().GiderSil(gider_id);
    setState(() {});
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  void initState() {
    super.initState();
    verileriGetir();
  }

  void verileriGetir() async {
    var dao = usersDao();
    int gelenToplamGider = await dao.toplamGider();
    int gelenToplamPersonelGider = await dao.toplamPersonelGideri();

    setState(() {
      toplamGider = (gelenToplamGider+gelenToplamPersonelGider);
      toplamPersonelGider = gelenToplamPersonelGider;
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
            onPressed: () {},
            icon: Icon(Icons.exit_to_app, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.info, color: Colors.white),
          ),
        ],
        title: Text(
          "Gider Bilgisi",
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
              color: Colors.red,
              child: ListTile(
                leading: const Icon(Icons.attach_money, color: Colors.white),
                title: const Text(
                  "Toplam Gider:",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "${toplamGider.toString()} ₺",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              color: Colors.red,
              child: ListTile(
                leading: const Icon(Icons.person, color: Colors.white),
                title: const Text(
                  "Personel Maaşı:",
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "${toplamPersonelGider.toString()} ₺",
                  style: const TextStyle(fontSize: 22, color: Colors.white),
                ),
              ),
            ),

            // 🔻 Gider listesi
            Expanded(
              child: FutureBuilder<List<Gider>>(
                future: usersDao().tumGiderler(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    var giderListesi = snapshot.data!;
                    return ListView.builder(
                      itemCount: giderListesi.length,
                      itemBuilder: (context, index) {
                        var gider = giderListesi[index];
                        return Card(
                          color: Colors.white.withOpacity(0.8),
                          margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            leading:
                            Icon(Icons.credit_card, color: Colors.blue),
                            title: Text(gider.gider_name),
                            subtitle: Text(gider.gider_tarih),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${gider.gider_fiyat}₺",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => sil(gider.gider_id),
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
                        "Henüz gider eklenmedi.",
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
            MaterialPageRoute(builder: (context) => GiderEkle()),
          );
        },
        backgroundColor: Colors.black,
        tooltip: "Gider Ekle",
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

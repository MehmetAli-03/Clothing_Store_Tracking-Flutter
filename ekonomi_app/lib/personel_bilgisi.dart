import 'package:ekonomi_app/PersonelKayit.dart';
import 'package:ekonomi_app/person.dart';
import 'package:ekonomi_app/usersDao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'yanMenu.dart';

class PersonelBilgisi extends StatefulWidget {
  const PersonelBilgisi({super.key});

  @override
  State<PersonelBilgisi> createState() => _PersonelBilgisiState();
}

class _PersonelBilgisiState extends State<PersonelBilgisi> {
  Future<List<Person>> tumKisileriGoster() async {
    return await usersDao().tumPersonel();
  }

  Future<void> sil(int kisiId) async {
    await usersDao().PersonelSil(kisiId);
    setState(() {});
  }

  int toplamPersonel = 0;
  int toplamPersonelGider = 0;
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    verileriGetir();
  }

  void verileriGetir() async {
    var dao = usersDao();
    int gelenToplamPersonel = await dao.toplamPersonel();
    int gelenToplamPersonelGider = await dao.toplamPersonelGideri();

    setState(() {
      toplamPersonel = gelenToplamPersonel;
      toplamPersonelGider = gelenToplamPersonelGider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            _scaffold.currentState?.openDrawer();
          },
          icon: const Icon(Icons.menu, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info, color: Colors.white),
          ),
        ],
        backgroundColor: Colors.black.withOpacity(.9),
        title: const Text(
          "Personel Bilgisi",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      drawer: YanMenu(),
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
            Column(
              children: [
                Container(
                  color: Colors.white.withOpacity(0.5),
                  child: ListTile(
                    leading: const Icon(Icons.attach_money, color: Colors.blue),
                    title: const Text(
                      "Toplam Personel Maaş:",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "$toplamPersonelGider ₺",
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              children: [
                Container(
                  color: Colors.white.withOpacity(0.5),
                  child: ListTile(
                    leading: const Icon(Icons.person, color: Colors.blue),
                    title: const Text(
                      "Toplam Personel:",
                      style: TextStyle(
                        fontSize: 19,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "${toplamPersonel.toString()} Kişi",
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Person>>(
                future: tumKisileriGoster(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Hata: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Kayıtlı personel yok."));
                  } else {
                    var personelListesi = snapshot.data!;
                    return ListView.builder(
                      itemCount: personelListesi.length,
                      itemBuilder: (context, indeks) {
                        var person = personelListesi[indeks];
                        return Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                  person.person_cinsiyet == "kız"
                                      ? "assets/kadın2.jpg"
                                      : "assets/erkek23.jpeg",
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${person.person_name} ${person.person_surname}",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                              onPressed: () {
                                                // düzenleme ekranı buraya eklenebilir
                                              },
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.delete, color: Colors.redAccent),
                                              onPressed: () async {
                                                await sil(person.person_id);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text("${person.person_name} silindi")),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "Pozisyon: ${person.person_job}",
                                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Yaş: ${person.person_age}  |  Cinsiyet: ${person.person_cinsiyet}",
                                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Telefon: ${person.person_phone} | Maaş: ${person.person_sale}₺",
                                      style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
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
            MaterialPageRoute(builder: (context) => Personelkayit()),
          );
        },
        backgroundColor: Colors.black,
        tooltip: "Kişi Ekle",
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

import 'package:ekonomi_app/stock.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'usersDao.dart';

class StockDuzenleSheet extends StatefulWidget {
  final Stock stock;
  const StockDuzenleSheet({required this.stock});

  @override
  State<StockDuzenleSheet> createState() => _StockDuzenleSheetState();
}

class _StockDuzenleSheetState extends State<StockDuzenleSheet> {
  late Map<String, int> bedenAdetleri;

  @override
  void initState() {
    super.initState();
    bedenAdetleri = {
      "XXL": int.tryParse(widget.stock.stock_XXl ?? "0") ?? 0,
      "XL": int.tryParse(widget.stock.stock_Xl ?? "0") ?? 0,
      "L": int.tryParse(widget.stock.stock_L ?? "0") ?? 0,
      "M": int.tryParse(widget.stock.stock_M ?? "0") ?? 0,
      "S": int.tryParse(widget.stock.stock_S ?? "0") ?? 0,
    };
  }

  void guncelleStock() async {
    int toplam = bedenAdetleri.values.reduce((a, b) => a + b);

    await usersDao().stockGuncelle(
      stock_id: widget.stock.stock_id,
      stockAdet: toplam.toString(),
      stockXXL: bedenAdetleri["XXL"].toString(),
      stockXL: bedenAdetleri["XL"].toString(),
      stockL: bedenAdetleri["L"].toString(),
      stockM: bedenAdetleri["M"].toString(),
      stockS: bedenAdetleri["S"].toString(),
    );

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 24, 16, MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("${widget.stock.stock_name} Stok Güncelle", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          ...bedenAdetleri.entries.map((entry) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${entry.key} Beden", style: TextStyle(fontSize: 16)),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (bedenAdetleri[entry.key]! > 0) bedenAdetleri[entry.key] = bedenAdetleri[entry.key]! - 1;
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    Text(bedenAdetleri[entry.key].toString(), style: TextStyle(fontSize: 16)),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          bedenAdetleri[entry.key] = bedenAdetleri[entry.key]! + 1;
                        });
                      },
                      icon: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
            ),
            onPressed: guncelleStock,
            icon: Icon(Icons.save,color:Colors.white,),
            label: Text("Kaydet",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          ),
        ],
      ),
    );
  }
}

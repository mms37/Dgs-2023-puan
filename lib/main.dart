import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DGS Puan Hesaplama',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DgsPuanHesaplamaPage(),
    );
  }
}

class DgsPuanHesaplamaPage extends StatefulWidget {
  @override
  _DgsPuanHesaplamaPageState createState() => _DgsPuanHesaplamaPageState();
}

class _DgsPuanHesaplamaPageState extends State<DgsPuanHesaplamaPage> {
  int secim = 2022;
  String sistem = 'EY';
  double dgssayisaldogru = 0.0;
  int dgssayisalyanlis = 0;
  double dgssozeldogru = 0.0;
  int dgssozelyanlis = 0;
  double dgsobp = 0.0;
  bool onceki = false;

  String dgssayisalaciklama = '50 Soru';
  String dgssozelaciklama = '50 Soru';

  double dgsPuanEY = 0.0;
  double dgsPuanY = 0.0;
  double dgsPuanE = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DGS Puanı Hesaplama Aracı'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 4.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'DGS Puanı Hesaplama Aracı',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                SizedBox(height: 16),
                Text(
                  '* Doldurulması zorunlu alanlar.\n'
                      '** Önlisans Başarı Puanı alanını doldurmadığınızda, hesaplar ağırlıklı ÖBP eklenmeden yapılacaktır.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  value: secim,
                  onChanged: (newValue) {
                    setState(() {
                      secim = newValue!;
                    });
                  },
                  items: [
                    DropdownMenuItem(
                      value: 2022,
                      child: Text('2022 Dikey Geçiş Sınavı'),
                    ),
                    DropdownMenuItem(
                      value: 2021,
                      child: Text('2021 Dikey Geçiş Sınavı'),
                    ),
                    // Add other years...
                  ],
                  decoration: InputDecoration(
                    labelText: 'Sınav Yılı',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text('* Sınav Sistemi:'),
                  subtitle: Column(
                    children: [
                      RadioListTile<String>(
                        title: Text('2022 ve sonrası (100 Soru)'),
                        value: 'EY',
                        groupValue: sistem,
                        onChanged: (value) {
                          setState(() {
                            sistem = value!;
                            sistemsecim();
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text('2014 - 2021 arası (120 Soru)'),
                        value: 'Y',
                        groupValue: sistem,
                        onChanged: (value) {
                          setState(() {
                            sistem = value!;
                            sistemsecim();
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Text('2013 ve öncesi (160 Soru)'),
                        value: 'E',
                        groupValue: sistem,
                        onChanged: (value) {
                          setState(() {
                            sistem = value!;
                            sistemsecim();
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Text('Doğru / Yanlış',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                ListTile(
                  title: Text('Sayısal Testi:'),
                  subtitle: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          key: Key('dgssayisaldogru'),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (value) {
                            setState(() {
                              dgssayisaldogru = double.tryParse(value) ?? 0.0;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Doğru',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('/'),
                      SizedBox(width: 8),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              dgssayisalyanlis = int.tryParse(value) ?? 0;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Yanlış',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ListTile(
                  title: Text('Sözel Testi:'),
                  subtitle: Row(
                    children: [
                      Flexible(
                        child: TextFormField(
                          key: Key('dgssozeldogru'),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true),
                          onChanged: (value) {
                            setState(() {
                              dgssozeldogru = double.tryParse(value) ?? 0.0;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Doğru',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('/'),
                      SizedBox(width: 8),
                      Flexible(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              dgssozelyanlis = int.tryParse(value) ?? 0;
                            });
                          },
                          decoration: InputDecoration(
                            labelText: 'Yanlış',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  key: Key('dgsobp'),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (value) {
                    setState(() {
                      dgsobp = double.tryParse(value) ?? 0.0;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Önlisans B. Puanı',
                    hintText: 'En az 40, en çok 80 girebilirsiniz (Örn. 60.58)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                CheckboxListTile(
                  title: Text('Önceki DGS Sonucu'),
                  value: onceki,
                  onChanged: (value) {
                    setState(() {
                      onceki = value!;
                    });
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  key: Key('hesaplaButton'),
                  onPressed: () {
                    calculateDgsPuan();
                  },
                  child: Text('Hesapla'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    resetForm();
                  },
                  child: Text('Temizle'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                // DGS Puanı Gösterme Tablosu
                Text(
                  'DGS Puanları',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 16),
                Table(
                  border: TableBorder.all(),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(''),
                        ),
                        TableCell(
                          child: Text('Sayısal'),
                        ),
                        TableCell(
                          child: Text('Sözel'),
                        ),
                        TableCell(
                          child: Text('Eşit Ağırlık'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        TableCell(
                          child: Text('PUAN'),
                        ),
                        TableCell(
                          child: Text(dgsPuanY.toStringAsFixed(2)),
                        ),
                        TableCell(
                          child: Text(dgsPuanE.toStringAsFixed(2)),
                        ),
                        TableCell(
                          child: Text(dgsPuanEY.toStringAsFixed(2)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ... (existing code)

  void calculateDgsPuan() {
    double katsayiSozel = 0.0;
    double katsayiSayisal = 0.0;
    double tabanPuan = 0.0;

    if (secim == 2022) {
      katsayiSozel = 3.091;
      katsayiSayisal = 0.584;
      tabanPuan = 127.703;
    } else if (secim == 2021) {
      katsayiSozel = 3.065;
      katsayiSayisal = 0.628;
      tabanPuan = 126.597;
    } else {
      // Add coefficients for other years...
    }

    if (sistem == 'EY') {
      dgsPuanEY =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
      dgsPuanY =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
      dgsPuanE =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
    } else if (sistem == 'Y') {
      dgsPuanY =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
      dgsPuanEY =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
      dgsPuanE =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
    } else if (sistem == 'E') {
      dgsPuanE =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
      dgsPuanEY =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
      dgsPuanY =
          (dgssozeldogru * katsayiSozel) + (dgssayisaldogru * katsayiSayisal) +
              (tabanPuan) + (dgsobp * 0.6);
    }

    setState(() {}); // To trigger a rebuild and update the table
  }

  // ... (existing code)

  void resetForm() {
    setState(() {
      secim = 2022;
      sistem = 'EY';
      dgssayisaldogru = 0.0;
      dgssayisalyanlis = 0;
      dgssozeldogru = 0.0;
      dgssozelyanlis = 0;
      dgsobp = 0.0;
      onceki = false;
      dgssayisalaciklama = '50 Soru';
      dgssozelaciklama = '50 Soru';
      dgsPuanEY = 0.0;
      dgsPuanY = 0.0;
      dgsPuanE = 0.0;
    });
  }

  void sistemsecim() {
    if (sistem == 'Y') {
      setState(() {
        dgssayisalaciklama = '60 Soru';
        dgssozelaciklama = '60 Soru';
      });
    } else if (sistem == 'E') {
      setState(() {
        dgssayisalaciklama = '80 Soru';
        dgssozelaciklama = '80 Soru';
      });
    } else {
      setState(() {
        dgssayisalaciklama = '50 Soru';
        dgssozelaciklama = '50 Soru';
      });
    }
  }

}
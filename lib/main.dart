import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://gxzfswhoxmcuzquqxzio.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd4emZzd2hveG1jdXpxdXF4emlvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDY5NzM3OTMsImV4cCI6MjAyMjU0OTc5M30.5-7fx9uLmXTUDO5Tz0Keb3LvSxcVY4fIRUb2n3KtUnw',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

double edu_year_price = 0;
double edu_years = 0;
double loan_state = 0;
double loan_years = 0;
double loan_sum = 0;
double aft = 0;
int aft1 = 0;
double bef = 0;
int bef1 = 0;
double loan_before = 0;
double loan_after = 0;
int year1 = 0;
int year2 = 0;
int year3 = 0;
int year4 = 0;
int yearsr = 0;
int yearlast = 0;
String statee = '';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> banks = [];

  @override
  void initState() {
    super.initState();
    supabase
        .from('banks')
        .select()
        .then((value) => {banks = value, setState(() {}), print(banks)});
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController state = TextEditingController(text: loan_state.toString());
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(alignment: Alignment.topCenter, children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/fon.jpg',
                fit: BoxFit.fill,
              )),
          SizedBox(
            height: double.infinity,
            width: 350,
            child: Column(
              children: [
                SizedBox(height: 25, width: double.infinity),
                const Text("Калькулятор кредита на образование",
                    style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.white,
                    )),
                TextField(
                    onChanged: (text) {
                      edu_year_price = double.parse(text);
                    },
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: "Стоимость обучения за год",
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[100]!, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ))),
                SizedBox(height: 20, width: double.infinity),
                TextField(
                    onChanged: (text) {
                      edu_years = double.parse(text);
                    },
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: "Количество лет обучения",
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[100]!, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ))),
                SizedBox(height: 20, width: double.infinity),
                TextField(
                    onChanged: (text) {
                      loan_years = double.parse(text);
                    },
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        labelText: "Полный срок кредита",
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[100]!, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ))),
                SizedBox(height: 20, width: double.infinity),
                TextField(
                    controller: state,
                    onChanged: (text) {
                      loan_state = double.parse(text) / 100;
                    },
                    decoration: InputDecoration(
                        labelText: "Ставка по кредиту в год",
                        filled: true,
                        fillColor: Colors.blueGrey[50],
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blueGrey[100]!, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ))),
                SizedBox(height: 20, width: double.infinity),
                SizedBox(
                  child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          loan_state = double.parse(state.text);
                          loan_sum = edu_year_price * edu_years;
                          double s = (loan_years - edu_years) * 12 - 9;
                          double k = ((loan_state / 100) *
                                  (pow((1 + (loan_state / 100)), s))) /
                              (pow((1 + (loan_state / 100)), s) - 1);
                          loan_after = loan_sum * k;
                          print(loan_after);
                          print(loan_sum);
                          print(loan_state);
                          loan_before = loan_sum * loan_state;
                          aft = loan_after.round() / 1;
                          aft1 = aft.round();
                          bef = loan_before / 12;
                          bef1 = bef.round();
                          year1 = 1 * edu_year_price * 0.03 ~/ 12;
                          year2 = 2 * edu_year_price * 0.03 ~/ 12;
                          year3 = 3 * edu_year_price * 0.03 ~/ 12;
                          year4 = 4 * edu_year_price * 0.03 ~/ 12;
                          yearlast = 4 * edu_year_price * 0.03 ~/ 12;
                          yearsr = (year1 + year2 + year3 + year4) ~/ 4;
                          loan_sum = year1 * 12 +
                              year2 * 12 +
                              year3 * 12 +
                              year4 * 12 +
                              loan_after * 12 * (loan_years - edu_years);
                        });
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext) => Results(title: '')));
                      },
                      child: const Text(
                        "Рассчитать",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.blueGrey[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          )))),
                  width: 250,
                  height: 60,
                ),
                SizedBox(height: 30, width: double.infinity),
                Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 180,
                      child: ListView.builder(
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width - 68,
                                  height: 36,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0x99000000),
                                            offset: Offset(0, 2),
                                            blurRadius: 2)
                                      ]),
                                  child: Row(children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(banks[index]['title'] +
                                        ' - ' +
                                        banks[index]['state'].toString() +
                                        '%'), Spacer(), IconButton(onPressed: (){
                                          setState(() {
                                            loan_state = double.parse(banks[index]['state'].toString());
                                          });
                                          }, icon: Icon(CupertinoIcons.download_circle))
                                  ])),
                              SizedBox(
                                height: 15,
                              )
                            ],
                          );
                        },
                        itemCount: banks.length,
                      ),
                    )),
                Spacer(),
                Stack(
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                    ),
                    Center(
                      child: Text('Место под рекламу банков'),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    ));
  }
}

class Results extends StatefulWidget {
  const Results({super.key, required this.title});

  final String title;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(alignment: Alignment.topCenter, children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/fon.jpg',
                fit: BoxFit.fill,
              )),
          SizedBox(
            height: double.infinity,
            width: 350,
            child: Column(
              children: [
                SizedBox(height: 30, width: double.infinity),
                Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Center(
                        child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(children: [
                              Expanded(
                                  child: Text("Срок льготного периода",
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                  child: Text(
                                      edu_years.round().toString() + ' г. 9 м.',
                                      style: TextStyle(fontSize: 28)))
                            ])))),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Center(
                        child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: 290,
                                      child: Text(
                                          textAlign: TextAlign.center,
                                          "Средняя выплата процентов во время обучения",
                                          style: TextStyle(fontSize: 18))),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Expanded(
                                      child: Text(yearsr.toString(),
                                          style: TextStyle(fontSize: 28)))
                                ])))),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Center(
                        child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(children: [
                              Expanded(
                                  child: Text(
                                      "Платёж в льготный период после обучения",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                  child: Text(yearlast.round().toString(),
                                      style: TextStyle(fontSize: 28)))
                            ])))),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Center(
                        child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(children: [
                              Expanded(
                                  child: Text("Платёж после льготного периода",
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                  child: Text(loan_after.round().toString(),
                                      style: TextStyle(fontSize: 28)))
                            ])))),
                SizedBox(
                  height: 30,
                ),
                Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.blueGrey),
                    ),
                    child: Center(
                        child: SizedBox(
                            height: double.infinity,
                            width: double.infinity,
                            child: Column(children: [
                              Expanded(
                                  child: Text("Общая сумма с учётом процентов",
                                      style: TextStyle(fontSize: 18))),
                              Expanded(
                                  child: Text(loan_sum.round().toString(),
                                      style: TextStyle(fontSize: 28)))
                            ])))),
                Spacer(),
                Stack(
                  children: [
                    Container(
                      height: 80,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                    ),
                    Center(
                      child: Text('Место под рекламу банков'),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    ));
  }
}

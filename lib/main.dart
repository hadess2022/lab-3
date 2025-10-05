import 'package:flutter/material.dart';

void main() 
{
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp(
                        home: Scaffold(
                            appBar: AppBar(
                                title: Text('Лабораторная работа 3'),
                            ),
                            body: FirstScrin(),
                        ),
                      );
  }
}

class FirstScrin extends StatefulWidget { 
  FirstScrin({super.key});

  @override
  State<FirstScrin> createState() => _FirstScrinState();
}

class _FirstScrinState extends State<FirstScrin> {
  final _inputData = GlobalKey<FormState>();
  bool sterio = false;
  String discretisation = "";
  String dip = "";
  String long = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child:Column(
          children:[
            Text('Введите данные для подсчета'),
            Form(
              key: _inputData,
              child: Container(
                padding: EdgeInsets.all(290), 
                child: Column(
                    children: [
                      Text("частота дискретизации"),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {discretisation=value},
                      ),
                      Text("глубина кодирования звука"),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {dip=value},
                      ),
                      Text("длительность звуковой дорожки"),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => {long=value},
                      ),
                      Row(children: 
                        [
                          Text("файл имеет звук в формате стерио"),
                          Checkbox(
                            value: sterio, 
                            onChanged:(value) {
                              setState(() { 
                                sterio = value!;
                              });
                            },
                          ),
                        ]
                      ),
                    ElevatedButton(onPressed: 
                      (){
                        if(discretisation == ""){
                          Massage(context, "Не введенно частота дискретизации");
                        }
                        else
                        if(dip == ""){
                          Massage(context, "Не введенно глубина кодирования звука");
                        }
                        else
                        if(long == ""){
                          Massage(context, "Не введенно длительность звуковой дорожки");
                        }
                        else
                        {
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => 
                              SecondScrin(
                                sterio: sterio?2:1, 
                                discretisation: int.parse(discretisation), 
                                dip: int.parse(dip), 
                                long: int.parse(long)
                              )
                            )
                          );
                        }
                      },
                      child: Text("Расчитать"),
                    )
                  ],
                )
              )
            )  
          ]
        )
      ),
    );
  }

  void Massage(BuildContext context, String text) 
  {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Ошибка'),
        content: Text(text),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true)
                  .pop(); 
            },
            child: new Text('OK'),
          ),
        ],
      ),
    );
  }
}

class SecondScrin extends StatelessWidget 
{
  int sterio;
  int discretisation;
  int dip;
  int long;

  SecondScrin({super.key, required this.sterio, required this.discretisation, required this.dip, required this.long});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: (
          Text((sterio*discretisation*dip*long).toString() + " бит")
        ),
      ),
    );
  }
}
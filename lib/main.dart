// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Body Mass Index Calculator',
      home: Scaffold(
        appBar: AppBar(
          title : const Text('Body Mas Index Calculator'),
          backgroundColor: Color.fromRGBO(21, 97, 109, 1) ,
        ),
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // controller untuk text field 'height'
  final _heightController = TextEditingController();

  // controller untuk text field 'weight'
  final _weightController = TextEditingController();

  double? _bmi;
  // the message at the beginning
  String _message = 'Please fill in your height and weight';

  // calculate button
  void _calculate() {
    final double? height = double.tryParse(_heightController.value.text);
    final double? weight = double.tryParse(_weightController.value.text);
    
    if(height == null || height <= 0){
      setState(() {
        _message = "Your height cannot be null and must be possitive numbers";
      });
    }else if(weight == null || weight <= 0){
      setState(() {
        _message = "Your weight cannot be null and must be possitive numbers";
      });      
    return;
    }

    setState(() {
      _bmi = weight! / (height! * height);
      if(_bmi! < 18.5){
        _message = 'You are Underweight';
      }else if(_bmi! < 25){
        _message = 'Great you have Normal Weight';
      }else if(_bmi! < 30){
        _message = 'You are Overweight';
      }else{
        _message = 'You are obese, please kindly meet your doctor';
      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(0, 21, 36, 1),
        body: Center(
          child: SizedBox(
            width: 320,
            child: Card(
              color: Color.fromRGBO(255, 236, 209, 1),
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Height (m)'),
                      controller: _heightController,
                    ),
                    TextField(
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(labelText: 'Weight (kg)'),
                      controller: _weightController,
                    ),
                    ElevatedButton(
                      onPressed: _calculate,
                      child: const Text('Calculate'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      _message,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          )
        ),
    );
  }
}
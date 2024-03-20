import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANALYSE VOYELLE',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const VowelAnalysisScreen(),
    );
  }
}

class VowelAnalysisScreen extends StatefulWidget {
  const VowelAnalysisScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VowelAnalysisScreenState createState() => _VowelAnalysisScreenState();
}

class _VowelAnalysisScreenState extends State<VowelAnalysisScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _buttonScaleAnimation;

  String word = '';
  int aCount = 0;
  int eCount = 0;
  int iCount = 0;
  int oCount = 0;
  int uCount = 0;
  int yCount = 0;
  int consonantCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _buttonScaleAnimation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ANALYSE VOYELLE'),
        centerTitle: true, 
        backgroundColor: Colors.blue, 
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 5,
          shape: const RoundedRectangleBorder(
         
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Entrez un mot ici ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue, // Couleur de la bordure du champ de texte définie
                        width: 3,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      word = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _buttonScaleAnimation.value,
                      child: ElevatedButton(
                        onPressed: () {
                          _animationController.forward(from: 0.0);
                          analyzeWord(word);
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.lightBlueAccent), 
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(
                                color: Colors.lightBlueAccent, 
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        child: const Text('Analyser'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20 ),
                _buildAnalysisResult('A', aCount,  Colors.red),
                _buildAnalysisResult('E', eCount, const Color.fromARGB(255, 244, 64, 10)),
                _buildAnalysisResult('I', iCount, const Color.fromARGB(255, 254, 195, 1)),
                _buildAnalysisResult('O', oCount, const Color.fromARGB(255, 183, 210, 6)),
                _buildAnalysisResult('U', uCount, const Color.fromARGB(255, 4, 131, 42)),
                _buildAnalysisResult('Y', yCount, const Color.fromARGB(255, 3, 248, 166)),
                _buildAnalysisResult(
                    'Consonnes', consonantCount, const Color.fromARGB(255, 67, 61, 61) ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisResult(String label, int count, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical:4),
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ColoredBox(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$label: $count occurrences',   
          ),
        ),
      ),
    );
  }

  void analyzeWord(String word) {
    setState(() {
      aCount = word.replaceAll(RegExp(r'[^aA]'), '').length;
      eCount = word.replaceAll(RegExp(r'[^eE]'), '').length;
      iCount = word.replaceAll(RegExp(r'[^iI]'), '').length;
      oCount = word.replaceAll(RegExp(r'[^oO]'), '').length;
      uCount = word.replaceAll(RegExp(r'[^uU]'), '').length;
      yCount = word.replaceAll(RegExp(r'[^yY]'), '').length;
      consonantCount = word.replaceAll(RegExp(r'[aeiouyAEIOUY]'), '').length;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

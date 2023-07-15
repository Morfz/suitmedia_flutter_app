import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late String name = '';
  late String sentence = '';

  bool isPalindrome(String text) {
    String processedText = text.replaceAll(' ', '').toLowerCase();
    String reversedText = processedText.split('').reversed.join('');
    return processedText == reversedText;
  }

  bool isPalindromeFieldEmpty() {
    return sentence.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 116,
              height: 116,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/profile.png'),
                  fit: BoxFit.cover,
                  scale: 1.0,
                ),
              ),
            ),
            const SizedBox(height: 51.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Flexible(
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Palindrome',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      sentence = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 48.0),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey;
                      }
                      return const Color.fromRGBO(43, 99, 123, 1);
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: isPalindromeFieldEmpty()
                    ? null
                    : () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Result'),
                        content: Text(
                          isPalindrome(sentence)
                              ? 'is palindrome'
                              : 'not palindrome',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text(
                  'CHECK',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(43, 99, 123, 1),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/second_page',
                    arguments: name,
                  );
                },
                child: const Text(
                  'NEXT',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
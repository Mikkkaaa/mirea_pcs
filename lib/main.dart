import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Практика 3',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PracticeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Практика 3'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Текст с приветствием
            const Text(
              'Привет, Flutter!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 20), // Отступ

            // 2. Кнопка
            ElevatedButton(
              onPressed: () {
                // Можно добавить действие
                debugPrint('Кнопка нажата!');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: const Text(
                'Нажми меня',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 20), // Отступ

            // 3. Контейнер с кастомным цветом
            Container(
              width: 150,
              height: 100,
              color: const Color(0xFF42A5F5), // Кастомный цвет (синий оттенок)
              alignment: Alignment.center,
              child: const Text(
                'Контейнер',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 30), // Отступ перед Row

            // 4. Row с двумя иконками
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 40,
                  color: Colors.amber[600],
                ),
                const SizedBox(width: 20), // Отступ между иконками
                Icon(
                  Icons.favorite,
                  size: 40,
                  color: Colors.red[700],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
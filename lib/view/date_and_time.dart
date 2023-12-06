import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController dobController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  late DateTime selectedDate;
  late TimeOfDay selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
        dobController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (picked != selectedTime) {
      setState(() {
        selectedTime = picked!;
        timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Date and Time Selection'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: dobController,
              readOnly: true,
              onTap: () {
                _selectDate(context);
              },
              decoration: InputDecoration(
                labelText: 'Date of Birth',
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDate(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: timeController,
              readOnly: true,
              onTap: () {
                _selectTime(context);
              },
              decoration: InputDecoration(
                labelText: 'Time',
                filled: true,
                fillColor: Colors.grey[200],
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () {
                    _selectTime(context);
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to another screen and pass selectedDate and selectedTime
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnotherScreen(
                      selectedDate: selectedDate,
                      selectedTime: selectedTime,
                    ),
                  ),
                );
              },
              child: const Text('Go to Another Screen'),
            ),
          ],
        ),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  const AnotherScreen(
      {super.key, required this.selectedDate, required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Another Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selected Date: ${selectedDate ?? "Not selected"}'),
            const SizedBox(height: 16),
            Text('Selected Time: ${selectedTime ?? "Not selected"}'),
          ],
        ),
      ),
    );
  }
}

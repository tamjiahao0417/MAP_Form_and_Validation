import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedGender;
  double _familyMembers = 5;
  int _rating = 3;
  int _stepperValue = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Form Validation"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Full Name
              TextFormField(
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Date of Birth
              TextFormField(
                decoration: const InputDecoration(labelText: "Date of Birth"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Gender Dropdown
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: "Gender"),
                value: _selectedGender,
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              // Number of Family Members (Slider)
              const Text("Number of Family Members"),
              Slider(
                value: _familyMembers,
                min: 0,
                max: 10,
                divisions: 10,
                label: _familyMembers.toStringAsFixed(0),
                activeColor: Colors.purple,
                inactiveColor: Colors.purple[100],
                onChanged: (value) {
                  setState(() {
                    _familyMembers = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Rating (buttons)
              const Text("Rating"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  return OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: _rating == index + 1
                            ? Colors.deepPurple
                            : Colors.grey,
                      ),
                    ),
                    child: Text('${index + 1}'),
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Stepper
              const Text("Stepper"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        _stepperValue--;
                      });
                    },
                  ),
                  Text('$_stepperValue', style: const TextStyle(fontSize: 20)),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        _stepperValue++;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Languages Known (for future expansion)
              const Text("Languages you know"),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';


void main() => runApp(FormApp());

class FormApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Form Validation',
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  double _sliderValue = 5.0;
  int _rating = 0;
  int _stepperValue = 10;
  String? _selectedGender;
  bool _english = false;
  bool _hindi = false;
  bool _other = false;
  bool _agree = false;
  String? _signature;
  late SignatureController _signatureController;
    
  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(title: Text('Flutter Form Validation'),
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always, // Trigger validation on user interaction
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Gender', // The small text "Gender"
                    style: TextStyle(
                      color: Colors.red, // Regular color for label
                      fontSize: 14, // Smaller font size
                    ),
                  ),
                  SizedBox(height: 4), 
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Select Gender',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                value: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
                items: ['Male', 'Female', 'Other']
                    .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'This field cannot be empty.';
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),

              SizedBox(height: 20),
              Text('Number of Family Members'),
              Slider(
                min: 0.0,
                max: 10.0,
                divisions: 20,
                value: _sliderValue,
                label: _sliderValue.toStringAsFixed(1),
                activeColor: Colors.purple,
                inactiveColor: Colors.purple.shade200,
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('0.0'),
                  Text('${_sliderValue.toStringAsFixed(1)}'),
                  Text('10.0'),
                ],
              ),

              Divider(     
                color: Colors.grey.shade400,
                thickness: 2,
                height: 20,
              ),

              SizedBox(height: 10),
              Text('Rating'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: SizedBox(
                      width: 85, 
                      height: 40,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              left: index == 0 ? Radius.circular(4) : Radius.zero,
                              right: index == 4 ? Radius.circular(4) : Radius.zero,
                            ),
                          ),
                          side: BorderSide(color: Colors.purple),
                          backgroundColor: _rating == index + 1
                              ? Colors.purple.shade100
                              : Colors.transparent,
                        ),
                        onPressed: () {
                          setState(() {
                            _rating = index + 1;
                          });
                        },
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              Text('Stepper'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_stepperValue > 0) _stepperValue--;
                      });
                    },
                    icon: Icon(Icons.remove),
                  ),
                  SizedBox(width: 180), 
                  Text(
                    '$_stepperValue',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 180), 
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _stepperValue++;
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ],
              ),

              Divider(     
                color: Colors.grey.shade400,
                thickness: 2,
                height: 20,
              ),

              SizedBox(height: 10),
              Text('Languages you know'),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('English'),
                value: _english,
                activeColor: Colors.purple,
                onChanged: (bool? value) {
                  setState(() {
                    _english = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Hindi'),
                value: _hindi,
                activeColor: Colors.purple,
                onChanged: (bool? value) {
                  setState(() {
                    _hindi = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Other'),
                value: _other,
                activeColor: Colors.purple,
                onChanged: (bool? value) {
                  setState(() {
                    _other = value ?? false;
                  });
                },
              ),

              SizedBox(height: 20),

              Text('Signature'),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Signature(
                  controller: _signatureController,
                  backgroundColor: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _signatureController.clear();
                      });
                    },
                    icon: Icon(Icons.clear, color: Colors.red),
                  ),
                  Text('Clear', style: TextStyle(color: Colors.red)),
                ],
              ),


              Divider(color: Colors.grey.shade400, thickness: 2, height: 20),

              Text('Rate this site'),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: List.generate(5, (index) {
                  return IconButton(
                    icon: Icon(
                      Icons.star,
                      color: _rating > index ? Colors.purple : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                  );
                }),
              ),

              Divider(color: Colors.grey.shade400, thickness: 2, height: 20),

              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('I have read and agree to the terms and conditions'),
                value: _agree,
                onChanged: (bool? value) {
                  setState(() {
                    _agree = value ?? false;
                  });
                },
              ),
              Divider(
                color: !_agree ? Colors.red : Colors.grey.shade400, 
                thickness: 2,
                height: 20,
              ),
              if (!_agree)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'You must accept terms and conditions to continue',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                    ),
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false && _agree) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Form is valid and submitted!')),
                        );
                      } else if (!_agree) {
                        setState(() {}); // to trigger the error message
                      }
                    },
                    child: Text('Submit'),
                  ),
                  SizedBox(width: 16), 
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, 
                    ),
                    onPressed: () {
                      _formKey.currentState?.reset();
                      setState(() {
                        _english = false;
                        _hindi = false;
                        _other = false;
                        _agree = false;
                        _signature = null;
                        _rating = 0;
                      });
                    },
                    child: Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
            ]
        ),
      ),
      )
    );
  }
}

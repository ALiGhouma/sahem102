import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyStepperPage extends StatefulWidget {
  @override
  _MyStepperPageState createState() => _MyStepperPageState();
}

class _MyStepperPageState extends State<MyStepperPage> {
  int _currentStep = 0;
  late List<String> _selectedItems;
  List<String> _items = ['Traffic', 'Electricity Company', 'Cleaning Company'];
  List<String> _seconditems = [
    'First',
    'Second',
    'Third',
    'Fourth',
    'Fifth',
    'Sixth',
    'Seventh',
    'Eighth',
    'Ninth'
  ];

  @override
  void initState() {
    super.initState();
    _selectedItems = [];
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedItems.add(pickedFile.path);
      });
    }
  }

  List<Step> _buildSteps() {
    return [
      Step(
        title: Text('Step 1: Add a Photo'),
        content: ElevatedButton(
          onPressed: _getImage,
          child: Text('Select Image'),
        ),
      ),
      Step(
        title: Text('Step 2: Select Items'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedItems.isNotEmpty ? _selectedItems.first : null,
              onChanged: (value) {
                setState(() {
                  _selectedItems.clear();
                  _selectedItems.add(value!);
                });
              },
              items: [
                DropdownMenuItem(
                  value: 'Traffic', // Unique value for Traffic
                  child: Text('Traffic'),
                ),
                DropdownMenuItem(
                  value: 'Electricity', // Unique value for Electricity Company
                  child: Text('Electricity Company'),
                ),
                DropdownMenuItem(
                  value: 'Cleaning', // Unique value for Cleaning Company
                  child: Text('Cleaning Company'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_selectedItems.isNotEmpty)
              DropdownButton<String>(
                value: _selectedItems.length > 1 ? _selectedItems.last : null,
                onChanged: (value) {
                  setState(() {
                    _selectedItems.add(value!);
                  });
                },
                items: _selectedItems.first == 'Traffic'
                    ? [
                        DropdownMenuItem(
                          value:
                              'First', // Unique value for 'First' under Traffic
                          child: Text('First'),
                        ),
                        DropdownMenuItem(
                          value:
                              'Second', // Unique value for 'Second' under Traffic
                          child: Text('Second'),
                        ),
                        DropdownMenuItem(
                          value:
                              'Third', // Unique value for 'Third' under Traffic
                          child: Text('Third'),
                        ),
                      ]
                    : _selectedItems.first == 'Electricity'
                        ? [
                            DropdownMenuItem(
                              value:
                                  'Fourth', // Unique value for 'Fourth' under Electricity Company
                              child: Text('Fourth'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Fifth', // Unique value for 'Fifth' under Electricity Company
                              child: Text('Fifth'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Sixth', // Unique value for 'Sixth' under Electricity Company
                              child: Text('Sixth'),
                            ),
                          ]
                        : [
                            DropdownMenuItem(
                              value:
                                  'Seventh', // Unique value for 'Seventh' under Cleaning Company
                              child: Text('Seventh'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Eighth', // Unique value for 'Eighth' under Cleaning Company
                              child: Text('Eighth'),
                            ),
                            DropdownMenuItem(
                              value:
                                  'Ninth', // Unique value for 'Ninth' under Cleaning Company
                              child: Text('Ninth'),
                            ),
                          ],
              ),
          ],
        ),
      ),
      Step(
        title: Text('Step 3: Review Selection'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              _selectedItems.map((item) => Text(item)).toList(growable: false),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Stepper Page'),
      ),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < _buildSteps().length - 1) {
            setState(() {
              _currentStep += 1;
            });
          } else {
            // Handle confirmation and proceed
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep -= 1;
            });
          }
        },
        steps: _buildSteps(),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MyStepperPage(),
  ));
}

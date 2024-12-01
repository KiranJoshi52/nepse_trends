import 'package:flutter/material.dart';
import 'package:nepse_trends/constants/color.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class ImportPortfolioStepsScreen extends StatelessWidget {
  const ImportPortfolioStepsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Import portfolio steps',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const StepperExample(),
    );
  }
}

class StepperExample extends StatefulWidget {
  const StepperExample({super.key});

  @override
  _StepperExampleState createState() => _StepperExampleState();
}

class _StepperExampleState extends State<StepperExample> {
  int _currentStep = 0;
  String? _selectedFileName;

  // Function to move to the next step
  void _onStepContinue() {
    if (_currentStep < 5) {
      setState(() {
        _currentStep++;
      });
    }
  }

  // Function to handle file upload
  Future<void> _onFileUpload() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'], // Restrict file types to CSV
    );

    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        _selectedFileName = result.files.single.name; // Update the file name
      });
    }
  }

  // Function for importing the selected file
  void _onImport() {
    if (_selectedFileName != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Importing $_selectedFileName')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
      type: StepperType
          .vertical, // Use StepperType.horizontal for horizontal layout
      currentStep: _currentStep,
      onStepContinue: _onStepContinue,
      onStepCancel: null, // Cancel button not needed
      onStepTapped: (int step) {
        setState(() {
          _currentStep = step;
        });
      },
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        if (_currentStep == 5) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                OutlinedButton.icon(
                  onPressed: _onFileUpload,
                  icon: const Icon(Icons.upload_file, color: primaryColor),
                  label: Text(
                    _selectedFileName ?? 'Choose File',
                    style: const TextStyle(
                      color: primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis, // Handle long file names
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: primaryColor),
                  ),
                ),
                if (_selectedFileName != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: ElevatedButton(
                      onPressed: _onImport,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 13.0),
                      ),
                      child: const Text(
                        'Import',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: details.onStepContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 13.0),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }
      },
      steps: [
        Step(
          title: const Text(
            "Go to https://meroshare.cdsc.com.np",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              "To visit the Meroshare website, open up your preferred web browser and in the address bar type \"meroshare.cdsc.com.np\" and press Enter. The Meroshare website will open up in your browser."),
          isActive: _currentStep >= 0,
        ),
        Step(
          title: const Text(
            "Login with valid credentials",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              "You will be redirected to the login page. Enter your valid credentials, such as your Depository Participant(DP), Username and password, and click the \"Login\" button to access your account."),
          isActive: _currentStep >= 1,
        ),
        Step(
          title: const Text(
            'Click the \"My Transaction History\" sidebar tab',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              "After logging in, you will be redirected to the Meroshare dashboard. On the left-hand side of the page, you will see a sidebar with various options. Click on the \"My Transaction History\" tab to view your transaction history."),
          isActive: _currentStep >= 2,
        ),
        Step(
          title: const Text(
            'Click the "Date" radio button to get a list of transaction histories by date.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              'On the Transaction History page, you will see various options to filter your transactions history. Click the "Date" radio button to view a list of transaction histories sorted by date.'),
          isActive: _currentStep >= 3,
        ),
        Step(
          title: const Text(
            'Download CSV file of transaction history.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              'After selecting the desired date range for the transaction histories, click on the "CSV" button located at the top right-hand corner of the page to download the transaction histories in CSV file.'),
          isActive: _currentStep >= 4,
        ),
        Step(
          title: const Text(
            'Import the downloaded file here.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
              'After selecting the desired date range for the transaction histories, click on the "CSV" button located at the top right-hand corner of the page to download the transaction histories in CSV file.'),
          isActive: _currentStep >= 5,
        ),
      ],
    );
  }
}

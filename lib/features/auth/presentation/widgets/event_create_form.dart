import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../reusable_widget/loading_indicator.dart';
import '../../domain/usecases/add_event.dart';

class EventCreateForm extends StatefulWidget {
  final AddEvent addEvent;
  const EventCreateForm({super.key, required this.addEvent});

  @override
  EventCreateFormState createState() => EventCreateFormState();
}

class EventCreateFormState extends State<EventCreateForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _description = '';
  String _eventType = 'Conference'; // Default event type
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _location = '';
  int _capacity = 0;
  DateTime? _registrationDeadline;

  bool _isNameValid = true;
  bool _isDescriptionValid = true;
  bool _isLocationValid = true;
  bool _isCapacityValid = true;
  bool _isDateValid = true;
  bool _isStartTimeValid = true;
  bool _isEndTimeValid = true;
  bool _isRegistrationDeadlineValid = true;

  // Event type options
  final List<String> _eventTypes = ['Conference', 'MeetUp', 'Seminar', 'Tech Fest'];

  // Method to validate all fields
  bool _validateFields() {
    if (_name.isEmpty) {
      setState(() {
        _isNameValid = false;
      });
      return false;
    }

    if (_description.isEmpty) {
      setState(() {
        _isDescriptionValid = false;
      });
      return false;
    }

    if (_selectedDate == null) {
      setState(() {
        _isDateValid = false;
      });
      return false;

    }

    if (_startTime == null) {
      setState(() {
        _isStartTimeValid = false;
      });
      return false;
    }

    if (_endTime == null) {
      setState(() {
        _isEndTimeValid = false;
      });
      return false;
    }

    if (_location.isEmpty) {
      setState(() {
        _isLocationValid = false;
      });
      return false;
    }

    if (_capacity <= 0) {
      setState(() {
        _isCapacityValid = false;
      });
      return false;
    }

    if (_registrationDeadline == null) {
      setState(() {
        _isRegistrationDeadlineValid = false;
      });
      return false;
    }
    return true;
  }

  // Method to reset the form and fields
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _name = '';
      _description = '';
      _location = '';
      _capacity = 0;
      _selectedDate = null;
      _startTime = null;
      _endTime = null;
      _registrationDeadline = null;
      _isNameValid = true;
      _isDescriptionValid = true;
      _isLocationValid = true;
      _isCapacityValid = true;
      _isDateValid = true;
      _isStartTimeValid = true;
      _isEndTimeValid = true;
      _isRegistrationDeadlineValid = true;
    });
  }

  // Method to handle event creation
  void _submitForm() async {
    if (_validateFields()) {
      _formKey.currentState!.save();
      await _handleEventCreation();
    }
  }


  // Method to handle user registration
  Future<void> _handleEventCreation() async {
    // Show loading indicator
    _showLoadingIndicator();

    try {
      await widget.addEvent.addEvent(
        name: _name,
        description: _description,
        eventType: _eventType,
        eventDate: _selectedDate!,
        startTime: _startTime!,
        endTime: _endTime!,
        location: _location,
        capacity: _capacity,
        registrationDeadline: _registrationDeadline!,
      );

      // Dismiss loading indicator only if mounted
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Clear the form and reset all fields
      _resetForm();

      // Show success snackbar with green background and icon, only if mounted
      if (mounted) {
        _showSuccessSnackbar();
      }
    } catch (e) {
      // Dismiss loading indicator only if mounted
      if (mounted) {
        Navigator.of(context).pop();
      }

      // Handle registration errors only if mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  // Method to show loading indicator
  void _showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Dialog(
          backgroundColor: Colors.transparent,
          child: LoadingIndicator(message: 'Event Adding...'),
        );
      },
    );
  }

  // Method to show success snackbar
  void _showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 10), // Spacing between icon and text
            Text('Event created successfully'),
          ],
        ),
        backgroundColor: Colors.green, // Green background color for success
        behavior: SnackBarBehavior.floating, // Optional: Make the snackbar floating
      ),
    );
  }

  // Method to show error snackbar
  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error, color: Colors.white),
            const SizedBox(width: 10), // Spacing between icon and text
            Text(message),
          ],
        ),
        backgroundColor: Colors.red, // Red background color for error
        behavior: SnackBarBehavior.floating, // Optional: Make the snackbar floating
      ),
    );
  }

  // Date picker method
  Future<void> _selectDate(BuildContext context, bool isEventDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isEventDate) {
          _selectedDate = picked;
          _isDateValid = true;
        } else {
          _registrationDeadline = picked;
          _isRegistrationDeadlineValid = true;
        }
      });
    }
  }

  // Time picker method
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          _startTime = picked;
          _isStartTimeValid = true;
        } else {
          _endTime = picked;
          _isEndTimeValid = true;
        }
      });
    }
  }

  // Method to reset the error when typing
  void _resetErrorState(String field) {
    setState(() {
      switch (field) {
        case 'name':
          _isNameValid = true;
          break;
        case 'description':
          _isDescriptionValid = true;
          break;
        case 'location':
          _isLocationValid = true;
          break;
        case 'capacity':
          _isCapacityValid = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Event Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  errorText: _isNameValid ? null : 'Please enter event name',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _name = value;
                  if (!_isNameValid) {
                    _resetErrorState('name');
                  }
                },
                onSaved: (value) {
                  _name = value ?? '';
                },
              ),
              const SizedBox(height: 20),

              // Description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  errorText: _isDescriptionValid ? null : 'Please enter description',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _description = value;
                  if (!_isDescriptionValid) {
                    _resetErrorState('description');
                  }
                },
                onSaved: (value) {
                  _description = value ?? '';
                },
              ),
              const SizedBox(height: 20),

              // Event Type (Dropdown)
              DropdownButtonFormField(
                value: _eventType,
                decoration: const InputDecoration(
                  labelText: 'Event Type',
                  border: OutlineInputBorder(),
                ),
                items: _eventTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _eventType = value as String;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Date Picker
              ListTile(
                title: const Text('Event Date'),
                subtitle: Text(
                  _selectedDate != null ? DateFormat('yyyy-MM-dd').format(_selectedDate!) : 'Select Date',
                  style: TextStyle(
                    color: _isDateValid ? Colors.black : Colors.red,
                  ),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 20),

              // Start Time Picker
              ListTile(
                title: const Text('Start Time'),
                subtitle: Text(
                  _startTime != null ? _startTime!.format(context) : 'Select Start Time',
                  style: TextStyle(
                    color: _isStartTimeValid ? Colors.black : Colors.red,
                  ),
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context, true),
              ),
              const SizedBox(height: 20),

              // End Time Picker
              ListTile(
                title: const Text('End Time'),
                subtitle: Text(
                  _endTime != null ? _endTime!.format(context) : 'Select End Time',
                  style: TextStyle(
                    color: _isEndTimeValid ? Colors.black : Colors.red,
                  ),
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _selectTime(context, false),
              ),
              const SizedBox(height: 20),

              // Location
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Location',
                  errorText: _isLocationValid ? null : 'Please enter location',
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _location = value;
                  if (!_isLocationValid) {
                    _resetErrorState('location');
                  }
                },
                onSaved: (value) {
                  _location = value ?? '';
                },
              ),
              const SizedBox(height: 20),

              // Capacity
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Capacity',
                  errorText: _isCapacityValid ? null : 'Enter a valid capacity',
                  border: const OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  _capacity = int.tryParse(value) ?? 0;
                  if (!_isCapacityValid) {
                    _resetErrorState('capacity');
                  }
                },
                onSaved: (value) {
                  _capacity = int.tryParse(value ?? '0') ?? 0;
                },
              ),
              const SizedBox(height: 20),

              // Registration Deadline Picker
              ListTile(
                title: const Text('Registration Deadline'),
                subtitle: Text(
                  _registrationDeadline != null
                      ? DateFormat('yyyy-MM-dd').format(_registrationDeadline!)
                      : 'Select Registration Deadline',
                  style: TextStyle(
                    color: _isRegistrationDeadlineValid ? Colors.black : Colors.red,
                  ),
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _selectDate(context, false),
              ),
              const SizedBox(height: 30),

              // Submit Button
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF04224C), // Custom button color
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                child: Text(
                  'Create Event'.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white, // Set text color to white
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

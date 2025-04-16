import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class BasicJumpBookingScreen extends StatefulWidget {
  const BasicJumpBookingScreen({
    super.key,
  });

  @override
  State<BasicJumpBookingScreen> createState() => _BasicJumpBookingScreenState();
}

class _BasicJumpBookingScreenState extends State<BasicJumpBookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  // Current step and form controllers
  int _currentStep = 0;
  
  // Date and time selection
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  final List<String> _timeSlots = [
    '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
    '01:00 PM', '02:00 PM', '03:00 PM', '04:00 PM',
    '05:00 PM', '06:00 PM', '07:00 PM', '08:00 PM',
  ];
  
  // Session duration
  bool _twoHourSession = false;
  
  // People count
  int _peopleCount = 1;
  final double _basePricePerPerson = 120.0; // R120 for 1 hour per person
  
  // Extras
  final Map<String, double> _extras = {
    'Gravity Socks': 35.0,
    'Water Bottle': 20.0,
    'Locker Usage': 15.0,
    'Party Bag': 50.0,
  };
  final List<String> _selectedExtras = [];
  
  // Contact details
  bool _waiverAccepted = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  // Payment details
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cardHolderController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Jump Booking'),
        backgroundColor: const Color(0xFFF36122),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Form(
          key: _formKey,
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepContinue: () {
              if (_currentStep < 4) {
                setState(() {
                  _currentStep += 1;
                });
              } else {
                _submitBooking();
              }
            },
            onStepCancel: () {
              if (_currentStep > 0) {
                setState(() {
                  _currentStep -= 1;
                });
              }
            },
            controlsBuilder: (context, details) {
              return Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: details.onStepContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF36122),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        _currentStep == 4 ? 'SUBMIT' : 'NEXT',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (_currentStep > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text(
                            'BACK',
                            style: TextStyle(
                              color: Color(0xFFF36122),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
            steps: [
              _buildDateTimeStep(isMobile),
              _buildDurationPeopleStep(isMobile),
              _buildExtrasStep(isMobile),
              _buildContactDetailsStep(isMobile),
              _buildPaymentStep(isMobile),
            ],
          ),
        ),
      ),
    );
  }
  
  // Calculate the total cost
  double _calculateTotal() {
    double total = _basePricePerPerson * _peopleCount;
    
    // Add cost for 2-hour session if selected
    if (_twoHourSession) {
      total += 90.0 * _peopleCount; // R90 additional per person for the second hour
    }
    
    // Add extras
    for (String extra in _selectedExtras) {
      total += _extras[extra] ?? 0;
    }
    
    return total;
  }
  
  // Date and Time Step
  Step _buildDateTimeStep(bool isMobile) {
    return Step(
      title: const Text('Date & Time'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select a Date & Time',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          
          // Date Picker
          InkWell(
            onTap: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 60)),
              );
              
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4),
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Select a Date'
                        : DateFormat('EEEE, MMMM d, yyyy').format(_selectedDate!),
                    style: TextStyle(
                      color: _selectedDate == null ? Colors.grey[600] : Colors.black,
                    ),
                  ),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 30),
          const Text(
            'Available Time Slots',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          
          // Time Slots Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 3 : 4,
              childAspectRatio: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _timeSlots.length,
            itemBuilder: (context, index) {
              final timeSlot = _timeSlots[index];
              final isSelected = timeSlot == _selectedTimeSlot;
              
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedTimeSlot = timeSlot;
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFF36122) : Colors.grey[200],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    timeSlot,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      isActive: _currentStep >= 0,
    );
  }

  // Duration and People Count Step
  Step _buildDurationPeopleStep(bool isMobile) {
    return Step(
      title: const Text('Duration & People'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose Session Duration',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          
          // Session Duration Selection
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _twoHourSession = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: !_twoHourSession ? const Color(0xFFF36122) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '1 Hour',
                          style: TextStyle(
                            color: !_twoHourSession ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'R${_basePricePerPerson.toStringAsFixed(0)}/person',
                          style: TextStyle(
                            color: !_twoHourSession ? Colors.white : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _twoHourSession = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _twoHourSession ? const Color(0xFFF36122) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '2 Hours',
                          style: TextStyle(
                            color: _twoHourSession ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'R${(_basePricePerPerson + 90).toStringAsFixed(0)}/person',
                          style: TextStyle(
                            color: _twoHourSession ? Colors.white : Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 30),
          const Text(
            'Number of People',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          
          // People Count Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _peopleCount > 1
                    ? () {
                        setState(() {
                          _peopleCount--;
                        });
                      }
                    : null,
                icon: const Icon(Icons.remove_circle_outline),
                color: const Color(0xFFF36122),
                iconSize: 32,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  _peopleCount.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _peopleCount++;
                  });
                },
                icon: const Icon(Icons.add_circle_outline),
                color: const Color(0xFFF36122),
                iconSize: 32,
              ),
            ],
          ),
          
          const SizedBox(height: 30),
          
          // Cost Calculation
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _twoHourSession
                      ? '$_peopleCount People × 2 Hours:'
                      : '$_peopleCount People × 1 Hour:',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'R${(_peopleCount * (_basePricePerPerson + (_twoHourSession ? 90 : 0))).toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF36122),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      isActive: _currentStep >= 1,
    );
  }

  // Extras Step
  Step _buildExtrasStep(bool isMobile) {
    return Step(
      title: const Text('Extras'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Additional Items',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Enhance your experience with these add-ons',
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          
          // Extras Selection
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _extras.length,
            itemBuilder: (context, index) {
              final extraName = _extras.keys.elementAt(index);
              final extraPrice = _extras.values.elementAt(index);
              final isSelected = _selectedExtras.contains(extraName);
              
              return CheckboxListTile(
                title: Text(extraName),
                subtitle: Text('R${extraPrice.toStringAsFixed(2)}'),
                value: isSelected,
                activeColor: const Color(0xFFF36122),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      _selectedExtras.add(extraName);
                    } else {
                      _selectedExtras.remove(extraName);
                    }
                  });
                },
              );
            },
          ),
          
          const SizedBox(height: 20),
          
          // Total for extras
          if (_selectedExtras.isNotEmpty) 
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Extras:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'R${_selectedExtras.fold<double>(0, (sum, item) => sum + (_extras[item] ?? 0)).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFF36122),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      isActive: _currentStep >= 2,
    );
  }
  
  // Contact Details Step
  Step _buildContactDetailsStep(bool isMobile) {
    return Step(
      title: const Text('Contact Details'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Contact Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email Address',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@') || !value.contains('.')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            title: const Text(
              'Terms & Conditions / Waiver',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'GRAVITY TRAMPOLINE PARK WAIVER',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'PLEASE READ CAREFULLY BEFORE SIGNING',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'I acknowledge that using Gravity Trampoline Park facilities involves risks, including serious injury or death. I accept full responsibility for my own safety and the safety of any minors in my care. I confirm I am in good physical condition with no conditions that could be aggravated by physical activity.',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'I agree to follow all rules and instructions provided by Gravity staff. I understand that failure to do so may result in ejection without refund. I agree that Gravity is not liable for any injuries resulting from my own negligence or failure to follow rules.',
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'I grant permission for Gravity to use any photographs or recordings taken during my visit for marketing purposes. I acknowledge that this waiver will apply to all future visits unless explicitly revoked in writing.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              CheckboxListTile(
                title: const Text('I accept the terms and waiver'),
                value: _waiverAccepted,
                activeColor: const Color(0xFFF36122),
                onChanged: (bool? value) {
                  setState(() {
                    _waiverAccepted = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
        ],
      ),
      isActive: _currentStep >= 3,
    );
  }
  
  // Payment Step
  Step _buildPaymentStep(bool isMobile) {
    return Step(
      title: const Text('Payment'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Payment Details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_twoHourSession ? '2 Hour Jump (${_peopleCount} People):' : '1 Hour Jump (${_peopleCount} People):'),
                    Text('R${(_peopleCount * (_basePricePerPerson + (_twoHourSession ? 90 : 0))).toStringAsFixed(2)}'),
                  ],
                ),
                if (_selectedExtras.isNotEmpty) ...[
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Extras:'),
                      Text('R${_selectedExtras.fold<double>(0, (sum, item) => sum + (_extras[item] ?? 0)).toStringAsFixed(2)}'),
                    ],
                  ),
                ],
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'R${_calculateTotal().toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xFFF36122),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Card Information',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _cardHolderController,
            decoration: const InputDecoration(
              labelText: 'Cardholder Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter cardholder name';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _cardNumberController,
            decoration: const InputDecoration(
              labelText: 'Card Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter card number';
              } else if (value.length < 16) {
                return 'Please enter a valid card number';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _expiryDateController,
                  decoration: const InputDecoration(
                    labelText: 'Expiry (MM/YY)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: TextFormField(
                  controller: _cvvController,
                  decoration: const InputDecoration(
                    labelText: 'CVV',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
        ],
      ),
      isActive: _currentStep >= 4,
    );
  }
  
  void _submitBooking() {
    if (_formKey.currentState!.validate()) {
      if (!_waiverAccepted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please accept the waiver before proceeding.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      if (_selectedDate == null || _selectedTimeSlot == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a date and time slot.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      // Show success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Booking Successful!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 60,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Your jump session has been booked successfully!',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'A confirmation has been sent to ${_emailController.text}',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('RETURN TO HOME'),
              ),
            ],
          );
        },
      );
    }
  }
} 
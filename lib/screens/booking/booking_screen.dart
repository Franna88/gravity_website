import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BookingScreen extends StatefulWidget {
  final String packageTitle;
  final String packagePrice;
  final String additionalPersonCost;
  final int basePersonCount;
  final Color packageColor;

  const BookingScreen({
    super.key, 
    required this.packageTitle,
    required this.packagePrice,
    required this.additionalPersonCost,
    required this.basePersonCount,
    required this.packageColor,
  });

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  
  // Stepper current step
  int _currentStep = 0;
  
  // Booking details
  int _partySize = 10;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;
  List<String> _selectedExtras = [];
  bool _waiverAccepted = false;
  
  // User details
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  // Payment details
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  
  // Available time slots
  final List<String> _timeSlots = [
    '09:00 - 11:00',
    '11:30 - 13:30',
    '14:00 - 16:00',
    '16:30 - 18:30',
    '19:00 - 21:00',
  ];
  
  // Available extras
  final Map<String, double> _extras = {
    'Party Decorations Pack': 250.0,
    'Birthday Cake (Vanilla)': 350.0,
    'Birthday Cake (Chocolate)': 350.0,
    'Additional 30min Jump Time': 450.0,
    'Gravity Socks (10 pairs)': 250.0,
    'Photography Service': 550.0,
    'Party Host/MC': 300.0,
  };
  
  // Calculate total cost
  double _calculateTotal() {
    // Extract base price from string (e.g., "R2300 for 10 children" -> 2300)
    String basePrice = widget.packagePrice.replaceAll(RegExp(r'[^0-9]'), '');
    double total = double.parse(basePrice);
    
    // Add cost for additional guests
    String additionalCost = widget.additionalPersonCost.replaceAll(RegExp(r'[^0-9]'), '');
    int extraPeople = _partySize - widget.basePersonCount;
    if (extraPeople > 0) {
      total += extraPeople * double.parse(additionalCost);
    }
    
    // Add extras
    for (String extra in _selectedExtras) {
      total += _extras[extra] ?? 0;
    }
    
    return total;
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Party'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(isMobile ? 16 : 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBookingHeader(),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Stepper(
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
                    final isLastStep = _currentStep == 4;
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: details.onStepContinue,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: widget.packageColor,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            ),
                            child: Text(isLastStep ? 'CONFIRM BOOKING' : 'CONTINUE'),
                          ),
                          if (_currentStep > 0) ...[
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: details.onStepCancel,
                              child: const Text('BACK'),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                  steps: [
                    _buildPartyDetailsStep(isMobile),
                    _buildDateTimeStep(isMobile),
                    _buildExtrasStep(isMobile),
                    _buildContactDetailsStep(isMobile),
                    _buildPaymentStep(isMobile),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildBookingHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: widget.packageColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: widget.packageColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.packageTitle,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: widget.packageColor,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Base price: ${widget.packagePrice}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Additional person: ${widget.additionalPersonCost}',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Text(
                'Total: ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'R${_calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: widget.packageColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  
  Step _buildPartyDetailsStep(bool isMobile) {
    return Step(
      title: const Text('Party Size'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How many people will be attending?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Base package includes ${widget.basePersonCount} people',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle),
                onPressed: _partySize > widget.basePersonCount
                    ? () {
                        setState(() {
                          _partySize--;
                        });
                      }
                    : null,
                color: widget.packageColor,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  '$_partySize',
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle),
                onPressed: () {
                  setState(() {
                    _partySize++;
                  });
                },
                color: widget.packageColor,
              ),
              const SizedBox(width: 20),
              if (_partySize > widget.basePersonCount)
                Text(
                  '+ R${(double.parse(widget.additionalPersonCost.replaceAll(RegExp(r'[^0-9]'), '')) * (_partySize - widget.basePersonCount)).toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: widget.packageColor,
                  ),
                ),
            ],
          ),
        ],
      ),
      isActive: _currentStep >= 0,
    );
  }
  
  Step _buildDateTimeStep(bool isMobile) {
    return Step(
      title: const Text('Date & Time'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Date',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 90)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: widget.packageColor,
                      ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                setState(() {
                  _selectedDate = picked;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Select a date'
                        : DateFormat('EEE, MMM d, yyyy').format(_selectedDate!),
                    style: TextStyle(
                      color: _selectedDate == null ? Colors.grey : Colors.black,
                    ),
                  ),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Time Slot',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _timeSlots.map((time) {
              final isSelected = _selectedTimeSlot == time;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedTimeSlot = time;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? widget.packageColor : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? widget.packageColor : Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    time,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      isActive: _currentStep >= 1,
    );
  }
  
  Step _buildExtrasStep(bool isMobile) {
    return Step(
      title: const Text('Extras'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Choose any extras for your party',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ..._extras.entries.map((entry) {
            final isSelected = _selectedExtras.contains(entry.key);
            return CheckboxListTile(
              title: Text(entry.key),
              subtitle: Text('R${entry.value.toStringAsFixed(2)}'),
              value: isSelected,
              activeColor: widget.packageColor,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    _selectedExtras.add(entry.key);
                  } else {
                    _selectedExtras.remove(entry.key);
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            );
          }).toList(),
          if (_selectedExtras.isNotEmpty) ...[
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Extras:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ..._selectedExtras.map((extra) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(extra),
                          Text(
                            'R${_extras[extra]!.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Extras Total:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'R${_selectedExtras.fold<double>(0, (sum, item) => sum + (_extras[item] ?? 0)).toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.packageColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      isActive: _currentStep >= 2,
    );
  }
  
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
                activeColor: widget.packageColor,
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
                    const Text('Package Base Price:'),
                    Text(widget.packagePrice),
                  ],
                ),
                if (_partySize > widget.basePersonCount) ...[
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Additional Guests (${_partySize - widget.basePersonCount}):'),
                      Text('R${(double.parse(widget.additionalPersonCost.replaceAll(RegExp(r'[^0-9]'), '')) * (_partySize - widget.basePersonCount)).toStringAsFixed(2)}'),
                    ],
                  ),
                ],
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
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: widget.packageColor,
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
                  'Your party has been booked successfully!',
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
                child: const Text('Return to Packages'),
              ),
            ],
          );
        },
      );
    }
  }

  String _formatCurrency(double amount) {
    final formatter = NumberFormat.currency(symbol: '£', decimalDigits: 2);
    return formatter.format(amount);
  }
} 
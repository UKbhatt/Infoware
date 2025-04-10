import 'package:flutter/material.dart';

class Formvalidation extends StatefulWidget {
  const Formvalidation({super.key});

  @override
  State<Formvalidation> createState() => _Formvalidation();
}

class _Formvalidation extends State<Formvalidation> {
  final _formkey = GlobalKey<FormState>();
  String? _gender;
  String? _country;
  String? _state;
  String? _city;
  var _isSubmitted = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final List<String> countries = ['INDIA', 'USA'];
  final List<String> states = ['Maharashtra', 'California'];
  final List<String> cities = ['Nagpur', 'New York'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form Validation",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Name",
                    prefixIcon: const Icon(Icons.person, color: Colors.orange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter Name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: const Icon(Icons.email, color: Colors.orange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter email';
                    } else {
                      final emailRegex =
                          RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}$');
                      return emailRegex.hasMatch(value)
                          ? null
                          : 'Invalid Email';
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Phone",
                    prefixIcon: const Icon(Icons.call, color: Colors.orange),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter phone number';
                    }
                    return value.length == 10
                        ? null
                        : 'Enter 10-digit phone number';
                  },
                ),
                const SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Gender",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    RadioListTile(
                        title: const Text("Male"),
                        value: "Male",
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value)),
                    RadioListTile(
                        title: const Text("Female"),
                        value: "Female",
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value)),
                    RadioListTile(
                        title: const Text("Other"),
                        value: "Other",
                        groupValue: _gender,
                        onChanged: (value) => setState(() => _gender = value)),
                    if (_gender == null && _isSubmitted)
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          "Please select gender",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Country"),
                  value: _country,
                  items: countries
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _country = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Select your country' : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "State"),
                  value: _state,
                  items: states
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _state = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Select your state' : null,
                ),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "City"),
                  value: _city,
                  items: cities
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _city = value;
                    });
                  },
                  validator: (value) =>
                      value == null ? 'Select your city' : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                     setState(() {
                      _isSubmitted = true;
                    });
                    if (_formkey.currentState!.validate() && _gender != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Form Submitted Successfully')),
                      );
                    } else {
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

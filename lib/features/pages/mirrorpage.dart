import 'package:flutter/material.dart';

class MirrorPage extends StatefulWidget {
  @override
  _MirrorPageState createState() => _MirrorPageState();
}

class _MirrorPageState extends State<MirrorPage> {
  Map<String, bool> options = {
    'Substance counselor': false,
    'Career counseling': false,
    'Life coach': false,
    'Therapist': false,
    'Counseling': false,
    'Trauma therapist': false,
    'Mentor for youth': false,
    'Family counseling': false,
    'Parent counseling': false,
    'Couples counseling': false,
    'Marriage counseling': false,
    'Rehabilitation counseling': false,
    'Tutoring adults': false,
    'Identity counseling': false,
    'Tutoring kids': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAFBD7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'The Mirror',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    'assets/images/amico_2.png',
                    height: 180,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: options.keys.map((String key) {
                    // Define threshold length
                    bool isLong = key.length > 20;
                    return SizedBox(
                      width: isLong
                          ? MediaQuery.of(context).size.width - 24 // Full width
                          : MediaQuery.of(context).size.width / 2 - 20, // Half width
                      child: CheckboxListTile(
                        title: Text(
                          key,
                          style: const TextStyle(fontSize: 13),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                        value: options[key],
                        onChanged: (bool? value) {
                          setState(() {
                            options[key] = value ?? false;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        tileColor: Colors.white,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: options.containsValue(true) ? () {
                      final selected = options.entries.where((e) => e.value).map((e) => e.key).toList();
                      print("Selected: $selected");
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen[300],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 150,
                          vertical: 16
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Go',
                      style: TextStyle(fontSize: 16, color: Colors.white),
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

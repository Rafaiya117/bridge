import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button with green rounded rectangle
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Color(0xFF22A45D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Trams & Conditions',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'By using [Your App Name], you agree to these Terms & Conditions. If you do not agree, please do not use our services.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '1. Use of Service',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      bulletText('10 years old to adult'),
                      bulletText('Parent or guardian permission'),
                      bulletText(
                          'Do not use the service for illegal, fraudulent, or deceptive activities.'),
                      bulletText(
                          'We may suspend or terminate accounts that violate our policies.'),
                      const SizedBox(height: 12),
                      const Text(
                        '2. Subscription & Payments',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      bulletText(
                          'You are responsible for managing your subscription in the Manage Subscription section.'),
                      bulletText(
                          'Payments are non-refundable unless stated otherwise.'),
                      bulletText(
                          'Cancellation takes effect at the end of the billing cycle.'),
                      const SizedBox(height: 12),
                      const Text(
                        '3. Voice Cloning & Content',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      bulletText('You must have the legal right to upload any voice samples.'),
                      bulletText(
                          'You retain ownership of your voice data, but we may process it to improve our services.'),
                      bulletText(
                          'We are not responsible for any misuse of cloned voices by users.'),
                      const SizedBox(height: 12),
                      const Text(
                        '4. Privacy & Security',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      bulletText('We follow strict privacy policies to protect user data.'),
                      bulletText(
                          'Voice data processing may involve...'), // The image cuts off here so I abbreviated.
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ',
              style: TextStyle(
                fontSize: 14,
                height: 1.3,
              )),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

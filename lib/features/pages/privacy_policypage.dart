import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background white by default
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 16),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF008080), // Tealish green
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
        title: const Text(
          'Privacy policy',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'This Privacy Policy explains how [Your App Name] collects, uses, and protects your personal information when you use our AI voice cloning service.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 24),
              Text(
                '1. Information We Collect',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(height: 8),
              BulletPoint(text: 'Personal Data: Information you provide, such as voice samples, email address, and account details.'),
              BulletPoint(text: 'Usage Data: Technical details like IP address, device type, and usage patterns to improve our service.'),
              SizedBox(height: 16),
              Text(
                '2. How We Use Your Information',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(height: 8),
              BulletPoint(text: 'To provide and personalize our services.'),
              BulletPoint(text: 'To analyze usage and enhance our features.'),
              BulletPoint(text: 'For communication regarding updates, offers, or support.'),
              SizedBox(height: 16),
              Text(
                '3. Data Sharing & Third Parties',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(height: 8),
              BulletPoint(text: 'We do not sell your personal data.'),
              BulletPoint(text: 'Your data may be shared with trusted third-party service providers (e.g., payment processors, AI tools) strictly to facilitate our service and as required by law.'),
              SizedBox(height: 16),
              Text(
                '4. Data Security',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              SizedBox(height: 8),
              BulletPoint(text: 'We implement industry-standard security measures to protect your data.'),
              BulletPoint(text: 'While we work to safeguard your information, no system is completely secure.'),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  const BulletPoint({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 14, height: 1.5)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

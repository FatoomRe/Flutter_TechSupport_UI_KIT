import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'صفحة الدعم الفني',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const ContactUsPage(),
      debugShowCheckedModeBanner: false,

      locale: const Locale('ar', 'AE'),
      // Ensure that the directionality is RTL
      supportedLocales: const [Locale('ar', 'AE')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0), // Set your desired height here
        child: AppBar(
          title: const Text('تواصل معنا',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.green, Colors.yellow],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                  icon: Icons.phone,
                  title: 'اتصال',
                  contact: '966138332029+',
                ),
                InfoCard(
                  icon: Icons.email,
                  title: 'إيميل',
                  contact: 'info@alfares.sa',
                ),
                InfoCard(
                  icon: Icons.support_agent,
                  title: 'دعم فني',
                  contact: 'info@alfares.sa',
                ),
              ],
            ),
            SizedBox(height: 5.0),
            ContactForm(),
          ],
        ),
      ),
    );
  }
}

// this is a stateless widget that displays information in a card format.
// It takes an icon, title, description, and contact information as inputs
// and displays them in a structured layout. This widget is designed to be
// flexible and easily reusable in different parts of an app.

class InfoCard extends StatelessWidget {
  // The icon to display at the top of the card.
  final IconData icon;
  // The title of the card, displayed below the icon.
  final String title;
  // Contact information or any relevant string to display at the bottom.
  final String contact;

  // Constructs an [InfoCard] widget.
  // Requires [icon], [title], [description], and [contact] to be provided.
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    // Wraps the card content in an Expanded widget to allow it to fill the
    // available space in a Row, Column, or Flex.
    return Expanded(
      child: Card(
        elevation: 4.0, // Shadow depth of the card.
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Rounded corners of the card.
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the card.
          child: Column(
            children: [
              Icon(icon,
                  size: 30.0,
                  color: const Color.fromARGB(
                      255, 88, 167, 45)), // Displays the icon.
              const SizedBox(height: 10.0), // Spacing between icon and title.
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15.0, // Font size of the title.
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 10.0), // Spacing between title and description.
              Text(
                contact,
                style: const TextStyle(
                  fontSize: 11.0, // Font size of the contact information.
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Color of the contact information.
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactForm extends StatelessWidget {
  const ContactForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
                label: 'الإسم', hint: 'أدخل اسمك', controller: nameController),
            CustomTextField(
                label: 'الهاتف',
                hint: 'أدخل رقم هاتفك',
                controller: phoneController),
            CustomTextField(
                label: 'الإيميل',
                hint: 'أدخل بريدك الإلكتروني',
                controller: emailController),
            CustomTextField(
                label: 'نص الرسالة',
                hint: 'أدخل رسالتك هنا',
                controller: messageController,
                maxLines: 4),
            const SizedBox(height: 3.0),
            ElevatedButton(
              onPressed: () {
                // Clear the text fields
                nameController.clear();
                phoneController.clear();
                emailController.clear();
                messageController.clear();

                // Show confirmation message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم الإرسال بنجاح')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 105, 199, 55),
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              child: const Text(
                'إرسال',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller, // Set the controller here
        textAlign: TextAlign.right,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 87, 165, 45)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 226, 191, 33)),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BookHistoryDetailPage extends StatelessWidget {
  final String title;
  final String borrowDate;
  final String borrowTime;
  final String returnedDate;
  final String returnedTime;
  final String charges;

  // Constructor to receive the book details
  const BookHistoryDetailPage({
    Key? key,
    required this.title,
    required this.borrowDate,
    required this.borrowTime,
    required this.returnedDate,
    required this.returnedTime,
    required this.charges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 18, // Set the size of the back arrow
            color: Color(0xFF800000), // Set the color of the icon
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back on pressing the back arrow
          },
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ), // Matching app bar color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard('Borrow Date', borrowDate),
            _buildCard('Time Borrowed', borrowTime),
            const SizedBox(height: 20),
            _buildCard('Returned Date', returnedDate),
            _buildCard('Time Returned', returnedTime),
            const SizedBox(height: 20),
            charges.isNotEmpty
                ? _buildCard('Charges', charges)
                : Container(),
          ],
        ),
      ),
    );
  }

  // Reusable method to build a card-like section for each detail
  Widget _buildCard(String label, String value) {
    return Card(
      elevation: 4, // Add shadow for a card effect
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Rounded corners
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF800000), // Accent color for labels
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

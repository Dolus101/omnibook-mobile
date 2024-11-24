import 'package:flutter/material.dart';
import 'package:omnibook/BookHistoryDetailPage.dart'; // Single import for BookHistoryDetailPage
import 'package:omnibook/Dashboard.dart'; // Import the Dashboard for navigation
import 'profile_page.dart'; // Import for navigation to Profile Page

class BookHistoryPage extends StatefulWidget {
  const BookHistoryPage({Key? key}) : super(key: key);

  static const Color primaryColor = Color.fromARGB(255, 0, 117, 252);
  static const Color backgroundColor = Color.fromARGB(255, 224, 228, 247);
  static const double headerHeight = 130;

  @override
  _BookHistoryPageState createState() => _BookHistoryPageState();
}

class _BookHistoryPageState extends State<BookHistoryPage> {
  int _currentIndex = 1; // Set initial selected tab to 'History'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100], // Background color for the body
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Color(0xFF800000), // Back arrow color
                    size: 18,
                  ),
                  onPressed: () {
                    // Navigate to Dashboard when back arrow is pressed
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const Dashboard()),
                      (Route<dynamic> route) => false, // Remove all previous routes
                    );
                  },
                ),
                const SizedBox(width: 8), // Space between back arrow and title
                const Text(
                  'Book History',
                  style: TextStyle(
                    fontSize: 16, // Adjusted font size for the title
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Borrowed Books',
              style: TextStyle(
                fontSize: 16, // Adjusted font size for borrowed books title
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Book items with navigation to detailed view
            _buildBookItem(
              context,
              'The Great Gatsby',
              'November 1, 2024',
              '12:00 pm',
              'November 2, 2024',
              '12:00 pm',
            ),
            _buildBookItem(
              context,
              'War and Peace',
              'November 1, 2024',
              '12:00 pm',
              'November 3, 2024',
              '1:00 pm',
              'P 2.00',
            ),
            // Add more items as needed
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Color(0xFF800000), // Color when selected
        unselectedItemColor: Colors.grey, // Color when not selected
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Dashboard()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BookHistoryPage()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
              break;
          }
        },
      ),
    );
  }

  // Book item with navigation to detailed view
  Widget _buildBookItem(
    BuildContext context,
    String title,
    String borrowDate,
    String borrowTime,
    String returnedDate,
    String returnedTime, [
    String charges = '',
  ]) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward, color: Color(0xFF800000), size: 16),
        onTap: () {
          // Navigate to BookHistoryDetailPage with the passed details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookHistoryDetailPage(
                title: title,
                borrowDate: borrowDate,
                borrowTime: borrowTime,
                returnedDate: returnedDate,
                returnedTime: returnedTime,
                charges: charges,
              ),
            ),
          );
        },
      ),
    );
  }
}

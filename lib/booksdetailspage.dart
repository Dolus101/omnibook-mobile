import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final String bookTitle;
  final String authors;
  final String language;
  final String categories;
  final String publishDate;
  final String description; // This holds the actual book description

  const BookDetailsPage({
    Key? key,
    required this.bookTitle,
    required this.authors,
    required this.language,
    required this.categories,
    required this.publishDate,
    required this.description, // Ensure the description is passed correctly
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background color
      appBar: AppBar(
        title: const Text(
          'Book Details',
          style: TextStyle(fontSize: 16), // Adjusted font size for the title
        ),
        backgroundColor: Colors.grey[200], // Light background for contrast
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF800000),
            size: 20, // Adjusted size for the back icon
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // Placeholder for book image
                Container(
                  width: 80,
                  height: 120,
                  color: const Color(0xFF800000), // Placeholder color
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        bookTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1, // Ensure the title stays on one line
                        overflow: TextOverflow.ellipsis, // Add ellipsis when the title overflows
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description.isEmpty ? "No description available" : description,
                        style: const TextStyle(fontSize: 14),
                        maxLines: 1, // Limit description to 3 lines
                        overflow: TextOverflow.ellipsis, // Add ellipsis for description overflow
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Info',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 10),
            buildInfoRow('Title', bookTitle),
            buildInfoRow('Authors', authors),
            buildInfoRow('Categories', categories),
            buildInfoRow('Publisher', publishDate),
            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: const Color(0xFF800000), // Updated button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  _showToastNotification(context);
                },
                child: const Text(
                  'Borrow Now',
                  style: TextStyle(color: Colors.white), // Updated text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              maxLines: 1, // Limit to 1 line
              overflow: TextOverflow.ellipsis, // Add ellipsis when text overflows
              textAlign: TextAlign.end, // Align text to the right
            ),
          ),
        ],
      ),
    );
  }

  void _showToastNotification(BuildContext context) {
    // Create a custom overlay entry
    final overlay = Overlay.of(context);

    // Create a toast-like notification at the center
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50, // Centering vertically
        left: MediaQuery.of(context).size.width / 2 - 125, // Centering horizontally
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(width: 8),
                Text(
                  'Book Borrowed Successfully!',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    overlay.insert(overlayEntry);

    // Remove the overlay after a few seconds
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

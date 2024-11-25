import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookDetailsPage extends StatefulWidget {
  final String bookId;
  final String bookTitle;
  final String authors;
  final String language;
  final String categories;
  final String availablecopy;
  final String publishDate;
  final String description;
  final String schoolId;

  const BookDetailsPage({
    Key? key,
    required this.bookId,
    required this.bookTitle,
    required this.authors,
    required this.language,
    required this.categories,
    required this.availablecopy,
    required this.publishDate,
    required this.description,
    required this.schoolId,
  }) : super(key: key);

  @override
  _BookDetailsPageState createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  bool _isLoading = false; // To track loading state

  Future<void> borrowBook(BuildContext context) async {
    final url = 'http://localhost/omni-api/borrow.php'; // Replace with your server IP address

    setState(() {
      _isLoading = true; // Show loading indicator
    });

    print('Sending request to $url with:');
    print('student_id: ${widget.schoolId}');
    print('book_id: ${widget.bookId}');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "student_id": widget.schoolId, // Use widget values
          "book_id": widget.bookId,
          "status": "pending",
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        _showToastNotification(context, true, data['message']);
      } else {
        _showToastNotification(context, false, data['message'] ?? 'Request failed.');
      }
    } catch (error) {
      print('Error: $error');
      _showToastNotification(context, false, 'An error occurred.');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  void _showToastNotification(BuildContext context, bool success, String message) {
    final overlay = Overlay.of(context);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height / 2 - 50,
        left: MediaQuery.of(context).size.width / 2 - 125,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: success ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  success ? Icons.check_circle : Icons.error,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Book Details', style: TextStyle(fontSize: 16)),
        backgroundColor: Colors.grey[200],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF800000), size: 20),
          onPressed: () {
            Navigator.pop(context);
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
                Container(
                  width: 80,
                  height: 120,
                  color: const Color(0xFF800000),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.bookTitle,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.availablecopy} Copy Available',
                        style: const TextStyle(fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text('Info',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
            const SizedBox(height: 10),
            buildInfoRow('Title', widget.bookTitle),
            buildInfoRow('Authors', widget.authors),
            buildInfoRow('Categories', widget.categories),
            buildInfoRow('Publish Year', widget.publishDate),

            const Spacer(),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: const Color(0xFF800000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: _isLoading ? null : () => borrowBook(context), // Disable if loading
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white) // Show loading indicator
                    : const Text('Borrow Now', style: TextStyle(color: Colors.white)),
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
          Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}

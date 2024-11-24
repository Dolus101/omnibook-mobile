import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:omnibook/BookHistoryPage.dart';
import 'package:omnibook/allcategoriespage.dart';
import 'package:omnibook/CategoryBooksPage.dart';
import 'package:omnibook/booksdetailspage.dart';
import 'profile_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  static const Color primaryColor = Color(0xFF800000);
  static const Color backgroundColor = Color.fromARGB(255, 224, 228, 247);
  static const double headerHeight = 130;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> suggestedBooks = [];

  @override
  void initState() {
    super.initState();
    fetchSuggestedBooks(); // Fetch suggested books on init
  }

  Future<void> fetchSuggestedBooks() async {
    final url =
        'http://localhost/omni-api/getbook.php'; // Replace with your API URL
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> booksData = json.decode(response.body);
        print('Fetched Books: $booksData'); // Log the response to debug

        if (booksData.isNotEmpty) {
          setState(() {
            suggestedBooks = booksData; // Update state with fetched books
          });
        } else {
          print('No books available');
          setState(() {
            suggestedBooks = []; // Ensure the list is empty if no books
          });
        }
      } else {
        print('Failed to load books with status: ${response.statusCode}');
        throw Exception('Failed to load books');
      }
    } catch (error) {
      print('Error fetching books: $error');
      setState(() {
        suggestedBooks = []; // Ensure the list is empty in case of error
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 10),
                  _buildSearchField(context),
                  const SizedBox(height: 20),
                  _buildCategoriesSection(context),
                  const SizedBox(height: 20),
                  _buildRecentlyBorrowedSection(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: Dashboard.headerHeight,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/bg.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: Image.asset(
            'lib/images/logo.png',
            height: 55,
          ),
        ),
        const Positioned(
          top: 75,
          left: 25,
          child: Text(
            'OMNIBOOK',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              prefixIcon:
                  const Icon(Icons.search, size: 20, color: Color(0xFF800000)),
              hintText: 'Search..',
              hintStyle: const TextStyle(fontSize: 12),
              filled: true,
              fillColor: const Color.fromARGB(255, 255, 255, 255),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon:
              const Icon(Icons.filter_list, size: 20, color: Color(0xFF800000)),
          onPressed: () {
            _showFilterDialog(context);
          },
        ),
      ],
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Filter Categories',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 70, 70, 70),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    _buildFilterCategory(context, 'A.P.', Icons.school),
                    _buildFilterCategory(context, 'ABM', Icons.business_center),
                    _buildFilterCategory(
                        context, 'Accounting', Icons.account_balance),
                    // Add other filter categories as needed...
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterCategory(
      BuildContext context, String categoryName, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF800000)),
      title: Text(
        categoryName,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      onTap: () {
        Navigator.pop(context); // Close the dialog
      },
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildCategoryItem(context, 'A.P.', Icons.school),
              _buildCategoryItem(context, 'ABM', Icons.business_center),
              // Add more categories...
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(
      BuildContext context, String categoryName, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryBooksPage(category: categoryName)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: const Color(0xFF800000).withOpacity(0.1),
              child: Icon(icon, color: const Color(0xFF800000), size: 20),
            ),
            const SizedBox(height: 5),
            Text(
              categoryName,
              style: const TextStyle(
                color: Color.fromARGB(255, 32, 32, 32),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentlyBorrowedSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Suggested Books',
          style: TextStyle(
            color: Color.fromARGB(255, 32, 32, 32),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        suggestedBooks.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 250), // Constrain height
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: suggestedBooks.length,
                  itemBuilder: (context, index) {
                    final book = suggestedBooks[index];
                    return _buildBookItem(
                      context,
                      book['title'], // Assuming book data contains title
                      book['author'], // Assuming book data contains authorclear
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildBookItem(BuildContext context, String title, String author) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(
              bookTitle: title,
              authors: author,
              language: 'English',
              categories: 'General',
              publishDate: '2024',
              description: 'No description available',
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 15), // Add margin between items
        elevation: 5, // Add elevation for shadow effect
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(12), // Add padding inside the card
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book title with ellipsis for long text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16, // Slightly larger font size for better readability
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, // Limit to one line
                    ),
                    const SizedBox(height: 5),
                    // Author with ellipsis for long text
                    Text(
                      author,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1, // Limit to one line
                    ),
                  ],
                ),
              ),
              // You can add more elements here if needed, like a "Read More" button, etc.
            ],
          ),
        ),
      ),
    );
  }

Widget _buildBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
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
    );
  }
}

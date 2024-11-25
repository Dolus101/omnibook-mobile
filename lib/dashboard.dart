import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'booksdetailspage.dart';
import 'BookHistoryPage.dart';
import 'profile_page.dart';
import 'CategoryBooksPage.dart';

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
    fetchSuggestedBooks();
  }

  Future<void> fetchSuggestedBooks() async {
    const url = 'http://localhost/omni-api/getbook.php'; // Replace with your API URL
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> booksData = json.decode(response.body);
        setState(() {
          suggestedBooks = booksData.map((book) {
            return {
              'title': book['title'] ?? 'Untitled',
              'author': book['author'] ?? 'Unknown Author',
              'school_id': (book['school_id'] != null) ? book['school_id'].toString() : 'N/A',
              'id': (book['id'] != null) ? book['id'].toString() : 'N/A',
              'categories': book['categories'] ?? 'N/A',
              'availablecopy': (book['availablecopy'] != null) ? book['availablecopy'].toString() : '0',
            };
          }).toList();
        });
      } else {
        setState(() {
          suggestedBooks = [];
        });
        throw Exception('Failed to load books');
      }
    } catch (error) {
      setState(() {
        suggestedBooks = [];
      });
      print('Error fetching books: $error');
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
                boxShadow: const [BoxShadow(color: Colors.white, spreadRadius: 1)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 10),
                  _buildSearchField(context),
                  const SizedBox(height: 20),
                  _buildCategoriesSection(context),
                  const SizedBox(height: 20),
                  _buildRecentlyBorrowedSection(context),
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
              prefixIcon: const Icon(Icons.search, size: 20, color: Color(0xFF800000)),
              hintText: 'Search..',
              hintStyle: const TextStyle(fontSize: 12),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        IconButton(
          icon: const Icon(Icons.filter_list, size: 20, color: Color(0xFF800000)),
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
              ListView(
                shrinkWrap: true,
                children: [
                  _buildFilterCategory(context, 'A.P.', Icons.school),
                  _buildFilterCategory(context, 'ABM', Icons.business_center),
                  _buildFilterCategory(context, 'Accounting', Icons.account_balance),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterCategory(BuildContext context, String categoryName, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF800000)),
      title: Text(
        categoryName,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      ),
      onTap: () {
        Navigator.pop(context);
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryItem(BuildContext context, String categoryName, IconData icon) {
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
                constraints: const BoxConstraints(maxHeight: 250),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: suggestedBooks.length,
                  itemBuilder: (context, index) {
                    final book = suggestedBooks[index];
                    return _buildBookItem(
                      context,
                      book['title'],
                      book['author'],
                      book['categories'],
                      book['schoolid'],
                      book['id'],
                      book['availablecopy'],
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildBookItem(BuildContext context, String title, String author, String categories,
      String? schoolId, String? id, String availablecopy) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(
              bookTitle: title.isNotEmpty ? title : 'Untitled',
              authors: author.isNotEmpty ? author : 'Unknown Author',
              language: 'English',
              categories: categories.isNotEmpty ? categories : 'N/A',
              availablecopy: availablecopy.isNotEmpty ? availablecopy : '0',
              publishDate: '2024',
              description: "No description available",
              schoolId: schoolId ?? 'N/A',
              bookId: id ?? "N/A",
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.book, color: Colors.black),
          ),
          title: Text(
            title.isNotEmpty ? title : 'Untitled',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('by ${author.isNotEmpty ? author : 'Unknown Author'}'),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const Dashboard()));
            break;
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (_) => const BookHistoryPage()));
            break;
          case 2:
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
            break;
        }
      },
    );
  }
}

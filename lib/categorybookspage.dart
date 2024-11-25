import 'package:flutter/material.dart';
import 'package:omnibook/booksdetailspage.dart';

class CategoryBooksPage extends StatelessWidget {
  final String category;

  const CategoryBooksPage({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter books based on the selected category
    final List<Map<String, String>> filteredBooks =
        books.where((book) => book['categories'] == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category,
          style: const TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xFF800000),
            size: 18,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount:
              filteredBooks.length, // Use the length of the filtered books list
          itemBuilder: (context, index) {
            final book = filteredBooks[index];
            return _buildBookItem(
              context,
              book['title']!,
              book['author']!,
              book['language']!,
              book['categories']!,
              book['publishDate']!,
              book['description']!,
              book['schoolId']!,
              book['id']!,
              book['availablecopy']!
            );
          },
        ),
      ),
    );
  }

  Widget _buildBookItem(
    BuildContext context,
    String bookTitle,
    String authorName,
    String language,
    String categories,
    String publishDate,
    String description,
    String schoolId,
    String bookId,
    String availablecopy,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.book, color: Color(0xFF800000)),
        title: Text(
          bookTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(authorName),
        onTap: () {
          // Navigate to BookDetailsPage for the clicked book
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailsPage(
                bookTitle: bookTitle,
                authors: authorName,
                language: language,
                categories: categories,
                publishDate: publishDate,
                description: description,
                schoolId: schoolId, // Pass schoolId here
                bookId: bookId,
                availablecopy: availablecopy, // Pass bookId
              ),
            ),
          );
        },
      ),
    );
  }
}

/// Example book data with different categories and counts
final List<Map<String, String>> books = [
  ...List.generate(50, (i) {
    return {
      'title': 'A.P. Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'A.P.',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of A.P. Book ${i + 1}.',
    };
  }),

  // Books for 'ABM' category (30 books)
  ...List.generate(30, (i) {
    return {
      'title': 'ABM Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'ABM',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of ABM Book ${i + 1}.',
    };
  }),

  // Books for 'Accounting' category (45 books)
  ...List.generate(45, (i) {
    return {
      'title': 'Accounting Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Accounting',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(25, (i) {
    return {
      'title': 'Arts Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Arts',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(20, (i) {
    return {
      'title': 'Business Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Business',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(15, (i) {
    return {
      'title': 'Caregiving Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Caregiving',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(10, (i) {
    return {
      'title': 'Computer Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Computer',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(40, (i) {
    return {
      'title': 'Accounting Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Constitution',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(12, (i) {
    return {
      'title': 'Criminology Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Criminology',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(18, (i) {
    return {
      'title': 'Dictionary Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Dictionary',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Economics Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Economics',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(45, (i) {
    return {
      'title': 'Education Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Education',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(54, (i) {
    return {
      'title': 'ESP Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'ESP',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(65, (i) {
    return {
      'title': 'Fiction Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Fiction',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Filipiniana Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Filipiniana',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(65, (i) {
    return {
      'title': 'Filipino Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Filipino',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'General References Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'General References',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(65, (i) {
    return {
      'title': 'History Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'History',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(35, (i) {
    return {
      'title': 'HRM Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'HRM',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(45, (i) {
    return {
      'title': 'Mathematics Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Mathematics',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(54, (i) {
    return {
      'title': 'Language Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Language',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(75, (i) {
    return {
      'title': 'Law Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Law',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(36, (i) {
    return {
      'title': 'LET Reviewer Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'LET Reviewer',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(56, (i) {
    return {
      'title': 'Literature Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Literature',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(65, (i) {
    return {
      'title': 'MAED Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'MAED',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'MAED Management Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'MAED Management',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(54, (i) {
    return {
      'title': 'Management Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Management',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(76, (i) {
    return {
      'title': 'MAPEH Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'MAPEH',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Marketing Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Marketing',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(56, (i) {
    return {
      'title': 'Masscom Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Masscom',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(44, (i) {
    return {
      'title': 'Mathematics Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Mathematics',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(23, (i) {
    return {
      'title': 'P.E.C. Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'P.E.C.',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(76, (i) {
    return {
      'title': 'Philosophy Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Philosophy',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(45, (i) {
    return {
      'title': 'Physical Education Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Physical Education',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(87, (i) {
    return {
      'title': 'Phyton Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Phyton',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(23, (i) {
    return {
      'title': 'Political Science Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Political Science',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(54, (i) {
    return {
      'title': 'Pre-School Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Pre-School',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Professional Reference Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Professional Reference',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(45, (i) {
    return {
      'title': 'Psychology Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Psychology',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(54, (i) {
    return {
      'title': 'Religion Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Religion',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Research Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Research',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(65, (i) {
    return {
      'title': 'Reserve Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Economics',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Science Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Science',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(45, (i) {
    return {
      'title': 'Sociology Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Sociology',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(23, (i) {
    return {
      'title': 'Statistic Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Statistic',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(75, (i) {
    return {
      'title': 'Subject Reference Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Subject Reference',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Taxation Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Taxation',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(65, (i) {
    return {
      'title': 'Tech Voc Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Tech Voc',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(24, (i) {
    return {
      'title': 'Subject Reference Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Subject Reference',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(64, (i) {
    return {
      'title': 'TLE Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'TLE',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(34, (i) {
    return {
      'title': 'Tourism Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Tourism',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  ...List.generate(40, (i) {
    return {
      'title': 'Values Book ${i + 1}',
      'author': 'Author Name ${i + 1}',
      'language': 'English',
      'categories': 'Values',
      'publishDate': '2023-01-01',
      'description': 'A detailed description of Accounting Book ${i + 1}.',
    };
  }),
  // You can continue adding more categories and books here
];

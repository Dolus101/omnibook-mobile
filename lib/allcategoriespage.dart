import 'package:flutter/material.dart';
import 'categorybookspage.dart'; // Ensure to import the CategoryBooksPage

class AllCategoriesPage extends StatelessWidget {
  AllCategoriesPage({Key? key}) : super(key: key);

  final List<Map<String, dynamic>> categories = [
    {'name': 'A.P.',
     'count': 50,
      'icon': Icons.school},
    {'name': 'ABM', 
    'count': 30, 
    'icon': Icons.business_center},
    {'name': 'Accounting',
     'count': 45, 
     'icon': Icons.account_balance},
     {'name': 'Arts',
     'count': 25,
     'icon': Icons.palette,},
     {
      'name': 'Business',
      'count': 20,
      'icon': Icons.business,
    },
    {
      'name': 'Caregiving',
      'count': 15,
      'icon': Icons.health_and_safety,
    },
    {
      'name': 'Computer',
      'count': 10,
      'icon': Icons.computer,
    },
    {
      'name': 'Constitution',
      'count': 40,
      'icon': Icons.book,
    },
    {
      'name': 'Criminology',
      'count': 12,
      'icon': Icons.security,
    },
    {
      'name': 'Dictionary',
      'count': 18,
      'icon': Icons.menu_book,
    },
    {
      'name': 'Economics',
      'count': 34,
      'icon': Icons.attach_money,
    },
     {
      'name': 'Education',
      'count': 45,
      'icon': Icons.school,
    },
     {
      'name': 'ESP',
      'count': 54,
      'icon': Icons.psychology,
    },
     {
      'name': 'Fiction',
      'count': 65,
      'icon': Icons.menu_book,
    },
    {
      'name': 'Filipiniana',
      'count': 34,
      'icon': Icons.flag,
    },
    {
      'name': 'Filipino',
      'count': 65,
      'icon': Icons.language,
    },
    {
      'name': 'General References',
      'count': 34,
      'icon': Icons.library_books,
    },
    {
      'name': 'History',
      'count': 65,
      'icon': Icons.history,
    },
    {
      'name': 'HRM',
      'count': 35,
      'icon': Icons.people,
    },
    {
      'name': 'Mathematics',
      'count': 45,
      'icon': Icons.calculate,
    },
    {
      'name': 'Language',
      'count': 54,
      'icon': Icons.language,
    },
    {
      'name': 'Law',
      'count': 75,
      'icon': Icons.gavel,
    },
    {
      'name': 'LET Reviewer',
      'count': 36,
      'icon': Icons.rate_review,
    },
    {
      'name': 'Literature',
      'count': 56,
      'icon': Icons.menu_book,
    },
    {
      'name': 'MAED',
      'count': 65,
      'icon': Icons.school,
    },
     {
      'name': 'MAED Management',
      'count': 34,
      'icon': Icons.business_center,
    },
     {
      'name': 'Management',
      'count': 54,
      'icon': Icons.business_center,
    },
     {
      'name': 'MAPEH',
      'count': 76,
      'icon': Icons.music_note,
    },
     {
      'name': 'Marketing',
      'count': 34,
      'icon': Icons.mark_email_read,
    },
     {
      'name': 'Masscom',
      'count': 56,
      'icon': Icons.mic,
    },
     {
      'name': 'Mathematics',
      'count': 44,
      'icon': Icons.calculate,
    },
     {
      'name': 'P.E.C.',
      'count': 23,
      'icon': Icons.sports,
    },
    {
      'name': 'Philosophy',
      'count': 76,
      'icon': Icons.lightbulb,
    },
     {
      'name': 'Physical Education',
      'count': 45,
      'icon': Icons.sports_handball,
    },
    
     {
      'name': 'Phyton',
      'count': 87,
      'icon': Icons.code,
    },
    
     {
      'name': 'Political Science',
      'count': 23,
      'icon': Icons.how_to_vote,
    },
    
     {
      'name': 'Pre-School',
      'count': 54,
      'icon': Icons.lightbulb,
    },
    
     {
      'name': 'Professional Reference',
      'count': 34,
      'icon': Icons.work,
    },
     {
      'name': 'Psychology',
      'count': 45,
      'icon': Icons.psychology,
    },
    
     {
      'name': 'Religion',
      'count': 54,
      'icon': Icons.church,
    },
    
     {
      'name': 'Research',
      'count': 34,
      'icon': Icons.science,
    },
     {
      'name': 'Reserve',
      'count': 65,
      'icon': Icons.bookmark,
    },
     {
      'name': 'Science',
      'count': 34,
      'icon': Icons.science,
    },
     {
      'name': 'Sociology',
      'count': 45,
      'icon': Icons.groups,
    },
     {
      'name': 'Statistic',
      'count': 23,
      'icon': Icons.bar_chart,
    },
     {
      'name': 'Subject Reference',
      'count': 75,
      'icon': Icons.book,
    },
    {
      'name': 'Taxation',
      'count': 34,
      'icon': Icons.receipt,
    },
    {
      'name': 'Tech Voc',
      'count': 65,
      'icon': Icons.build,
    },
    {
      'name': 'Subject Reference',
      'count': 24,
      'icon': Icons.book,
    },{

      'name': 'TLE',
      'count': 64,
      'icon': Icons.handyman,
    },
    {
      'name': 'Tourism',
      'count': 34,
      'icon': Icons.travel_explore,
    },
    {
      'name': 'Values',
      'count': 40,
      'icon': Icons.volunteer_activism,
    }
    // Add the remaining categories with their counts and icons
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Main Categories',
          style: TextStyle(fontSize: 18), // Make the text smaller
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Color(0xFF800000),
            // Make the icon smaller
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 20, // Reduced radius for smaller circle
                backgroundColor: const Color(0xFF800000).withOpacity(0.1),
                child: Icon(category['icon'], color: const Color(0xFF800000), size: 20), // Reduced icon size
              ),
              title: Text('${category['name']} (${category['count']})'),
              onTap: () {
                // Navigate to the CategoryBooksPage with the selected category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryBooksPage(category: category['name']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

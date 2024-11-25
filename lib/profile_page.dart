import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omnibook/dashboard.dart'; // Import your dashboard page here
import 'package:omnibook/login.dart'; // Import your login page here

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = 'Dizon';
  String username = 'Dizon'; // Default username
  String description = 'Student'; // Default description
  String imagePath = ''; // Initialize as empty to use the default image

  // Function to pick an image
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imagePath = image.path;
      });
    }
  }

  // Function to update the profile
  void _updateProfile(String newName, String newDescription) {
    setState(() {
      name = newName;
      description = newDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildAppBar(context),
              const SizedBox(height: 20),
              _buildProfileImage(),
              const SizedBox(height: 20),
              _buildProfileName(),
              const SizedBox(height: 20),
              const Divider(color: Colors.grey),
              const SizedBox(height: 20),
              _buildPersonalInfoSection(),
              const Spacer(),
              _buildLogoutButton(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the custom AppBar for the profile page
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF800000), size: 20),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              );
            },
          ),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 37, 37, 37),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, color: Color(0xFF800000)),
            onPressed: () {
              _showEditDialog(context);
            },
          ),
        ],
      ),
    );
  }

  // Builds the profile image section
  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: _pickImage, // Trigger image picker when tapped
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade300,
        backgroundImage: imagePath.isNotEmpty
            ? FileImage(File(imagePath)) // Display picked image
            : const AssetImage('lib/images/profile.png') as ImageProvider, // Default image
        child: imagePath.isEmpty
            ? const Icon(Icons.person, size: 50, color: Color(0xFF800000))
            : null,
      ),
    );
  }

  // Builds the profile name section
  Widget _buildProfileName() {
    return Column(
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // Builds the personal information section
  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Center(
          child: Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildInfoRow('Name:', name),
        _buildInfoRow('Username:', username),
        _buildInfoRow('Usertype:', 'Student'), // Example usertype, change as needed
        _buildInfoRow('Department:', 'CCS'), // Example department, change as needed
      ],
    );
  }

  // Builds a row for personal information
  static Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 32, 32, 32),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 29, 29, 29),
            ),
          ),
        ],
      ),
    );
  }

  // Builds the logout button
  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(title: 'OMNIBOOK'),
            ),
            (Route<dynamic> route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: const Color(0xFF800000),
          padding: const EdgeInsets.symmetric(vertical: 20),
        ),
        child: const Text(
          'Logout',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  // Shows the edit profile dialog
  void _showEditDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: name);
    final TextEditingController descriptionController = TextEditingController(text: description);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          imagePath = image.path;
                        });
                        Navigator.of(context).pop(); // Close the dialog
                        _showEditDialog(context); // Reopen the dialog
                      }
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: imagePath.isNotEmpty
                          ? FileImage(File(imagePath))
                          : const AssetImage('lib/images/profile.png') as ImageProvider,
                      child: imagePath.isEmpty
                          ? const Icon(Icons.person, size: 40, color: Color(0xFF800000))
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateProfile(nameController.text, descriptionController.text);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
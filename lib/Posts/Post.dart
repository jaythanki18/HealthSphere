import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'post_data.dart'; // Import the doctorPosts list from post_data.dart
import 'dart:ui';

class DoctorPost extends StatefulWidget {
  final String profilePicUrl;
  final String username;
  final String postImageUrl;
  final String description;

  const DoctorPost({
    Key? key,
    required this.profilePicUrl,
    required this.username,
    required this.postImageUrl,
    required this.description,
  }) : super(key: key);

  @override
  _DoctorPostState createState() => _DoctorPostState();
}

class _DoctorPostState extends State<DoctorPost> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile pic and username
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.profilePicUrl),
                  radius: 20,
                ),
                SizedBox(width: 8.0),
                Text(
                  widget.username,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          // Post image
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.network(
              widget.postImageUrl,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
          ),
          // Description
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isExpanded
                      ? widget.description
                      : '${widget.description.substring(0, 100)}...',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
                if (widget.description.length > 100)
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'Read Less' : 'Read More',
                      style: GoogleFonts.poppins(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

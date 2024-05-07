import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'package:sgp_project_6/APIs/Posts/createPostAPI.dart';
import 'package:sgp_project_6/Models/Posts/CreatePostModel.dart';
import 'package:sgp_project_6/Posts/PostScreen.dart';
import 'package:sgp_project_6/Posts/post_data.dart';
import 'dart:io'; // Import IO to use File
import 'dart:ui';

import 'post.dart';


class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  File? _imageFile; // Variable to hold the selected image file
  final formKey = GlobalKey<FormState>();
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: _getImage, // Open image picker
                  child: Text('Pick Image'),
                ),
                SizedBox(height: 16.0),
                _imageFile == null
                    ? Text('No image selected.')
                    : Image.file(_imageFile!), // Display selected image
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                 // maxLines: null,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  maxLines: null,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async{
                    CreatePostModel data = await CreatePostAPI().createPost(widget.token, _titleController.text, _descriptionController.text, _imageFile!);
                    print(data);
                    if (formKey.currentState!.validate() && data!=null && data.message=="Post created successfully") {
                      var snackBar = SnackBar(
                        content: Text(data.message!),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      // final newPost = DoctorPost(
                      //   profilePicUrl: '', // No profile pic for now
                      //   username: '', // No username for now
                      //   postImageUrl:
                      //   '', // Will be set after uploading to server
                      //   description: _descriptionController.text,
                      // );
                      //
                      // doctorPosts
                      //     .add(newPost); // Add new post to doctorPosts list
                      //
                      // // Clear input fields after adding the post
                      // _descriptionController.clear();
                      //
                      // // Navigate back to previous page
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>PostScreen(token: widget.token)));
                    } else {
                      // Show snackbar if no image is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(data.message!)),
                      );
                    }
                  },
                  child: Text('Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

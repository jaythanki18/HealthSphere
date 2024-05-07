
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgp_project_6/APIs/Posts/commentAddAPI.dart';
import 'package:sgp_project_6/APIs/Posts/showPostsAPI.dart';
import 'package:sgp_project_6/Models/Posts/CommentAddModel.dart';

import '../APIs/Posts/showCommentsAPI.dart';
import '../Models/Posts/CommentShowModel.dart';
import '../Models/Posts/ShowPostsModel.dart';
import 'create_post.dart';
class PostScreen extends StatefulWidget {
  const PostScreen({Key? key, required this.token}) : super(key: key);
  final String token;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  bool isExpanded = false;
  List<String> comments = ["abcd", "xyzw","pqrs","lmno","rstv"];
  TextEditingController _comments = TextEditingController();
  String strComment = "";
  @override
  Widget build(BuildContext context) {
    Future<CommentShowModel> fetchComments(String postId) async {
      return await ShowCommentsAPI().showComments(postId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text('Posts',style: GoogleFonts.montserrat(color:Colors.grey.shade900,fontSize: 20,fontWeight:FontWeight.bold),),

      ),
      body: FutureBuilder<ShowPostsModel>(
        future: ShowPostsAPI().showPosts(widget.token),
        builder: (BuildContext context, AsyncSnapshot<ShowPostsModel> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.posts == null) {
            return Text('No data available');
          } else {
            final posts = snapshot.data!.posts!;
            print('Posts length: ${posts.length}');
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:  EdgeInsets.only(left: 8,right: 8),
                  child: Container(
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
                    child: Padding(
                      padding:  EdgeInsets.only(left: 10,right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  child: Image.network(
                                    snapshot.data!.posts![index].user!.userPhoto.toString(),
                                    fit: BoxFit.cover,
                                    width: 40,
                                    height: 40,
                                    errorBuilder: (context,error,stackTrace)=>Container(child: Image.asset('assets/posts_user_image.jpg'),),
                                  ),
                                  radius: 20,
                                ),
                                SizedBox(width: 12.0),
                                Text(
                                  snapshot.data!.posts![index].user!.fullName.toString(),
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                    color: Color.fromRGBO(62, 86, 115, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              snapshot.data!.posts![index].title.toString(),
                              style: GoogleFonts.poppins(
                               fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(snapshot.data!.posts![index].image.toString(),
                              width: double.infinity,
                              height: 200.0,
                              fit: BoxFit.cover,
                              errorBuilder: (context,error,stackTrace)=>Container(child: Image.network('https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isExpanded
                                      ? snapshot.data!.posts![index].description.toString()
                                      : '${snapshot.data!.posts![index].description.toString().substring(0, 60)}...',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    color: Colors.black87,
                                  ),
                                ),
                                if (snapshot.data!.posts![index].description!.length > 60)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isExpanded = !isExpanded;
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          isExpanded ? 'Read Less' : 'Read More',
                                          style: GoogleFonts.poppins(
                                            color: Colors.grey.shade900,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(onPressed: (){
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return Container(
                                                color: Colors.white,
                                                padding: EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    // Comments list
                                                    Text(
                                                      "Comments",
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 18.0,
                                                        color: Color.fromRGBO(45, 87, 152, 1.0)
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    // ListView of comments
                                                    Expanded(
                                                      child: FutureBuilder<CommentShowModel>(
                                                        future: fetchComments(posts[index].id.toString()),
                                                        builder: (BuildContext context, AsyncSnapshot<CommentShowModel> commentSnapshot) {
                                                          if (commentSnapshot.connectionState == ConnectionState.waiting) {
                                                            return Center(child: CircularProgressIndicator());
                                                          } else if (commentSnapshot.hasError) {
                                                            return Text('Error: ${commentSnapshot.error}');
                                                          } else if (!commentSnapshot.hasData || commentSnapshot.data!.comments == null) {
                                                            return Text('No comments available');
                                                          } else {
                                                            final comments = commentSnapshot.data!.comments!;
                                                            return  ListView.builder(
                                                              shrinkWrap: true,
                                                              physics: NeverScrollableScrollPhysics(),
                                                              itemCount: comments.length,
                                                              itemBuilder: (context, comIndex) {
                                                                return ListTile(
                                                                  leading: CircleAvatar(
                                                                    radius: 30,
                                                                    child: Image.network(
                                                                      commentSnapshot.data!.comments![comIndex].pharmacist!.pharmacistPhoto.toString(),
                                                                      errorBuilder: (context,error,stackTrace)=>Image.asset('assets/posts_user_image.jpg',),
                                                                  ),),
                                                                  title: SizedBox(child: Text(comments[comIndex].pharmacist!.fullName.toString() ?? "",overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.roboto(fontSize:13,color:Colors.black87,fontWeight:FontWeight.bold),)),
                                                                  subtitle: SizedBox(width: double.infinity,child: Text(comments[comIndex].description ?? "",overflow: TextOverflow.ellipsis,maxLines: 2,style: GoogleFonts.poppins(fontSize: 13.5,color: Colors.black),)),
                                                                  // Additional properties and styling for each comment
                                                                );
                                                              },
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(height: 20.0),
                                                    // Text field for adding a comment
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextFormField(
                                                            onChanged: (value) {
                                                              strComment = value;
                                                              setState(() {});
                                                            },
                                                            controller: _comments,
                                                            keyboardType: TextInputType.text,
                                                            validator: (value) {},
                                                            decoration: InputDecoration(
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(15.0),
                                                                borderSide: BorderSide.none,
                                                              ),
                                                              hintText: "Add a comment..",
                                                              hintStyle: GoogleFonts.poppins(
                                                                textStyle: TextStyle(
                                                                    color: Color.fromRGBO(45, 87, 152, 1.0),
                                                                    fontSize: 15,
                                                                    fontWeight: FontWeight.bold),
                                                              ),
                                                              filled: true,
                                                              fillColor: Colors.grey[200],
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(width: 20.0),
                                                        IconButton(
                                                          onPressed: () async{
                                                            CommentAddModel data = await CommentAddAPI().addComment(widget.token,posts[index].id.toString(), _comments.text);
                                                            if(_comments.text!=null && data.message=="Comment created successfully"){
                                                              setState(() {
                                                                fetchComments(posts[index].id.toString());
                                                              });
                                                              var snackBar = SnackBar(
                                                                content: Text(data.message!),
                                                              );
                                                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                                            }
                                                            _comments.clear();
                                                          },
                                                          icon:  Icon(Icons.send,color: Color.fromRGBO(45, 87, 152, 1.0),),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            backgroundColor: Colors.white
                                          );

                                        }, icon: Icon(Icons.comment_outlined,color:Colors.grey.shade900))
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

              },
            );
          }
        },
      ),

        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostPage(token: widget.token,)),
          );
        },
        child: Icon(Icons.add,color: Colors.white,),
          backgroundColor:Colors.grey.shade900
      ),
    );
  }
}
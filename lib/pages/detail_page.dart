import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/model/pref_model.dart';
import 'package:herewego/services/rtdb_services.dart';
import 'package:image_picker/image_picker.dart';

import '../services/store_service.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const String id = 'DetailPage';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
      File? _image;
      final picker = ImagePicker();
      bool isLoading = false;

  var titleController = TextEditingController();
  var contentController = TextEditingController();
      _addPost() async {
        String title = titleController.text.toString();
        String content = contentController.text.toString();
        if (title.isEmpty || content.isEmpty) return;
        if(_image == null) return;

        _apiUploadImage(title,content);
      }

      void _apiUploadImage(String title, String content) {
        setState(() {
          isLoading = true;
        });
        StoreService.uploadImage(_image!).then((img_url) => {
          _apiAddPost(title, content, img_url),
        });
      }

      _apiAddPost(String title, String content,String img_url) async {
        var id = await Prefs.loadUserId();
        RTDBService.addPost(new Post(id!, title, content,img_url)).then((response) => {
          _respAddPost(),
        });
      }

      _respAddPost() {
        setState(() {
        //  isLoading = false;
        });
        Navigator.of(context).pop({'data': 'done'});
      }

      Future _getImage() async {
        final pickedFile = await picker.pickImage(source: ImageSource.gallery);

        setState(() {
          if (pickedFile != null) {
            _image = File(pickedFile.path);
          } else {
            print('No image selected.');
          }
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Add Post"),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _getImage,
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: _image != null ?
                      Image.file(_image!,fit: BoxFit.cover) :
                      Image.asset("assets/images/image.png"),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Title",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      hintText: "Content ",
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: _addPost,
                      child: Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          isLoading? Center(
            child: CircularProgressIndicator(),
          ): SizedBox.shrink(),
        ],
      ),
    );

  }
}

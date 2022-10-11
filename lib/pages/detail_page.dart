import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:herewego/model/pref_model.dart';
import 'package:herewego/services/rtdb_services.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);
  static const String id = 'DetailPage';

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();

  _addPost() async {
    String title = titleController.text.toString();
    String content = contentController.text.toString();
    if (title.isEmpty || content.isEmpty) return;
    _apiAddPost(title, content);
  }

  _apiAddPost(String title, String content) async {
    var id = await Prefs.loadUserId();
    RTDBService.addPost(Post(id!, title, content)).then((value) => {
      _respAddPost(),
    });
  }

  _respAddPost() {
    Navigator.of(context).pop({'data': 'done'});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),

      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: titleController ,
              decoration: InputDecoration(
                hintText: 'title'
              ),
            ),
            SizedBox(height: 15,),
            TextField(controller: contentController,
              decoration: const InputDecoration(
                hintText: 'content'
              ),
            ),
          /*  const SizedBox(height: 15,),
            TextField(controller: contentController,
              decoration: const InputDecoration(
                  hintText: 'Content'
              ),
            ),
            const SizedBox(height: 15,),
            TextField(controller: dataController,
              decoration: const InputDecoration(
                  hintText: 'Date'
              ),
            ),*/
            SizedBox(height: 15,),
            Container(
              height: 45,
              width: double.infinity,
              color: Colors.blue,
              child: ElevatedButton(
                onPressed: (){
                  _addPost();
                },
                child: Text('Add'),
              ),
            )
          ],
        ),
      ),
    );

  }
}

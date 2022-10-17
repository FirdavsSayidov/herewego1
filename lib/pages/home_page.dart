import 'package:flutter/material.dart';
import 'package:herewego/model/pref_model.dart';
import 'package:herewego/pages/detail_page.dart';
import 'package:herewego/pages/signIn_page.dart';
import 'package:herewego/services/rtdb_services.dart';

import '../model/post_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String id = 'HomePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;
  List<Post> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

      _apiGetPosts();
  }

  Future _openDetail() async{
    Map results = await Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context){
          return  const DetailPage();
        }
    ));
    if(results != null && results.containsKey("data")){
      print(results['data']);
      _apiGetPosts();
    }
  }

  _apiGetPosts() async{
    setState(() {
      isLoading = true;
    });
    var id = await Prefs.loadUserId();
    RTDBService.getAllPosts(id!).then((posts) => {
      print(posts),
      _respPosts(posts),
    });
  }

  _respPosts(List<Post>? posts) {
    setState(() {
      isLoading = false;
      items = posts!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: const Text('All Posts'),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushReplacementNamed(context, SignInPage.id);

          }, icon: Icon(Icons.exit_to_app_outlined))
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (ctx,i){
          return itemOfList(items[i]);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
       _openDetail();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  Widget itemOfList(Post post){
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [

          Container(
            height: 70,
            width: 70,
            child: post.image != null ?
            Image.network(post.image,fit: BoxFit.cover,):
            Image.asset("assets/images/ic_default.png"),
          ),
          SizedBox(width: 15,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.title,style: const TextStyle(color: Colors.black,fontSize: 20),),
              SizedBox(height: 10,),
              Text(post.content,style: const TextStyle(color: Colors.black,fontSize: 16),),
            ],
          ),
        ],
      ),
    );
  }}

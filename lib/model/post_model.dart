class Post {
  String userId;
  String title;
  String content;
  String image;


  Post( this.userId,this.title,this.content,this.image);

  Post.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        title = json['title'],
        content = json['content'],
        image = json['image'];

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'title': title,
    'content': content,
    'image' : image
  };
}
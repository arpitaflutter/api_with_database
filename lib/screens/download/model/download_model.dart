class DownNewsModel
{
  String? name,author,title,description,content,image;
  int? id;

  DownNewsModel(
      {this.name,
      this.author,
      this.title,
      this.description,
      this.content,
      this.image,
      this.id});

  DownNewsModel fromJson(Map m1)
  {
    id = m1['id'];
    name = m1['name'];
    title = m1['title'];
    image = m1['image'];
    description = m1['description'];
    content = m1['content'];
    author = m1['author'];

    DownNewsModel d1 = DownNewsModel(title: title,name: name,content: content,image: image,author: author,description: description,id: id);
    return d1;

  }
}
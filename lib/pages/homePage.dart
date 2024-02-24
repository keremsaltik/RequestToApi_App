import 'package:flutter/material.dart';
import 'package:servicerequestapp/pages/details.dart';
import 'package:servicerequestapp/service/post_model.dart';
import 'package:servicerequestapp/service/post_service.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  List<PostModel>? _items;

  late final IPostService PostService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PostService = postService();
    fetchPost();
  }

  Future<void> fetchPost() async {
    setState(() {});
    _items = await PostService.getItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Explore All Products',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 1, left: 1),
        child: GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: _items?.length ?? 0,
            itemBuilder: (context, index) {
              return _postCart(
                model: _items?[index],
              );
            }),
      ),
    );
  }
}

class _postCart extends StatelessWidget {
  const _postCart({
    super.key,
    required PostModel? model,
  }) : _model = model;

  final PostModel? _model;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) => ProductDetail(id: _model?.id))));
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          children: [
            Image(
              image: NetworkImage(_model?.image ?? ''),
              fit: BoxFit.fill,
              height: 175,
            ),
            Text(
              _model?.title ?? '',
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    ));
  }
}

/*ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: ((context) => ProductDetail(id: _model?.id))));
        },
        title: Text(_model?.title ?? ''),
        //subtitle: Text(_model?.description ?? ''),
        trailing: Image(
          image: NetworkImage(_model?.image ?? ''),
        ),
        style: ListTileTheme.of(context).style,
      ),*/
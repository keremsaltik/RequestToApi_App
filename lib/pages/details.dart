import 'package:flutter/material.dart';
import 'package:servicerequestapp/service/post_model.dart';
import 'package:servicerequestapp/service/post_service.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.id});
  final int? id;
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<PostModel>? _commentitem;
  late final IPostService service;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    service = postService();
    getItemWithID(widget.id ?? 0);
  }

  Future<void> getItemWithID(int id) async {
    setState(() {});
    _commentitem = await service.getItemWithID(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
          itemCount: _commentitem?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 400,
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage(_commentitem?[index].image ?? ''),
                      width: 200,
                      height: 200,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      _commentitem?[index].title ?? '',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Description',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    Text(
                      _commentitem?[index].description ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

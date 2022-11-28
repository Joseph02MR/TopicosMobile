import 'package:ecommerce_int2/models/new/category2.dart';
import 'package:ecommerce_int2/services/remote_service.dart';
import 'package:flutter/material.dart';

class HomeDummy extends StatefulWidget {
  const HomeDummy({Key? key}) : super(key: key);

  @override
  _HomeDummyState createState() => _HomeDummyState();
}

class _HomeDummyState extends State<HomeDummy> {
  List<Category2>? categories;
  var isLoaded = false;

  @override
  void initState(){
    super.initState();
      getData();
  }

  getData() async {
    categories = await RemoteService().getCategories();
    if(categories != null){
      setState(() {
        isLoaded = true;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('categories'),
      ),
      body: Visibility(
        visible: isLoaded,
        child: ListView.builder(
          itemCount: categories?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          categories![index].name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],                    ),
                  ),
                ],
              ),
            );
          },
        ),
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
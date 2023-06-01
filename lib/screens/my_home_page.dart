import 'dart:convert';

import 'package:ebook/widget/my_tab.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  ScrollController? _scrollController;
  TabController? _tabController;
  List? popularBooks;
  List? books;
  readData() async {
    final assetBundle = DefaultAssetBundle.of(context);

    final popularBooksData =
        await assetBundle.loadString("json/popularBooks.json");
    setState(() {
      popularBooks = json.decode(popularBooksData);
    });

    final booksData = await assetBundle.loadString("json/books.json");
    setState(() {
      books = json.decode(booksData);
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 255, 254, 254),
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                child: Text(
                  'Popular Books',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 180,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      left: -160,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        height: 180,
                        width: double.infinity,
                        child: PageView.builder(
                            controller: PageController(viewportFraction: .4),
                            itemCount:
                                popularBooks == null ? 0 : popularBooks!.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 180,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: AssetImage(
                                          popularBooks![index]["img"]),
                                      fit: BoxFit.contain),
                                ),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        pinned: true,
                        bottom: PreferredSize(
                          preferredSize: const Size.fromHeight(50),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20, left: 15),
                            child: TabBar(
                                tabs: const [
                                  MyTabs(color: Colors.white, text: "New"),
                                  MyTabs(color: Colors.white, text: "Popular"),
                                  MyTabs(color: Colors.white, text: "Trending")
                                ],
                                labelPadding: const EdgeInsets.only(right: 15),
                                controller: _tabController,
                                indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                indicatorPadding: const EdgeInsets.all(8),
                                isScrollable: true),
                          ),
                        ),
                      )
                    ];
                  },
                  body: TabBarView(controller: _tabController, children: [
                    ListView.builder(
                        itemCount: books == null ? 0 : books!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 2,
                                        offset: const Offset(0, 0),
                                        color: Colors.grey.withOpacity(0.2)),
                                  ]),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 120,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  books![index]['img']))),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Color.fromARGB(
                                                  255, 231, 156, 57),
                                              size: 24,
                                            ),
                                            Text(books![index]['rating'])
                                          ],
                                        ),
                                        Text(
                                          books![index]['title'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          books![index]['text'],
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                    Material(),
                    Material(),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

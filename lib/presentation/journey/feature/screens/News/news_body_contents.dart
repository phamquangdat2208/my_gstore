import 'package:flutter/material.dart';

import 'detailed_news.dart';

class NewsBody extends StatefulWidget {
  const NewsBody({Key? key}) : super(key: key);

  @override
  _NewsBodyState createState() => _NewsBodyState();
}

class _NewsBodyState extends State<NewsBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: double.infinity,
      child: ListView.builder(
        itemBuilder: (_, index) => ItemCard(food: listfood[index]),
        itemCount: listfood.length,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Food food;

  const ItemCard({Key? key, required this.food}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DetailedNews(food: food)));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 1 / 3,
                  child: Image.asset(food.image),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        food.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 10),
                          width: MediaQuery.of(context).size.width * 1 / 2 + 10,
                          child: Text(
                            food.description,
                            textAlign: TextAlign.left,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Food {
  late String image, title, description;
  Food(String imagee, String titlee, String descriptionn) {
    image = imagee;
    title = titlee;
    description = descriptionn;
  }
}

List<Food> listfood = [
  Food('assets/images/News/1.png', 'Card title name1',
      'Lorem Ipsum is simply dummy text of the printing and typesetting. LoremIpsum has been the industry'),
  Food('assets/images/News/2.png', 'Card title name2',
      'Lorem Ipsum is simply dummy text of the printing and typesetting. LoremIpsum has been the industry'),
  Food('assets/images/News/3.png', 'Card title name3',
      'Lorem Ipsum is simply dummy text of the printing and typesetting. LoremIpsum has been the industry'),
  Food('assets/images/News/4.png', 'Card title name4',
      'Lorem Ipsum is simply dummy text of the printing and typesetting. LoremIpsum has been the industry'),
  Food('assets/images/News/5.png', 'Card title name5',
      'Lorem Ipsum is simply dummy text of the printing and typesetting. LoremIpsum has been the industry'),
];

import 'package:darularqam/models/BookModel.dart';
import 'package:flutter/material.dart';

class BookListBuilder extends StatelessWidget {
  const BookListBuilder({
    Key key,
    @required this.books,
  }) : super(key: key);

  final List<BookModel> books;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.book),
                  iconSize: 100,
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.pushNamed(context, '/givenBookLessonsScreen',
                        arguments: books[index]);
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Text(
                                books[index].bookName ?? 'unknown',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(books[index].sheekhInfo.sheekhName),
                            Text(
                              books[index].lessonCount.toString() + ' duruus',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.share)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

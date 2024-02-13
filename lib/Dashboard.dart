import 'package:flutter/material.dart';
class Dashboard extends StatelessWidget {
  Dashboard({Key? key}) : super(key: key);
  final List listImages = [
    'https://miro.medium.com/max/1400/1*-6WdIcd88w3pfphHOYln3Q.png',
    'https://cdn.pixabay.com/photo/2022/03/27/11/23/cat-7094808__340.jpg',
    'https://static.scientificamerican.com/sciam/cache/file/5C51E427-1715-44E6-9B14D9487D7B7F2D_source.jpg',
    'https://images.pexels.com/photos/60597/dahlia-red-blossom-bloom-60597.jpeg',
  ];
  //const Page1({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,

        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                child: LayoutBuilder(
                  builder: (context, constraint) {
                    return SingleChildScrollView(
                      child: Container(
                        constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      'Abisiniya',
                                      //just change your text like item.model
                                      textAlign: TextAlign.center,

                                      style: TextStyle(

                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Text(
                                      'Affordable Air Tickets,Holiday Home and Car Rental Services',
                                      //just change your text like item.model
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontFamily: 'Avenir',
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(00.0),
                                      padding: EdgeInsets.only(
                                          top: 10.0, left: 5.0, right: 05.0),
                                      //color: Colors.white30,
                                      color: Colors.white,
                                      width: 300.0,
                                      height: 50.0,
                                      child: TextField(
                                          textAlign: TextAlign.left,
                                          autocorrect: false,
                                          decoration:
                                          //disable single line border below the text field
                                          new InputDecoration.collapsed(
                                              hintText: 'Search keyword here')),
                                    ),

                                    SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(00.0),
                                      padding: EdgeInsets.only(
                                          top: 10.0, left: 5.0, right: 05.0),
                                      //color: Colors.white30,
                                      color: Colors.white,
                                      width: 300.0,
                                      height: 50.0,
                                      child: TextField(
                                          textAlign: TextAlign.left,
                                          autocorrect: false,
                                          decoration:
                                          //disable single line border below the text field
                                          new InputDecoration.collapsed(
                                              hintText: 'Select type here')),
                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),

                                    TextButton(
                                      style: TextButton.styleFrom(
                                          fixedSize: const Size(300, 50),
                                          foregroundColor: Colors.white,
                                          backgroundColor: Colors.black,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(00),
                                          ),
                                          textStyle: const TextStyle(fontSize: 20)),
                                      onPressed: () {},
                                      child: const Text('Search'),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(10.0),
                                height: 350,
                                width: 360,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                      image: AssetImage('images/banner2.jpg',),
                                      fit: BoxFit.none),
                                ),
                              ),
                              Column(
                                  children: [
                                    Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 200,
                                              child: ListView.separated(
                                                separatorBuilder: (context,
                                                    index) {
                                                  return SizedBox(
                                                    width: 20,
                                                  );
                                                },
                                                scrollDirection: Axis
                                                    .horizontal,
                                                itemCount: listImages.length,
                                                shrinkWrap: true,
                                                itemBuilder: (
                                                    BuildContext context,
                                                    int index) {
                                                  return Card(
                                                    elevation: 5,
                                                    shadowColor: Colors.grey,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(
                                                        20,
                                                      ),
                                                    ),
                                                    margin: EdgeInsets.all(5),
                                                    child: Container(
                                                      height: 200,
                                                      width: 150,
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .stretch,
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                    10,
                                                                  ),
                                                                  topRight: Radius
                                                                      .circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                                image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  image: NetworkImage(
                                                                    listImages[index],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 50,
                                                            padding: const EdgeInsets
                                                                .all(8.0),
                                                            decoration: BoxDecoration(
                                                              color: Colors
                                                                  .white,
                                                              borderRadius: BorderRadius
                                                                  .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                    20.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                    20.0),
                                                              ),
                                                            ),
                                                            child: Text(
                                                              'Awesome Product From Person ${index
                                                                  .toString()}',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Abisiniya',
                                            //just change your text like item.model
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Text(
                                            'Affordable Air Tickets,Holiday Home and Car Rental Services',
                                            //just change your text like item.model
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontFamily: 'Avenir',
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(00.0),
                                            padding: EdgeInsets.only(top: 00.0,
                                                left: 5.0,
                                                right: 05.0),
                                            //color: Colors.white30,
                                            color: Colors.white,
                                            width: 300.0,
                                            height: 40.0,
                                            child: TextField(
                                                textAlign: TextAlign.left,
                                                autocorrect: false,
                                                decoration:
                                                //disable single line border below the text field
                                                new InputDecoration.collapsed(
                                                    hintText: 'Search Key Here')),
                                          ),
                                        ]
                                    ),
                                  ]
                              ),
                              // middle widget goes here
                              Expanded(
                                child: Container(),
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.star),
                                    Text("Bottom Text")
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        )
    );
  }

}

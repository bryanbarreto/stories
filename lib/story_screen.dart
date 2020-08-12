import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/widgets/story_view.dart';

class StoryScreen extends StatelessWidget {
  static StoryController controller = StoryController();

  static TextStyle style = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    letterSpacing: 3,
    shadows: [
      Shadow(
        color: Colors.black,
        blurRadius: 9,
      ),
    ],
    //  background: Paint(),
  );

  List<StoryItem> storyItems = [
    StoryItem.pageImage(
        url:
            'https://images.pexels.com/photos/4669246/pexels-photo-4669246.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
        controller: controller),
    StoryItem.inlineImage(
        url:
            'https://images.pexels.com/photos/4669246/pexels-photo-4669246.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
        caption: _buildCaption('Hamburguer!!'),
        controller: controller),
    StoryItem.text(title: 'Testando Story', backgroundColor: Colors.lightBlue),
    StoryItem.inlineImage(
      url:
          'https://s2.glbimg.com/slaVZgTF5Nz8RWqGrHRJf0H1PMQ=/0x0:800x450/984x0/smart/filters:strip_icc()/i.s3.glbimg.com/v1/AUTH_59edd422c0c84a879bd37670ae4f538a/internal_photos/bs/2019/U/e/NTegqdSe6SoBAoQDjKZA/cachorro.jpg',
      caption: _buildCaption('Meu Dog'),
      controller: controller,
    ),
    StoryItem.inlineImage(
      url:
          'https://www.petz.com.br/blog/wp-content/uploads/2020/06/animais-com-sindrome-de-down.jpg',
      caption: _buildCaption('dog 2'),
      controller: controller,
    ),
    StoryItem.pageImage(
        url: 'https://media.giphy.com/media/aCqb9YW7QclN3rtto5/giphy.gif',
        controller: controller)
    // StoryItem.pageVideo('https://youtu.be/OvEZ9yXKyLM', controller: controller),
  ];

  static Text _buildCaption(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: style,
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: StoryView(
        storyItems: storyItems,
        controller: controller,
        onComplete: () {
          Navigator.of(context).pop();
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.of(context).pop();
          } else {
            controller.pause();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(10),
                  title: Text('Title'),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        maxLines: 5,
                        decoration:
                            InputDecoration(hintText: 'Reagir ao story'),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(onPressed: () {}, child: Text('Salvar')),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          controller.play();
                        },
                        child: Text('Fechar',
                            style: TextStyle(color: Colors.red))),
                  ],
                );
              },
            );
          }
        },
        progressPosition: ProgressPosition.top,
      ),
    );
  }
}

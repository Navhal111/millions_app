import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:million/utils/dimensions.dart';
import 'package:million/utils/images.dart';

class Messages extends StatefulWidget {
  final ChatMessage message;

  const Messages({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  _MassageScreenState createState() => _MassageScreenState();
}

class _MassageScreenState extends State<Messages>
    with TickerProviderStateMixin {
  AnimationController? _controller;
  Tween<double> tween = Tween(begin: 0.9, end: 1.2);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    // _controller!.forward(from: 1.0);
    // _controller!.reverse();
    // tween.animate(_controller!);
  }

  @override
  void dispose() {
    super.dispose();
    this._controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _controller!.forward(from: 0.9);
        _controller!.reverse();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          mainAxisAlignment: widget.message.isSender
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            if (widget.message.isSender == false) ...[
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(
                      image: AssetImage(Images.avtar), fit: BoxFit.cover),
                ),
              )
            ],
            SizedBox(
              width: 24 / 2,
            ),
            ScaleTransition(
              scale: tween.animate(
                CurvedAnimation(parent: _controller!, curve: Curves.elasticOut),
              ),
              child: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5),
                  padding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: widget.message.isSender ? 3 : 15),
                  decoration: BoxDecoration(
                    color: widget.message.isSender
                        ? Theme.of(context).cardColor.withOpacity(0.5)
                        : Color(0xFF171717),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                      bottomLeft: widget.message.isSender
                          ? Radius.circular(40.0)
                          : Radius.zero,
                      bottomRight: widget.message.isSender
                          ? Radius.zero
                          : Radius.circular(40.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2),
                        child: Text(
                          widget.message.text,
                          style: TextStyle(
                              color: Theme.of(context).hintColor,
                              fontSize: Dimensions.fontSizeLarge),
                          maxLines: 3,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                      if (widget.message.isSender)
                        Container(
                          width: 20,
                          height: 20,
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(Images.doubletick),
                                fit: BoxFit.cover),
                          ),
                        )
                    ],
                  )),
            ),
            if (widget.message.isSender)
              Container(
                margin: const EdgeInsets.only(left: 5),
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage(Images.avtar), fit: BoxFit.cover),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final ChatMessageType messageType;
  final MessageStatus messageStatus;
  final bool isSender;

  ChatMessage({
    this.text = '',
    required this.messageType,
    required this.messageStatus,
    required this.isSender,
  });
}

enum ChatMessageType { text, image, video }

enum MessageStatus { not_sent, not_view, viewed }

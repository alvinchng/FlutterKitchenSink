part of cells;


class LabelImageCell extends StatefulWidget {

  final ObjCell obj;
  final Function onPress;

  const LabelImageCell({
    Key key,
    @required this.obj,
    this.onPress
  }) : super(key: key); 


  @override
  State<StatefulWidget> createState() => LabelImageCellState();

}

class LabelImageCellState extends State<LabelImageCell> {

  

  @override
  void initState() {
      // TODO: implement initState
      super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    String title = (widget.obj.title !=null) ? widget.obj.title : '';
    String desc = (widget.obj.desc !=null) ? widget.obj.desc : '';

    Widget imageView;
    if (widget.obj.relativeObj is File) {
      File tmp = widget.obj.relativeObj;
      imageView = new Image.file(tmp,
                          width: MediaQuery.of(context).size.width,
                          height: 100.0,
                          fit: BoxFit.cover,);
    }
    else {
      imageView = new Image.asset('assets/placeholder_photo.jpg',
                          width: MediaQuery.of(context).size.width,
                          height: 100.0,
                          fit: BoxFit.cover,
                          );
    }

    Container content = new Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: new Column(
            children: <Widget>[
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Container(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: new Text(title.toString(), 
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              ),
                                          ),
                          ),
                          new Text(desc.toString(), style: TextStyle(
                            color: Colors.grey[500]
                          ),),
                          
                          
                        ],
                      )
                    ),
                    Icon(Icons.keyboard_arrow_right),
                    
                  ],
                ),
                imageView,

            ],
          )
        );


      if (widget.obj.isClickable) {
        return new FlatButton(
          onPressed: () {
            if (widget.onPress != null) {
              widget.onPress();
            }
          },
          child: content,
          
        );
      }
      else {
        return new Padding(
          padding: const EdgeInsets.all(8.0),
          child: content,
        );
      }

      
  }



}
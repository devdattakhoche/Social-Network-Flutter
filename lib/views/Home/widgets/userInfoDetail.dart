import 'package:flutter/material.dart';
import 'package:socail_network_flutter/services/Database.dart';
import 'package:socail_network_flutter/views/editPost/editPost.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:socail_network_flutter/services/constant.dart';

Row buildUserInfo(BuildContext context, post) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 1.0, top: 0),
        child: Align(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {Navigator.pop(context)},
            ),
              Card(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 35,
                  backgroundImage:
                  NetworkImage(post['photoUrl']),
                ),
                elevation: 1.0,
                shape: CircleBorder(),
                clipBehavior: Clip.antiAlias,
              ),
              Container(
                padding: const EdgeInsets.only(left: 1, top: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                  Text('Posted By -',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          height: 1.5,
                          letterSpacing: 1)),
                    Text(
                      post['displayName'] ,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                    Row(
                      children: <Widget>[
                        Text( post['designation'] ,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Colors.grey.shade600)),
                        SizedBox(
                          width: 3,
                        ),
                      ],
                    ),
                    Text(
                        timeago
                            .format(
                            post['created'].toDate())
                            .toString(),
                        style:
                        TextStyle(fontSize: 9, color: Colors.grey.shade600))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
       _simplePopup(post,context,post['id'])
    ],
  );
//  Row(
//    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//    children: <Widget>[
//      IconButton(
//        icon: Icon(Icons.arrow_back),
//        onPressed: () => {Navigator.pop(context)},
//      ),
//      Card(
//        child: CircleAvatar(
//            backgroundColor: Colors.white,
//            radius: 35,
//            backgroundImage: NetworkImage(post['photoUrl'])),
//        elevation: 9.0,
//        shape: CircleBorder(),
//        clipBehavior: Clip.antiAlias,
//      ),
//      Padding(
//        padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
//        child: Text.rich(
//          TextSpan(
//            text: 'Posted By - \n',
//            style: TextStyle(
//                fontSize: 12,
//                color: Colors.grey,
//                height: 1.5,
//                letterSpacing: 1),
//            children: <TextSpan>[
//              TextSpan(
//                  text: post['displayName'] + '\n',
//                  style: TextStyle(
//                      color: Colors.black,
//                      letterSpacing: 1.2,
//                      fontSize: 14,
//                      fontWeight: FontWeight.bold)),
//              TextSpan(
//                  text: post['designation'] + '\n',
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontWeight: FontWeight.w300,
//                      letterSpacing: 1)),
//              TextSpan(
//                  text: timeago.format(post['created'].toDate()),
//                  style: TextStyle(
//                      color: Colors.black,
//                      fontWeight: FontWeight.w300,
//                      letterSpacing: 1)),
//            ],
//          ),
//        ),
//      ),
//      if (post['id'] == Constants.uid) _simplePopup(post)
//    ],
//  );
}

Widget _simplePopup(postId, context,userId) {
  DatabaseMethods _database = DatabaseMethods();
  return PopupMenuButton<int>(
    onSelected: (value) => {
      if (value == 0)
        {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => EditPost(postId: postId))).then((value){
          })
        }
      else if (value == 1){
        {_database.deletePost(postId).then((value){
          print("reported");
        })}
      }
      else if (value == 3){
          {
            _database.updateReport(postId).then((value){
            })
          }
        }
    },
    itemBuilder: (context) => [
      if (userId == Constants.uid)
      PopupMenuItem(
        value: 0,
        child: Text("Edit"),
      ),
      if (userId == Constants.uid)
      PopupMenuItem(
        value: 1,
        child: Text("Delete"),
      ),
      if (userId != Constants.uid)
      PopupMenuItem(
        value: 3,
        child: Text("Report"),
      ),
    ],
  );
}

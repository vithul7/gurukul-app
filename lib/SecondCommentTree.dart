import 'CommentNode.dart';
import 'CommentTree.dart';

class SecondCommentTree extends CommentTree {

  // SecondCommentTree() : super() {}

  CommentNode? root;
  List? path;
  bool? searchedFound = false;


  SecondCommentTree() {
    root = CommentNode("Press start");
    path = [];
    searchedFound = false;
  }

  @override
  void createTree() {
    super.createTree();
    mainRemove("Great Volume!");
    mainInsert("Quiet Voice?", "Constant Volume?", "left");
    mainInsert("Constant Volume?", "Improve voice modulation", "left");
    mainInsert("Constant Volume?", "Impressive volume and modulation!", "right");
    mainInsert("All students involved?", "Exuding warmth?", "right");
    mainInsert("Exuding warmth?", "Smile more", "left");
    mainInsert("Animated facial expressions", "Great student engagement!", "right");
    mainRemove("Great delivery!");
    mainInsert("Content well-rehearsed?", "Good Hindi assimilation?", "right");
    mainInsert("Good Hindi assimilation?", "Interpolate more Hindi with English", "left");
    mainInsert("Good Hindi assimilation?","Preparation evident in delivery", "right");
  }


}
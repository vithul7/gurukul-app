import 'CommentNode.dart';
import 'CommentNode.dart';

class CommentTree {
  CommentNode? root;
  List? path;
  bool? searchedFound = false;

  CommentTree() {
    root = CommentNode("Press start");
    path = [];
    searchedFound = false;
  }

  void mainCreatePath(String? textToSearch) {
    _createPath(root, textToSearch);
  }

  void _createPath(CommentNode? root, String? textToSearch) {
    if (root == null) {
      return;
    }
    if (root.getText() == textToSearch) {
      searchedFound = true;
    }
    if (!(searchedFound!)) {
      path?.add("left");
    }
    _createPath(root.left, textToSearch);
    if (!(searchedFound!)) {
      path?.removeAt(path!.length - 1);
    }
    if (!(searchedFound!)) {
      path?.add("right");
    }
    _createPath(root.right, textToSearch);
    if (!(searchedFound!)) {
      path?.removeAt(path!.length - 1);
    }
  }

  void mainRemove(String text) {
    mainCreatePath(text);
    if (path!.isEmpty) {
      print("can't remove from empty comment tree");
    } else {
      CommentNode? current = root;
      current = _remove(root, text);
    }
  }

  CommentNode? _remove(CommentNode? root, String? text) {
    if (path!.first == "left") {
      root = root?.left;
    } else if (path!.first == "right") {
      root = root?.right;
    }
    path!.removeAt(0);
    if (path!.length == 1) {
      if (path!.first == "left") {
        root?.left = null;
      } else if (path!.first == "right") {
        root?.right = null;
      }
      path!.removeAt(0);

      searchedFound = false;
      return root;
    }
    _remove(root, text);
    return null;
  }

  void mainInsert(String parentText, String text, String direction) {
    mainCreatePath(parentText);
    if (path!.isEmpty) {
      CommentNode? current = root;
      current = CommentNode(text);
    } else {
      CommentNode? current = root;
      current = _insert(root, text, direction);
    }
  }

  CommentNode? _insert(CommentNode? root, String text, String direction) {
    if (path!.first == "left") {
      root = root?.left;
    } else if (path!.first == "right") {
      root = root?.right;
    }
    path!.removeAt(0);
    if (path!.isEmpty) {
      if (direction == "left") {
        if (root?.left != null) {
          CommentNode? toInsert = CommentNode(text);
          toInsert.left = root?.left;
          root?.left = toInsert;
        } else {
          CommentNode? toInsert = CommentNode(text);
          root?.left = toInsert;
        }
      } else if (direction == "right") {
        if (root?.right != null) {
          CommentNode? toInsert = CommentNode(text);
          toInsert.right = root?.right;
          root?.right = toInsert;
        } else {
          CommentNode? toInsert = CommentNode(text);
          root?.right = toInsert;
        }
      }
      searchedFound = false;
      return root;
    }
    _insert(root, text, direction);
    return CommentNode("failed to insert node");
  }

  void createTree() {
    root?.setText("Comment on Content?");
    root?.left = CommentNode("Comment on Interactivity?");
    root?.left?.left = CommentNode("Quiet Voice?");
    root?.left?.left?.left = CommentNode("Great Volume!");
    root?.left?.left?.right = CommentNode("Use a louder voice");
    root?.left?.right = CommentNode("All students involved?");
    root?.left?.right?.left = CommentNode("Call on specific students");
    root?.left?.right?.right = CommentNode("Animated facial expressions?");
    root?.left?.right?.right?.left =
        CommentNode("Be more expressive with your face");
    root?.left?.right?.right?.right = CommentNode("Great student engagement!");
    root?.right = CommentNode("Content well-rehearsed?");
    root?.right?.left = CommentNode("Rehearse content fully");
    root?.right?.right = CommentNode("Great delivery!");
  }
}

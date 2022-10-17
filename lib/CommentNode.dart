
class CommentNode {
  String? _text;
  CommentNode? left;
  CommentNode? right;

  CommentNode(String? text) {
    this._text = text;
    this.left = null;
    this.right = null;
  }

  String? getText () {
    return _text;
  }
  void setText (String? value) {
    _text = value;
  }
}


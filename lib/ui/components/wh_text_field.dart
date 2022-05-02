import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WHTextField extends StatefulWidget {
  WHTextField({
    Key? key,
    this.hintText,
    this.maxLines = 1,
    this.canClear = false,
    this.onChanged,
    this.validator,
    this.autovalidateMode,
    this.radius = 5,
    this.expands = false,
    this.textInputType,
    this.enable,
    this.color,
    this.textStyle,
    this.border,
    this.trailing,
    String? initialValue,
    TextEditingController? controller,
  })  : _textController = controller ?? TextEditingController(text: initialValue),
        _geratedTextEditingController = controller == null,
        super(key: key);

  final String? hintText;
  final int? maxLines;
  final bool canClear;
  final bool _geratedTextEditingController;
  final TextEditingController _textController;
  final void Function(String)? onChanged;
  final String? Function(String? value)? validator;
  final AutovalidateMode? autovalidateMode;
  final double radius;
  final bool expands;
  final TextInputType? textInputType;
  final bool? enable;
  final Color? color;
  final TextStyle? textStyle;
  final Border? border;
  final Widget? trailing;

  @override
  State<StatefulWidget> createState() {
    return WHTextFieldState();
  }
}

class WHTextFieldState extends State<WHTextField> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    if (widget._geratedTextEditingController) {
      widget._textController.dispose();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: widget.color ?? Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(widget.radius)),
        border: widget.border,
      ),
      child: Center(
        child: getContent(),
      ),
    );
  }

  Widget getContent() {
    if (widget.trailing != null) {
      return Row(
        children: [
          Expanded(
            child: getTextField(),
          ),
          widget.trailing!,
        ],
      );
    }
    if (widget.canClear) {
      return Row(
        children: [
          Expanded(
            child: getTextField(),
          ),
          FadeTransition(
            opacity: _animation,
            child: IconButton(
              splashColor: Colors.transparent,
              splashRadius: 1,
              icon: const Icon(
                MdiIcons.closeCircle,
                color: Colors.grey,
              ),
              onPressed: () {
                widget._textController.clear();
                _controller.reverse();
              },
            ),
          ),
        ],
      );
    } else {
      return getTextField();
    }
  }

  TextFormField getTextField() {
    return TextFormField(
      controller: widget._textController,
      style: widget.textStyle,
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
        bool _canClear = value.isNotEmpty;
        setState(() {
          if (_canClear) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        });
      },
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      maxLines: widget.maxLines,
      keyboardType: widget.textInputType,
      expands: widget.expands,
      enabled: widget.enable,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
      ),
    );
  }
}

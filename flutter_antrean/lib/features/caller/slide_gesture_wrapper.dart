import 'package:flutter/material.dart';

class SlideGestureWrapper extends StatefulWidget {
  final Widget child;
  final Duration duration;

  /// true = slide to left (content moves to left)
  /// false = slide to right
  final bool slideToLeft;

  const SlideGestureWrapper({
    super.key,
    required this.child,
    required this.slideToLeft,
    this.duration = const Duration(milliseconds: 350),
  });

  @override
  State<SlideGestureWrapper> createState() => _SlideGestureWrapperState();
}

class _SlideGestureWrapperState extends State<SlideGestureWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void didUpdateWidget(covariant SlideGestureWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);

    // jika arah berubah maka setup ulang animasi
    if (oldWidget.slideToLeft != widget.slideToLeft) {
      _initAnimation();
    }
  }

  void _initAnimation() {
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: widget.slideToLeft ? const Offset(-1, 0) : const Offset(1, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward(from: 0); // jalankan animasi
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _animation, child: widget.child);
  }
}

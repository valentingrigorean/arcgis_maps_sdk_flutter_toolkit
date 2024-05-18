import 'dart:async';

import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class Compass extends StatefulWidget {
  const Compass({
    super.key,
    this.size = 44,
    this.autoHide = true,
    required this.controller,
  });

  final double size;

  final bool autoHide;

  final ArcGISMapViewController controller;

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  StreamSubscription<void>? _rotationChangedSubscription;
  double _rotation = 0;

  late bool _visible;

  @override
  void initState() {
    super.initState();
    final controller = widget.controller;
    _setController(controller);
    _visible = !_shouldHide(controller.rotation);
  }

  @override
  void dispose() {
    _rotationChangedSubscription?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant Compass oldWidget) {
    if (widget.controller != oldWidget.controller) {
      _setController(widget.controller);
    }
    if (widget.autoHide != oldWidget.autoHide) {
      _visible = !_shouldHide(widget.controller.rotation);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = SvgPicture.asset(
      'assets/ic_compass.svg',
      package: 'arcgis_maps_sdk_flutter_toolkit',
      width: widget.size,
      height: widget.size,
      fit: BoxFit.contain,
    );

    child = SizedBox(
      width: widget.size,
      height: widget.size,
      child: Transform.rotate(
        angle: _rotation,
        child: child,
      ),
    );

    child = GestureDetector(
      onTap: () {
        widget.controller.setViewpointRotation(angleDegrees: 0);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 228, 240, 244),
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color.fromARGB(255, 127, 127, 127),
            width: 2,
          ),
        ),
        child: child,
      ),
    );

    if (widget.autoHide) {
      child = AnimatedOpacity(
        opacity: _visible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: child,
      );
    }

    return child;
  }

  void _setController(ArcGISMapViewController controller) {
    _rotationChangedSubscription?.cancel();

    updateValues() {
      _rotation = _degreesToRadians(controller.rotation);
      _visible = !_shouldHide(controller.rotation);
    }

    updateValues();
    _rotationChangedSubscription = controller.onRotationChanged.listen((_) {
      updateValues();
      setState(() {});
    });
  }

  bool _shouldHide(double heading) {
    return (heading.isNaN || heading == 0) && widget.autoHide;
  }

  double _degreesToRadians(double degrees) {
    return (math.pi * (360 - degrees) / 180);
  }
}

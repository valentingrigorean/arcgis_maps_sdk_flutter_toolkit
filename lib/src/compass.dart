import 'dart:async';

import 'package:arcgis_maps/arcgis_maps.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class Compass extends StatefulWidget {
  const Compass({
    super.key,
    this.width = 50,
    this.height = 50,
    this.autoHide = true,
    required this.controller,
  });

  final double width;
  final double height;

  final bool autoHide;

  final ArcGISMapViewController controller;

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  StreamSubscription<void>? _rotationChangedSubscription;
  late double _rotation;

  late bool _visible;

  @override
  void initState() {
    super.initState();
    final controller = widget.controller;
    _setController(controller);
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
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    Widget child = SvgPicture.asset(
      'assets/ic_compass.svg',
      package: 'arcgis_maps_sdk_flutter_toolkit',
      width: widget.width,
      height: widget.height,
      fit: BoxFit.contain,
    );

    child = SizedBox(
      width: widget.width,
      height: widget.height,
      child: Transform.rotate(
        angle: _rotation,
        child: child,
      ),
    );

    child = GestureDetector(
      onTap: () {
        widget.controller.setViewpointRotation(angleDegrees: 0);
      },
      child: child,
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

  double _degreesToRadians(double degrees) {
    return (math.pi * (360 - degrees) / 180);
  }

  void _setController(ArcGISMapViewController controller) {
    _rotationChangedSubscription?.cancel();

    updateValues() {
      _rotation = _degreesToRadians(controller.rotation);
      _visible = _rotation != 0;
    }

    updateValues();
    _rotationChangedSubscription = controller.onRotationChanged.listen((_) {
      updateValues();
      setState(() {});
    });
  }
}

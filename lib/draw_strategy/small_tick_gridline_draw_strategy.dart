// Copyright 2018 the Charts project authors. Please see the AUTHORS file
// for details.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'dart:math';

import 'package:community_charts_common/community_charts_common.dart';
import 'package:meta/meta.dart' show immutable;

@immutable
class SmallTickGridLineRendererSpec<D> extends BaseRenderSpec<D> {
  final LineStyleSpec? lineStyle;
  final int? tickLengthPx;

  const SmallTickGridLineRendererSpec({
    TextStyleSpec? labelStyle,
    this.lineStyle,
    LineStyleSpec? axisLineStyle,
    TickLabelAnchor? labelAnchor,
    TickLabelJustification? labelJustification,
    int? labelOffsetFromAxisPx,
    int? labelCollisionOffsetFromAxisPx,
    int? labelOffsetFromTickPx,
    int? labelCollisionOffsetFromTickPx,
    this.tickLengthPx,
    int? minimumPaddingBetweenLabelsPx,
    int? labelRotation,
    int? labelCollisionRotation,
  }) : super(
            labelStyle: labelStyle,
            labelAnchor: labelAnchor,
            labelJustification: labelJustification,
            labelOffsetFromAxisPx: labelOffsetFromAxisPx,
            labelCollisionOffsetFromAxisPx: labelCollisionOffsetFromAxisPx,
            labelOffsetFromTickPx: labelOffsetFromTickPx,
            labelCollisionOffsetFromTickPx: labelCollisionOffsetFromTickPx,
            minimumPaddingBetweenLabelsPx: minimumPaddingBetweenLabelsPx,
            labelRotation: labelRotation,
            labelCollisionRotation: labelCollisionRotation,
            axisLineStyle: axisLineStyle);

  @override
  TickDrawStrategy<D> createDrawStrategy(ChartContext context, GraphicsFactory graphicsFactory) => SmallTickGridLineDrawStrategy<D>(
        context,
        graphicsFactory,
        tickLengthPx: tickLengthPx,
        lineStyleSpec: lineStyle,
        labelStyleSpec: labelStyle,
        axisLineStyleSpec: axisLineStyle,
        labelAnchor: labelAnchor,
        labelJustification: labelJustification,
        labelOffsetFromAxisPx: labelOffsetFromAxisPx,
        labelCollisionOffsetFromAxisPx: labelCollisionOffsetFromAxisPx,
        labelOffsetFromTickPx: labelOffsetFromTickPx,
        labelCollisionOffsetFromTickPx: labelCollisionOffsetFromTickPx,
        minimumPaddingBetweenLabelsPx: minimumPaddingBetweenLabelsPx,
        labelRotation: labelRotation,
        labelCollisionRotation: labelCollisionRotation,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) || //
        (other is SmallTickGridLineRendererSpec && lineStyle == other.lineStyle && tickLengthPx == other.tickLengthPx && super == other);
  }

  @override
  int get hashCode {
    var hashcode = lineStyle.hashCode;
    hashcode = (hashcode * 37) + tickLengthPx.hashCode;
    hashcode = (hashcode * 37) + super.hashCode;
    return hashcode;
  }
}

/// Draws small tick lines for each tick. Extends [BaseTickDrawStrategy].
class SmallTickGridLineDrawStrategy<D> extends BaseTickDrawStrategy<D> {
  int tickLength;
  LineStyle lineStyle;

  SmallTickGridLineDrawStrategy(ChartContext chartContext, GraphicsFactory graphicsFactory,
      {int? tickLengthPx,
      LineStyleSpec? lineStyleSpec,
      TextStyleSpec? labelStyleSpec,
      LineStyleSpec? axisLineStyleSpec,
      TickLabelAnchor? labelAnchor,
      TickLabelJustification? labelJustification,
      int? labelOffsetFromAxisPx,
      int? labelCollisionOffsetFromAxisPx,
      int? labelOffsetFromTickPx,
      int? labelCollisionOffsetFromTickPx,
      int? minimumPaddingBetweenLabelsPx,
      int? labelRotation,
      int? labelCollisionRotation})
      : tickLength = tickLengthPx ?? StyleFactory.style.tickLength,
        lineStyle = StyleFactory.style.createTickLineStyle(graphicsFactory, lineStyleSpec),
        super(
          chartContext,
          graphicsFactory,
          labelStyleSpec: labelStyleSpec,
          axisLineStyleSpec: axisLineStyleSpec ?? lineStyleSpec,
          labelAnchor: labelAnchor,
          labelJustification: labelJustification,
          labelOffsetFromAxisPx: labelOffsetFromAxisPx,
          labelCollisionOffsetFromAxisPx: labelCollisionOffsetFromAxisPx,
          labelOffsetFromTickPx: labelOffsetFromTickPx,
          labelCollisionOffsetFromTickPx: labelCollisionOffsetFromTickPx,
          minimumPaddingBetweenLabelsPx: minimumPaddingBetweenLabelsPx,
          labelRotation: labelRotation,
          labelCollisionRotation: labelCollisionRotation,
        );

  @override
  void draw(
    ChartCanvas canvas,
    Tick<D> tick, {
    required AxisOrientation orientation,
    required Rectangle<int> axisBounds,
    required Rectangle<int> drawAreaBounds,
    required bool isFirst,
    required bool isLast,
    bool collision = false,
  }) {
    Point<num> lineStart;
    Point<num> lineEnd;
    final tickLocationPx = tick.locationPx!;
    switch (orientation) {
      case AxisOrientation.top:
        final x = tickLocationPx;
        lineStart = Point(x, axisBounds.bottom - tickLength);
        lineEnd = Point(x, drawAreaBounds.bottom);
        break;
      case AxisOrientation.bottom:
        final x = tickLocationPx;
        lineStart = Point(x, drawAreaBounds.top + tickLength);
        lineEnd = Point(x, axisBounds.top);
        break;
      case AxisOrientation.right:
        final y = tickLocationPx;
        if (tickLabelAnchor(collision: collision) == TickLabelAnchor.after ||
            tickLabelAnchor(collision: collision) == TickLabelAnchor.before) {
          lineStart = Point(axisBounds.right, y);
        } else {
          lineStart = Point(axisBounds.left + tickLength, y);
        }
        lineEnd = Point(drawAreaBounds.left, y);
        break;
      case AxisOrientation.left:
        final y = tickLocationPx;

        if (tickLabelAnchor(collision: collision) == TickLabelAnchor.after ||
            tickLabelAnchor(collision: collision) == TickLabelAnchor.before) {
          lineStart = Point(axisBounds.left, y);
        } else {
          lineStart = Point(axisBounds.right - tickLength, y);
        }
        lineEnd = Point(drawAreaBounds.right, y);
        break;
    }

    canvas.drawLine(
      points: [lineStart, lineEnd],
      dashPattern: lineStyle.dashPattern,
      fill: lineStyle.color,
      stroke: lineStyle.color,
      strokeWidthPx: lineStyle.strokeWidth.toDouble(),
    );

    var tickPositions = calculateTickPositions(
      tick,
      orientation,
      axisBounds,
      drawAreaBounds,
      tickLength,
    );
    final tickStart = tickPositions.first;
    final tickEnd = tickPositions.last;

    canvas.drawLine(
      points: [tickStart, tickEnd],
      dashPattern: lineStyle.dashPattern,
      fill: lineStyle.color,
      stroke: lineStyle.color,
      strokeWidthPx: lineStyle.strokeWidth.toDouble(),
    );

    drawLabel(
      canvas,
      tick,
      orientation: orientation,
      axisBounds: axisBounds,
      drawAreaBounds: drawAreaBounds,
      isFirst: isFirst,
      isLast: isLast,
      collision: collision,
    );
  }

  List<Point<num>> calculateTickPositions(
    Tick<D> tick,
    AxisOrientation orientation,
    Rectangle<int> axisBounds,
    Rectangle<int> drawAreaBounds,
    int tickLength,
  ) {
    Point<num> tickStart;
    Point<num> tickEnd;
    final tickLocationPx = tick.locationPx!;
    switch (orientation) {
      case AxisOrientation.top:
        final x = tickLocationPx;
        tickStart = Point(x, axisBounds.bottom - tickLength);
        tickEnd = Point(x, axisBounds.bottom);
        break;
      case AxisOrientation.bottom:
        final x = tickLocationPx;
        tickStart = Point(x, axisBounds.top);
        tickEnd = Point(x, axisBounds.top + tickLength);
        break;
      case AxisOrientation.right:
        final y = tickLocationPx;
        tickStart = Point(axisBounds.left, y);
        tickEnd = Point(axisBounds.left + tickLength, y);
        break;
      case AxisOrientation.left:
        final y = tickLocationPx;
        tickStart = Point(axisBounds.right - tickLength, y);
        tickEnd = Point(axisBounds.right, y);
        break;
    }
    return [tickStart, tickEnd];
  }
}
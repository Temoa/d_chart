# d_chart

D'Chart is the development of an existing package chart, namely **community_charts_flutter**.\
The purpose of this pakage is simple way to use chart from [community_charts_flutter](https://pub.dev/packages/community_charts_flutter).\

# Usage

- Wrap Chart with Widget Size like SizedBox, Container, Aspecration etc to set root size for chart
- Example

```dart
AspectRation(
    aspectRatio: 16/9,
    child: DChartTime(),
),

SizedBox(
    width: 240,
    height: 200,
    child: DChartTime(),
),
```

# Table of Content

- Image
  - [Bar](#bar-image)
  - [Line](#line-image)
  - [Pie](#pie-image)
  - [Donut](#donut-image)
  - [Gauge](#gauge-image)
  - [Bar Custom](#bar-custom-image)
  - [Time](#time-image)
- Example
  - 1. [Bar](#bar) [Table](#table-of-content)
  - 2. [Line](#line)
  - 3. [Pie](#pie)
  - 4. [Donut](#donut)
  - 5. [Gauge](#gauge)
  - 6. [Bar Custom](#bar-custom)
  - 7. [Time](#time)
- Render Chart
  - Time
    - 1. [Line](#)
    - 2. [Bar](#)
    - 3. [Target Line](#)
    - 4. [Point](#)
- Tutorial
  - [All Chart](https://www.youtube.com/watch?v=pw1GEJl7edU&list=PLMeCG4xYek-NxSGp2i2mINmeM7k1Rzj4U&index=2)\
  - [Line Chart From Data Collection](https://www.youtube.com/watch?v=mdMayNHY7so&list=PLMeCG4xYek-OdumjOowVcNmW_nVPPUVfa&index=7)\
  - [Bar Chart Custom](https://www.youtube.com/watch?v=bm_80bzQ_M4&list=PLMeCG4xYek-OiZKkbBC7ZFvvsbKhr1HJD&index=4)\
- [Other](#other)

## Bar Image

<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_bar1.jpg" alt="dchart_bar1" height="540">
<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_bar2.jpg" alt="dchart_bar2" height="540">
<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_bar3.jpg" alt="dchart_bar3" height="540">

## Line Image

<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_line1.jpg" alt="dchart_line1" height="540">
<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_line2.jpg" alt="dchart_line2" height="540">

## Pie Image

<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_pie1.jpg" alt="dchart_pie1" height="540">

## Donut Image

<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_pie2.jpg" alt="dchart_pie2" height="540">

## Gauge Image

<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_gauge.jpg" alt="dchart_gauge" height="540">

## Bar Custom Image

<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_bar_custom1.png" alt="dchart_bar_custom1" height="240">
<img src="https://github.com/indratrisnar/d_chart/raw/master/pic/dchart_bar_custom2.png" alt="dchart_bar_custom2" height="240">

## Time Image

(soon)

## Bar

```dart
DChartBar(
    data: [
        {
            'id': 'Bar',
            'data': [
                {'domain': '2020', 'measure': 3},
                {'domain': '2021', 'measure': 4},
                {'domain': '2022', 'measure': 6},
                {'domain': '2023', 'measure': 0.3},
            ],
        },
    ],
    domainLabelPaddingToAxisLine: 16,
    axisLineTick: 2,
    axisLinePointTick: 2,
    axisLinePointWidth: 10,
    axisLineColor: Colors.green,
    measureLabelPaddingToAxisLine: 16,
    barColor: (barData, index, id) => Colors.green,
    showBarValue: true,
),
```

<hr>

## Line

```dart
DChartLine(
    data: [
        {
            'id': 'Line',
            'data': [
                {'domain': 0, 'measure': 4.1},
                {'domain': 2, 'measure': 4},
                {'domain': 3, 'measure': 6},
                {'domain': 4, 'measure': 1},
            ],
        },
    ],
    lineColor: (lineData, index, id) => Colors.amber,
),
```

## Pie

```dart
DChartPie(
    data: [
        {'domain': 'Flutter', 'measure': 28},
        {'domain': 'React Native', 'measure': 27},
        {'domain': 'Ionic', 'measure': 20},
        {'domain': 'Cordova', 'measure': 15},
    ],
    fillColor: (pieData, index) => Colors.purple,
),
```

## Donut

```dart
DChartPie(
    data: [
        {'domain': 'Flutter', 'measure': 28},
        {'domain': 'React Native', 'measure': 27},
        {'domain': 'Ionic', 'measure': 20},
        {'domain': 'Cordova', 'measure': 15},
    ],
    fillColor: (pieData, index) => Colors.purple,
    donutWidth: 30,
    labelColor: Colors.white,
),
```

## Gauge

```dart
DChartGauge(
    data: [
        {'domain': 'Off', 'measure': 30},
        {'domain': 'Warm', 'measure': 30},
        {'domain': 'Hot', 'measure': 30},
    ],
    fillColor: (pieData, index) {
        switch (pieData['domain']) {
            case 'Off':
            return Colors.green;
            case 'Warm':
            return Colors.orange;
            default:
            return Colors.red;
        }
    },
    showLabelLine: false,
    pieLabel: (pieData, index) {
        return "${pieData['domain']}";
    },
    labelPosition: PieLabelPosition.inside,
    labelPadding: 0,
    labelColor: Colors.white,
),
```

## Bar Custom

this is not depend on **community_charts_flutter**

```dart
// example 1
AspectRatio(
    aspectRatio: 16 / 9,
    child: DChartBarCustom(
        showDomainLine: true,
        showMeasureLine: true,
        showDomainLabel: true,
        showMeasureLabel: true,
        spaceBetweenItem: 8,
        listData: [
            DChartBarDataCustom(
                value: 13,
                label: 'Jan',
                color: Colors.blue,
            ),
            DChartBarDataCustom(value: 20, label: 'Feb'),
            DChartBarDataCustom(value: 30, label: 'Mar'),
            DChartBarDataCustom(value: 40, label: 'Apr'),
            DChartBarDataCustom(value: 25, label: 'Mei'),
        ],
    ),
),

// example 2
List ranking = [
    {'class': 'A', 'total': 23},
    {'class': 'B', 'total': 14},
    {'class': 'C', 'total': 8},
    {'class': 'D', 'total': 7},
    {'class': 'E', 'total': 21},
];
DChartBarCustom(
    loadingDuration: const Duration(milliseconds: 1500),
    showLoading: true,
    valueAlign: Alignment.topCenter,
    showDomainLine: true,
    showDomainLabel: true,
    showMeasureLine: true,
    showMeasureLabel: true,
    spaceDomainLabeltoChart: 10,
    spaceMeasureLabeltoChart: 5,
    spaceDomainLinetoChart: 15,
    spaceMeasureLinetoChart: 20,
    spaceBetweenItem: 16,
    radiusBar: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
    ),
    measureLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.purple,
    ),
    domainLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Colors.purple,
    ),
    measureLineStyle:
        const BorderSide(color: Colors.amber, width: 2),
    domainLineStyle: const BorderSide(color: Colors.red, width: 2),
    max: 25,
    listData: List.generate(ranking.length, (index) {
        Color currentColor =
            Color((Random().nextDouble() * 0xFFFFFF).toInt());
        return DChartBarDataCustom(
            onTap: () {
                print(
                '${ranking[index]['class']} => ${ranking[index]['total']}',
                );
            },
            elevation: 8,
            value: ranking[index]['total'].toDouble(),
            label: ranking[index]['class'],
            color: currentColor.withOpacity(1),
            splashColor: Colors.blue,
            showValue: ranking[index]['class'] == 'C' ? false : true,
            valueStyle: ranking[index]['class'] == 'A'
                ? const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black,
                    )
                : const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                    ),
            labelCustom: ranking[index]['class'] == 'B'
                ? Transform.rotate(
                    angle: 5.5,
                    child: const Text('Bagus'),
                    )
                : null,
            valueCustom: ranking[index]['total'] > 20
                ? Align(
                    alignment: Alignment.center,
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            shape: BoxShape.circle,
                            ),
                            child: Text(
                            '${ranking[index]['total']}',
                            style: const TextStyle(
                                fontSize: 11,
                                color: Colors.red,
                                fontWeight: FontWeight.w900,
                            ),
                            ),
                        ),
                        const Text(
                            '😄',
                            style: TextStyle(fontSize: 20),
                        ),
                        ],
                    ),
                    )
                : null,
            valueTooltip: '${ranking[index]['total']} Student',
        );
    }),
),
```

## Time

example under maintenance

# Other

Support me for more feature & packages
[Donate](https://www.paypal.com/paypalme/indratrisnar)

Check my app : [Visit](https://indratrisnar.github.io/projects.html)

Check My Tutorial & Course : [Watch](https://www.youtube.com/channel/UC0d_xINEvCtlDCpWfBpnYpA)

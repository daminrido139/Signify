import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Drawerpage extends StatefulWidget {
  const Drawerpage({super.key});

  @override
  State<Drawerpage> createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
  final List<ChartData> chartData = [
    ChartData('David', 25, const Color.fromRGBO(9, 0, 136, 1)),
    ChartData('Steve', 38, const Color.fromRGBO(185, 239, 238, 1)),
    ChartData('Jack', 34, const Color.fromRGBO(252, 137, 200, 1)),
    ChartData('Others', 52, const Color.fromRGBO(255, 189, 57, 1))
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 233, 223, 190),
      child: Column(
        children: [
          const SizedBox(
            height: 45,
          ),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("assets/img/profileimage.jpg"),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Sachita R",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(
              height: 100,
              width: 150,
              child: Image.asset("assets/img/star.png")),
          const Text(
            "Performance",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Center(
              child: SfCircularChart(series: <CircularSeries>[
            // Renders doughnut chart
            DoughnutSeries<ChartData, String>(
                dataSource: chartData,
                pointColorMapper: (ChartData data, _) => data.color,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y)
          ])),
          // customlogout(context)
        ],
      ),
    );
  }

  Widget customlogout(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color.fromRGBO(228, 212, 156, 1), Color(0xffad9c00)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
            child: Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

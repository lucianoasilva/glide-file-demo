import 'package:flutter/material.dart';
import 'package:glide_file_demo/view/receiving_widget.dart';
import 'package:glide_file_demo/view/selection_widget.dart';

import '../styles/colors.dart';

class HomeHeader extends StatefulWidget {
  const HomeHeader({super.key});

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: secondaryColor,
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        painter: _HomeHeader(),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 170,
                    child: Image.asset('resources/icons/glide-file_logo.png',
                        color: primaryColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        'Glide-File',
                        style: TextStyle(
                          fontFamily: 'LobsterTwo',
                          color: fontColor1,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color:
                              primaryColor, // Puedes cambiar el color del rectángulo según tus preferencias
                        ),
                        child: const Text(
                          'Front Demo',
                          style: TextStyle(
                            fontFamily: 'Mukta',
                            color: fontColor1,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                    ],
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(width: 30),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      height: 100,
                      color: primaryColor,
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        color: secondaryColor,
                        iconSize: 80,
                        icon: Image.asset('resources/icons/enviar.png',
                            color: secondaryColor),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectionWidget()));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Enviá',
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      color: fontColor1,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Recibí',
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      color: fontColor1,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      height: 100,
                      color: secondaryColor,
                      padding: const EdgeInsets.all(5),
                      child: IconButton(
                        color: primaryColor,
                        iconSize: 80,
                        icon: Image.asset('resources/icons/recibir.png',
                            color: primaryColor),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReceivingWidget()));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeHeader extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    //Propiedades
    paint.color = primaryColor;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 20;

    final path = Path();

    //Dibujo
    path.lineTo(0.0, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.75, size.width, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    //Dibujar
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

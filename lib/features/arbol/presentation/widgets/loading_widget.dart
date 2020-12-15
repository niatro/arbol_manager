import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class LoadingNormal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[300],
      child: Center(
        child: SpinKitWave(
          color: Colors.green[900],
          size: 50.0,
        ),
      ),
    );
  }
}

class LoadingWhite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: SpinKitWave(
          color: Colors.green[900],
          size: 30.0,
        ),
      ),
    );
  }
}

class LoadingDualRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: SpinKitDualRing(
          color: Colors.brown[400],
          size: 30.0,
        ),
      ),
    );
  }
}

class LoadingPulse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SpinKitPulse(
          color: Colors.blue[800],
          size: 60.0,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSpinner extends StatefulWidget {
  final DateTime startTime;
  final int increment;
  final int minimum;
  final int maximum;
  Function(DateTime)? onChange;

  TimeSpinner(this.startTime, {Key? key, int? increment, int? minimum, int? maximum, this.onChange})
      : this.increment = (increment ?? 10),
        this.minimum = (minimum ?? 0),
        this.maximum = (maximum ?? 72),
        super(key: key);

  @override
  _TimeSpinnerState createState() => _TimeSpinnerState();
}

class _TimeSpinnerState extends State<TimeSpinner> {
  int _offset = 0;

  void _increment() {
    if (_offset == widget.maximum) {
      return;
    }
    setState(() {
      this._offset++;
      super.widget.onChange!(this.time);
    });
  }

  void _decrement() {
    if (_offset == widget.minimum) {
      return;
    }
    
    setState(() {
      this._offset++;
      super.widget.onChange!(this.time);
    });
  }

  DateTime get time {
    return widget.startTime.add(Duration(minutes: this._offset * widget.increment));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.schedule),
              Text(new DateFormat("HH:mm:ss").format(this.time), style: Theme.of(context).textTheme.headline2),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            margin: const EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  child: ElevatedButton.icon(
                    label: Text("10 Minutes"),
                    icon: Icon(Icons.add),
                    onPressed: () {
                      this._increment();
                    },
                  )
                ),
                Container(
                    margin: const EdgeInsets.all(5),
                  child: ElevatedButton.icon(
                    label: Text("10 Minutes"),
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      this._decrement();
                    },
                  )
                ),
              ]
            )
          )
      ])
    );
  }

}
import 'package:currency_pickers/country.dart';
import 'package:currency_pickers/currency_pickers.dart';
import 'package:flutter/material.dart';

class CountrySelection extends StatefulWidget {
  @override
  _CountrySelectionState createState() => _CountrySelectionState();
}

class _CountrySelectionState extends State<CountrySelection> {
  int _checked = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 24),
          Text(
            'Country',
            style: TextStyle(
              fontFamily: 'SF Pro Display',
              fontSize: 16,
              color: const Color(0xff0B6182),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 28),
          GestureDetector(
            onTap: () => setState(() => _checked = 0),
            child: Row(
              children: <Widget>[
                CurrencyPickerUtils.getDefaultFlagImage(Country(
                  isoCode: 'gh',
                  name: 'Ghana',
                )),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "${Country(
                    isoCode: 'gh',
                    name: 'Ghana',
                  ).name}",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    color: const Color(0xff8C8C94),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if (_checked == 0)
                  Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF1BAECB),
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 16.0,
                        color: Color(0xFF1BAECB),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            onTap: () => setState(() => _checked = 1),
            child: Row(
              children: <Widget>[
                CurrencyPickerUtils.getDefaultFlagImage(Country(
                  isoCode: 'GB',
                  name: 'United Kingdom',
                )),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "${Country(
                    isoCode: 'GB',
                    name: 'United Kingdom',
                  ).name}",
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    color: const Color(0xff8C8C94),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                if (_checked == 1)
                  Container(
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF1BAECB),
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        size: 16.0,
                        color: Color(0xFF1BAECB),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 42),
        ],
      ),
    );
  }
}

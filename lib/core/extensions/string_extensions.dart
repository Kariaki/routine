
const basePng = 'assets/pngs/';
const baseSvg = 'assets/svgs/';

extension StringExtensions on String {
  String get png => '$basePng$this.png';
  String get svg => '$baseSvg$this.svg';

}

import 'package:flutter_test/flutter_test.dart';
import 'package:cryptowatch/main.dart';

void main() {
  testWidgets('Home tampil tiga tab', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Pasar'), findsWidgets);
    expect(find.text('Pantauan'), findsWidgets);
    expect(find.text('Pengaturan'), findsWidgets);
    expect(find.text('Daftar Koin'), findsOneWidget);
  });
}

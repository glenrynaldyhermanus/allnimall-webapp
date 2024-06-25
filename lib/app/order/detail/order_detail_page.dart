import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage({Key? key}) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const GeoramaText(
              'Permintaan berhasil!',
              fontSize: 20,
            ),
            SizedBox(
              height: 120,
              width: 120,
              child: Lottie.network(
                  'https://raw.githubusercontent.com/xvrh/lottie-flutter/master/example/assets/Mobilo/A.json'),
            ),
            const GeoramaText(
              'Silahkan tutup halaman ini, kami akan segera menghubungi kamu setelah mendapatkan konfirmasi dari Groomer.',
              fontSize: 14,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

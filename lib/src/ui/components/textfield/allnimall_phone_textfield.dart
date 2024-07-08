import 'package:allnimall_web/src/core/extensions/widget_iterable_ext.dart';
import 'package:allnimall_web/src/ui/components/text/georama_text.dart';
import 'package:allnimall_web/src/ui/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class AllnimallPhoneTextField extends StatefulWidget {
  final String label;
  final bool obsecureText;
  final bool? enabled;
  final String? hint;
  final String? errorMessage;
  final TextEditingController? controller;
  final Function(String? val) onChanged;
  final bool needOtp;

  const AllnimallPhoneTextField(this.label,
      {super.key,
      this.hint,
      this.obsecureText = false,
      this.enabled = true,
      this.errorMessage,
      this.controller,
      this.needOtp = false,
      required this.onChanged});

  @override
  State<AllnimallPhoneTextField> createState() =>
      _AllnimallPhoneTextFieldState();
}

class _AllnimallPhoneTextFieldState extends State<AllnimallPhoneTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => {});
    });
  }

  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // String? _verificationId;
  //
  // Future<void> _verifyPhoneNumber() async {
  //   await _auth.verifyPhoneNumber(
  //     phoneNumber: '+62 ${}',
  //     verificationCompleted: (PhoneAuthCredential credential) async {
  //       await _auth.signInWithCredential(credential);
  //     },
  //     verificationFailed: (FirebaseAuthException e) {
  //       if (e.code == 'invalid-phone-number') {
  //         print('The provided phone number is not valid.');
  //       }
  //     },
  //     codeSent: (String verificationId, int? resendToken) {
  //       setState(() {
  //         _verificationId = verificationId;
  //       });
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       setState(() {
  //         _verificationId = verificationId;
  //       });
  //     },
  //   );
  // }
  //
  // Future<void> _signInWithPhoneNumber() async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //     verificationId: _verificationId!,
  //     smsCode: otpCode,
  //   );
  //   await _auth.signInWithCredential(credential);
  // }

  bool isError() {
    if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
          decoration: BoxDecoration(
              border: Border.all(
                  color: isError() ? Colors.red : Colors.black26, width: 1),
              borderRadius: BorderRadius.circular(8),
              color: widget.enabled == true
                  ? Colors.grey[200]!
                  : Colors.grey[600]!),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GeoramaText(
                      widget.label,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: GeoramaText(
                            '+62',
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Gap(4),
                        Expanded(
                          child: TextFormField(
                            controller: widget.controller,
                            onChanged: widget.onChanged,
                            enabled: widget.enabled,
                            autofocus: false,
                            focusNode: _focusNode,
                            keyboardType: TextInputType.phone,
                            obscureText: widget.obsecureText,
                            cursorColor: AllnimallColors.primary,
                            inputFormatters: <TextInputFormatter>[
                              MaskedInputFormatter('000-0000-0000-0000')
                            ],
                            style: GoogleFonts.georama(
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            decoration: InputDecoration(
                              hintText: widget.hint,
                              hintStyle: TextStyle(
                                  fontSize: 16, color: Colors.grey[500]),
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: InputBorder.none,
                              fillColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (widget.needOtp)
                TextButton(
                    onPressed: () {},
                    child: const GeoramaText(
                      'Kirim OTP',
                      color: AllnimallColors.secondary,
                    )),
              const Gap(8)
            ],
          ),
        ),
        if (isError())
          GeoramaText(
            isError() ? widget.errorMessage! : '',
            color: Colors.red,
          )
      ].divide(const SizedBox(height: 4)),
    );
  }
}

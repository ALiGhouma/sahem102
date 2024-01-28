import 'package:flutter/cupertino.dart';
import 'package:sahem/Features/auth/presentation/componants/sigin_up_view_body.dart';

class SiginUpView extends StatefulWidget {
  const SiginUpView({super.key});

  @override
  State<SiginUpView> createState() => _SiginUpViewState();
}

class _SiginUpViewState extends State<SiginUpView> {
  @override
  Widget build(BuildContext context) {
    return SiginUPViewBody();
  }
}

import 'package:flutter/material.dart';
import 'package:sahem/Core/resources/color_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> images = [
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',
    'https://image.adsoftheworld.com/xrwxxt020548rglngk3gj7329adl',

  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            //this where i called the widget such customappbar
            customAppBar(),
            SizedBox(height: MediaQuery.of(context).size.height*0.15,
            child: imageSlider(),
            ),

            SizedBox(height: MediaQuery.of(context).size.height*0.01,),

             //i called the report button
             reportButton(),
             SizedBox(height: MediaQuery.of(context).size.height * 0.03, // Adjust the height as per your requirement
                ),
            Container(
              height: MediaQuery.of(context).size.height * 0.10, // Adjust the height as per your requirement
              width: double.infinity,
              decoration: const ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.01, -1.00),
                  end: Alignment(-0.01, 1),
                  colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(' خدماتك البلدية رقمية في \n   أي وقت ومن أي مكان',style: TextStyle(fontSize: 25,color: ColorManager.white,fontWeight: FontWeight.bold),)],
              ),
            )
          ],

        ),
      )),
    );
  }
  //this where i built the reoport button for better code
  Widget reportButton(){
    return  Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.width * 0.8,

      decoration: const ShapeDecoration(
        color: Color(0xFFAADBD8),
        shape: OvalBorder(),
      ),
      child: Stack(children: [
        Center(
          child: InkWell(
            onTap: (){},
            child: Container(
              width: MediaQuery.of(context).size.width * 0.65,
              height: MediaQuery.of(context).size.width * 0.65,
              decoration: const ShapeDecoration(
                color: Color(0xFF05AC8C),
                shape: OvalBorder(),
              ),

            ),
          ),
        ),
        const Center(
          child:  Text(
            'اضافة بلاغ ',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700,
              height: 0,
            ),
          ),
        ),

      ],),
    );
  }
  //I built Custom AppBar And used stack for putting the avatar and the text above the shape container
  Widget customAppBar(){
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.01, -1.00),
          end: Alignment(-0.01, 1),
          colors: [Color(0xFF05AC8C), Color(0xFF12787C)],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      child: Stack(
          children: [
            Positioned(
              right: MediaQuery.of(context).size.width * -0.2,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.07),
                  shape: const OvalBorder(),
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.09,
              child: const CircleAvatar(
                maxRadius: 30,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width * 0.1,
              top: MediaQuery.of(context).size.height * 0.17,
              child: Text(
                'مرحبا بيك ...',
                style: TextStyle(fontSize: 20, color: ColorManager.white),
              ),
            ),
          ]),
    );
  }
  Widget imageSlider(){
    return  ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: images.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            height: 100,
            width:300,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                images[index],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

}

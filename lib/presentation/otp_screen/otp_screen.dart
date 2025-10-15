import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/controller/otp_controller.dart';
import 'package:dating_app_bilhalal/presentation/otp_screen/otp_success_screen.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/countdown_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_outlined_button.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPScreen extends GetView<OTPController> {
   OTPScreen({super.key});

   var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Scaffold(
      //backgroundColor: TColors.white,
      appBar: TAppBar(
        //showBackArrow: true,
        //rightToLeft: true,
        title: Text('تغيير البريد الإلكتروني',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: TColors.blueDating,
            fontSize: 20.fSize,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
            decorationColor: TColors.blueDating,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.hw),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomImageView(
                  imagePath: ImageConstant.logo,
                  height: 150.adaptSize,
                  width: 150.adaptSize,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Center(child: TitleWidget(title: "التحقق من حسابك",
                color:  _appTheme =='light' ? TColors.black : TColors.primaryColorApp,
                textAlign: TextAlign.center,)),
              Directionality(
                textDirection: TextDirection.rtl,
                child: SubTitleWidget(subtitle: "تم إرسال رمز مكون من ستة أرقام إلى بريدك الإلكتروني المسجل. أدخل الرمز هنا للتحقق من حسابك.",
                  color:  _appTheme =='light' ? TColors.black : TColors.white,
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              /* SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text("Verification"),
                    Text(
                      "We sent you a SMS Code",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "On number: +998993727053",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ), */
              Center(
                child: Obx(() => PinFieldAutoFill(
                  codeLength: 6,
                  autoFocus: true,
                  onCodeChanged: (code) {
                    controller.otpCode.value = code ?? "";
                  },
                  currentCode: controller.otpCode.value,
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(fontSize: 30,
                        color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white),
                    colorBuilder: PinListenColorBuilder(
                        TColors.primaryColorApp, TColors.buttonSecondary), // ligne grise
                    //bgColorBuilder: PinListenColorBuilder(Colors.yellow.shade200, Colors.grey.shade200),
                  ),
                )),
              ),
              SizedBox(height: 20.v),
              /// 🕒 Compte à rebours + réenvoi
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                       Icon(Icons.access_time_sharp, color: _appTheme =='light' ? TColors.gray700 : TColors.white,size: 25.adaptSize,),
                      Obx(() => CountDownWidget(
                        animation: StepTween(
                          begin: controller.levelClock.value, // THIS IS A USER ENTERED NUMBER
                          end: 0,
                        ).animate(controller.animationController!),

                      )),
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 1.v),
                              child: Text("لم تستلم الرمز؟ ",
                                  style:  isTablet
                                      ? Theme.of(context).textTheme.titleMedium!
                                      .apply(color: _appTheme =='light' ? TColors.gray700 : TColors.white)
                                      : _appTheme =='light'
                                      ? CustomTextStyles.bodyMediumTextFormFieldGrey
                                      : CustomTextStyles.bodyMediumTextFormFieldLightGrey
                              )
                          ),
                          GestureDetector(
                              onTap: () async {
                                controller.animationController?.reset();
                                controller.animationController?.forward();
                                controller.resendOtpFn();
                              },
                              child: Padding(padding: EdgeInsets.only(left: 8.hw),
                                  child: Text("أعد الإرسال",
                                    //style: CustomTextStyles.titleMediumBlueVPT
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: _appTheme =='light' ? TColors.black : TColors.white,
                                      fontSize: 18.fSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                              )
                          )
                        ]
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.v),
              /// 🚨 Message d’erreur rouge
              Obx(() => controller.isOtpError.value
                  ? Directionality(
                textDirection: TextDirection.rtl,
                    child: Text(
                        controller.errorMessage.value,
                        style: TextStyle(color: Colors.red, fontSize: 16.adaptSize, fontWeight: FontWeight.w500),
                      ),
                  )
                  : const SizedBox.shrink()),

              SizedBox(height: 40.v),
              Center(
                child: CustomButtonContainer(
                  text:controller.isLoading.value ? "" : "التالي",
                  color1: TColors.primaryColorApp,
                  color2: TColors.primaryColorApp,
                  borderRadius: 15,
                  colorText: TColors.white,
                  fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                  height: isSmallPhone ? 80.v : 70.v,
                  width: Get.width,
                  onPressed:controller.isLoading.value
                      ? null // désactive le clic pendant chargement
                      :  () async {
                    await controller.verifyOtpFn(context);
                   //await controller.saveOTPFn(context);
                  },
                  child: controller.isLoading.value
                      ? const SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  )
                      : null,
                ),
              ),
              SizedBox(height: 15.v,),
             /* Obx(() => controller.canResend.value
                  ? GestureDetector(
                onTap: controller.resendOtpFn,
                child: Text(
                  "إعادة إرسال OTP",
                  style: TextStyle(
                    color: TColors.primaryColorApp,
                    fontSize: 18.fSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
                  : const SizedBox.shrink()), */
              Obx(() => controller.canResend.value
                  ? Directionality(
                textDirection: TextDirection.rtl,
                child: CustomOutlinedButton(
                  buttonTextStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormFieldBold : CustomTextStyles.titleLargeWhite,
                  buttonStyle: _appTheme =='light' ? CustomButtonStyles.outlineBlack : CustomButtonStyles.outlineWhite,
                  text: "إعادة إرسال OTP",
                  margin: EdgeInsets.only(top: 6.hw),
                  borderRadius: 80.hw,
                  height: isSmallPhone ? 80.v : 70.v,
                  width: Get.width,
                  onPressed: () async {
                   await controller.resendOtpFn();
                  },
                ),
                 )
                  : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> with SingleTickerProviderStateMixin {

  AnimationController? _animationController;
  int levelClock = 2 * 60;


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: levelClock));

    _animationController!.forward();

    _listenSmsCode();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: TColors.white,
      appBar: TAppBar(
        //showBackArrow: true,
        //rightToLeft: true,
        title: Text('تغيير البريد الإلكتروني',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: TColors.blueDating,
              fontSize: 20.fSize,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              decorationColor: TColors.blueDating,
            ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(18.hw),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomImageView(
                  imagePath: ImageConstant.logoHeader,
                  height: 180.adaptSize,
                  width: 180.adaptSize,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Center(child: TitleWidget(title: "التحقق من حسابك", textAlign: TextAlign.center,)),
              SubTitleWidget(subtitle: "تم إرسال رمز مكون من ستة أرقام إلى بريدك الإلكتروني المسجل. أدخل الرمز هنا للتحقق من حسابك.",
              textAlign: TextAlign.center,),
              SizedBox(height: TSizes.spaceBtwItems),
             /* SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text("Verification"),
                    Text(
                      "We sent you a SMS Code",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "On number: +998993727053",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ), */
              Center(
                child: PinFieldAutoFill(
                  codeLength: 6,
                  autoFocus: true,
                  decoration: UnderlineDecoration(
                    lineHeight: 2,
                    lineStrokeCap: StrokeCap.square,
                    textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                    bgColorBuilder: PinListenColorBuilder(
                        Colors.yellow.shade200, Colors.grey.shade200),
                    colorBuilder: const FixedColorBuilder(Colors.transparent),
                  ),
                ),
              ),
             SizedBox(height: 20.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.access_time_sharp, color: TColors.gray700),
                      CountDownWidget(
                        animation: StepTween(
                          begin: levelClock, // THIS IS A USER ENTERED NUMBER
                          end: 0,
                        ).animate(_animationController!),

                      ),
                    ],
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.only(bottom: 1.v),
                              child: Text("لم تستلم الرمز؟ ",
                                  style:  isTablet
                                      ? Theme.of(context).textTheme.titleMedium!.apply(color: TColors.gray700)
                                      : CustomTextStyles.bodyMediumTextFormFieldGrey)
                          ),
                          GestureDetector(
                              onTap: () async {
                              },
                              child: Padding(padding: EdgeInsets.only(left: 8.hw),
                                  child: Text("أعد الإرسال",
                                    //style: CustomTextStyles.titleMediumBlueVPT
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                      color: TColors.primaryColorApp,
                                      fontSize: 16.fSize,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                              )
                          )
                        ]
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.v),
              Center(
                child: CustomButtonContainer(
                  text: "يكمل",
                  color1: TColors.primaryColorApp,
                  color2: TColors.primaryColorApp,
                  borderRadius: 10,
                  colorText: TColors.white,
                  fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                  height: isSmallPhone ? 80.v : 70.v,
                  width: Get.width,
                  onPressed: () async {
                    onTapOTPSuccessPage(context);
                  },
                ),
              ),
              SizedBox(height: 15.v,),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomOutlinedButton(
                  buttonTextStyle: CustomTextStyles.bodyMediumTextFormFieldBold,
                  buttonStyle: CustomButtonStyles.outlineBlack,
                  text: "إعادة إرسال OTP",
                  margin: EdgeInsets.only(top: 6.hw),
                  borderRadius: 100.hw,
                  height: isSmallPhone ? 80.v : 70.v,
                  onPressed: (){
                    //?  use this code to get sms signature for your app
                    //final String signature = await SmsAutoFill().getAppSignature;
                    //print("Signature: $signature");

                    _animationController!.reset();
                    _animationController!.forward();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    /*  floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 56,
            width: 150,
            child: ElevatedButton(
              onPressed: () async {
                //?  use this code to get sms signature for your app
                //final String signature = await SmsAutoFill().getAppSignature;
                //print("Signature: $signature");

                _animationController!.reset();
                _animationController!.forward();
              },
              child: const Text("Resend"),
            ),
          ),
          SizedBox(
            height: 56,
            width: 150,
            child: ElevatedButton(
              onPressed:  () {
                //Confirm and Navigate to Home Page
              } ,
              child: const Text("Confirm"),
            ),
          ),
        ],
      ), */
    );
  }
}
*/
onTapOTPSuccessPage(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => OTPSuccessScreen()),
  );
}
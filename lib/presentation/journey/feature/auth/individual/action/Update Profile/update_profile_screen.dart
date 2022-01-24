import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gstore/common/constants/icon_constant.dart';
import 'package:my_gstore/common/constants/image_constant.dart';
import 'package:my_gstore/common/constants/string_const.dart';
import 'package:my_gstore/common/customs/custom_gesturedetactor.dart';
import 'package:my_gstore/common/global_app_cache/global_app_catch.dart';
import 'package:my_gstore/common/network/configs.dart';
import 'package:my_gstore/common/theme/theme_color.dart';
import 'package:my_gstore/common/theme/theme_text.dart';
import 'package:my_gstore/common/ultils/common_util.dart';
import 'package:my_gstore/common/ultils/validate_ultil.dart';
import 'package:my_gstore/presentation/injector_container.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/Widget/bottom_sheet_date_picker.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/Widget/custom_textfield_with_label_inside.dart';
import 'package:my_gstore/presentation/journey/feature/auth/individual/Widget/update_info_utils.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/button_bottom.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_cache_image_network.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_checkbox.dart';
import 'package:my_gstore/presentation/journey/feature/widgets/custom_modal_bottom_sheet_image.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late GlobalAppCache _globalAppCatch;
  bool check = false;

  @override
  void initState() {
    _globalAppCatch = injector<GlobalAppCache>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController _nameCtl = TextEditingController();
    _nameCtl.text = _globalAppCatch.profileModel?.fullName ?? '';
    TextEditingController _addressCtl = TextEditingController();
    _addressCtl.text = _globalAppCatch.profileModel?.address ?? '';
    TextEditingController _userMSTCtl = TextEditingController();
    _userMSTCtl.text= _globalAppCatch.profileModel?.userMST??'';
    TextEditingController _desCtl = TextEditingController();
    TextEditingController _phoneCtl = TextEditingController();
    _phoneCtl.text = _globalAppCatch.profileModel?.mobile ?? '';
    TextEditingController _emailCtl = TextEditingController();
    _emailCtl.text = _globalAppCatch.profileModel?.email ?? '';
    TextEditingController _birthDayCtl = TextEditingController();
    _birthDayCtl.text=_globalAppCatch.profileModel?.birthDayText??'';
    // Số CMT
    TextEditingController _codeUserCtl = TextEditingController();
    _codeUserCtl.text = _globalAppCatch.profileModel?.cardCode ?? '';
    // Ngày cấp CMT
    TextEditingController _codeDateCtl = TextEditingController();
    _codeDateCtl.text = _globalAppCatch.profileModel?.cardCodeDateText ?? '';
    // Nơi cấp CMT
    TextEditingController _codeLocationCtl = TextEditingController();
    _codeLocationCtl.text = _globalAppCatch.profileModel?.cardCodeLocation ?? '';
    /// Company
    TextEditingController _companyName = TextEditingController();

    /// Mã Số Doanh Nghiệp (Mã số đăng ký kinh doanh)
    TextEditingController _codeCompanyCtl = TextEditingController();
    TextEditingController _webCtl = TextEditingController();

    // Ngày cấp Mã số kinh doanh
    TextEditingController _companyDateCtl = TextEditingController();
    TextEditingController _companyLocationCodeCtl = TextEditingController();
    TextEditingController _companyMSTCtl = TextEditingController();
    TextEditingController _addressCompanyCtl = TextEditingController();

    void _selectDateProvide(context) {
      CommonUtils.showCustomBottomSheet(
        context: context,
        child: BottomSheetDatePicker(
          onDateTimeChanged: (DateTime? date) {
            _codeDateCtl.text = UpdateInfoUtils.convertDateTimeToDisplay(date);
          },
        ),
        height: 300,
      );
    }

    void _selectDateTimeBirthDay(context) {
      CommonUtils.showCustomBottomSheet(
        context: context,
        child: BottomSheetDatePicker(
          onDateTimeChanged: (DateTime? date) {
            _birthDayCtl.text = UpdateInfoUtils.convertDateTimeToDisplay(date);
          },
        ),
        height: 300,
      );
    }

    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: AppColors.grey2,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: CustomGestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50.0)),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          _globalAppCatch.profileModel?.imageTimeline == ''
                              ? const Image(
                                  image: AssetImage(
                                      ImageConstant.mockTopBackGround),
                                  width: double.infinity,
                                  height: 125,
                                  fit: BoxFit.cover,
                                )
                              : CustomCacheImageNetwork(
                                  url: _globalAppCatch
                                          .profileModel?.imageTimeline ??
                                      '',
                                  width: double.infinity,
                                  height: 145,
                                  fit: BoxFit.cover,
                                ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        child: CustomGestureDetector(
                          onTap: () {
                            customModalBottomSheet(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              children: [
                                ClipOval(
                                  child: CustomCacheImageNetwork(
                                    url: _globalAppCatch
                                            .profileModel?.avartaUrl ??
                                        '',
                                    height: MediaQuery.of(context).size.width *
                                        1 /
                                        4,
                                    width: MediaQuery.of(context).size.width *
                                        1 /
                                        4,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        border:
                                            Border.all(color: AppColors.white),
                                        color: AppColors.grey2),
                                    child: SvgPicture.asset(
                                      IconConst.personalCamera,
                                      width: 25,
                                      height: 25,
                                      color: AppColors.logoGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text(
                          StringConst.notePersonal,
                          style: AppTextTheme.smallGrey,
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        CustomTextFieldWithLabelInside(
                          hintText: StringConst.namePersonal,
                          textInputType: TextInputType.text,
                          controller: _nameCtl,
                          validator: ValidateUtil.validEmpty,
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 4, bottom: 16),
                          child: const Text(
                            '(*) ${StringConst.noteNamePersonal}',
                            style: AppTextTheme.smallGrey,
                          ),
                        ),
                        CustomTextFieldWithLabelInside(
                          hintText: '${StringConst.address} (*)',
                          textInputType: TextInputType.text,
                          controller: _addressCtl,
                          textCapitalization: TextCapitalization.words,
                          validator: ValidateUtil.validEmpty,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFieldWithLabelInside(
                          hintText: '${StringConst.phoneNumber} (*)',
                          controller: _phoneCtl,
                          textInputType: TextInputType.number,
                          validator: ValidateUtil.validEmpty,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFieldWithLabelInside(
                          hintText: '${StringConst.citizenId} (*)',
                          controller: _codeUserCtl,
                          textInputType: TextInputType.number,
                          validator: ValidateUtil.validEmpty,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldWithLabelInside(
                          hintText: '${StringConst.dateProvide} (*)',
                          onTap: () {
                            _selectDateProvide(context);
                          },
                          readOnly: true,
                          controller: _codeDateCtl,
                          validator: ValidateUtil.validEmpty,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldWithLabelInside(
                          hintText: '${StringConst.whereProvide} (*)',
                          textCapitalization: TextCapitalization.words,
                          controller: _codeLocationCtl,
                          validator: ValidateUtil.validEmpty,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldWithLabelInside(
                          hintText: '${StringConst.personalTaxCode}',
                          textInputType: TextInputType.number,
                          controller: _userMSTCtl,
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldWithLabelInside(
                          hintText: '${StringConst.birthDay}',
                          readOnly: true,
                          controller: _birthDayCtl,
                          onTap: () {
                            _selectDateTimeBirthDay(context);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextFieldWithLabelInside(
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          controller: _emailCtl,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.all(16),
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomGestureDetector(
                      onTap: () {
                        check = !check;
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(4, 8.0, 4, 8.0),
                        child: CustomCheckBox(
                          value: check,
                          onChange: (status) {
                            setState(() {
                              check = status;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomGestureDetector(
                        onTap: () {
                          CommonUtils.runUrl(Configurations.urlPolicy);
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text:
                                      'Tôi đồng ý trở thành người bán và tuân theo chính sách của G-Store ',
                                  style: AppTextTheme.normalBlack),
                              TextSpan(
                                  text: 'Xem chính sách tại đây',
                                  style: AppTextTheme.normalBlue)
                            ],
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ))
                  ],
                ),
                check
                    ? ButtonBottom(
                        haveIcon: false,
                        color: AppColors.green,
                        paddingHorizontal: 0.0,
                        text: StringConst.finishAction,
                        onTap: () {},
                      )
                    : ButtonBottom(
                        haveIcon: false,
                        color: AppColors.grey5,
                        paddingHorizontal: 0.0,
                        text: StringConst.finishAction,
                        onTap: () {},
                      )
              ],
            ),
          )),
    );
  }
}

void customModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => DraggableScrollableSheet(
          minChildSize: 0.2,
          initialChildSize: 0.2,
          expand: false,
          builder: (_, controller) => CustomModalBottomSheet()));
}

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/global.dart';
import 'package:quiz/src/pages/home/teacher/home/components/create/parsing/parsing.dart';
import 'package:quiz/src/pages/home/teacher/home/components/quiz_add/controller/quiz_addition_controller.dart';
import 'package:quiz/utils/quizTextField.dart';
import 'package:quiz/widget/option_text_form_field.dart';
import '../../../../../../../theme/app_color.dart';
import '../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../utils/quizAppBar.dart';

class QuizAdditionView extends StatefulWidget {
  const QuizAdditionView({super.key});
  static const routeName = '/addQuizBucket';

  @override
  State<QuizAdditionView> createState() => _QuizAdditionViewState();
}

class _QuizAdditionViewState extends State<QuizAdditionView> {
  var controller = Get.find<AddQuizController>();
  PlatformFile? pickedFile;
  bool isShowImage = false;
  File? image;
  var result;
  handleFileUpload() async {
    result = await FilePicker.platform.pickFiles();
    if (result != null) {
      controller.uploadText.value = 'Uploaded';
      quizDebugPrint("$result---result");
      quizDebugPrint("${pickedFile}ppppp");
      setState(() {
        pickedFile = result.files.first;
      });
      quizDebugPrint("${pickedFile!.path}--path");
      setState(() {
        isShowImage = !isShowImage;
      });
      image = File(pickedFile!.path ?? '');
    } else {
      showSnackBar('No Image selected', blackColor, whiteColor);
    }
  }

  // Future<void> uploadImage() async {
  //   var stream = https.ByteStream(image!.openRead());
  //   stream.cast();
  //   var length = await image!.length();
  //   var uri = Uri.parse(uri)
  // }

  @override
  Widget build(BuildContext context) {
    Get.put(AddQuizController());
    return Scaffold(
      backgroundColor: kTeacherPrimaryColor,
      appBar: QuizAppbar(
        leading: const SizedBox(),
        appBarColor: kTeacherPrimaryColor,
        titleText: 'Quizzed',
        preferredSize: const Size.fromHeight(65),
        tariling: IconButton(
          onPressed: () {
            Get.to(
              () => const Parsing(),
              arguments: [
                {"code": controller.getSubjectCode()},
                {"quizID": controller.getQuizBucket()},
              ],
            );
          },
          icon: const Icon(Icons.switch_access_shortcut),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              height: 100,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Quiz Bucket',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 4),
                            width: double.infinity,
                            child: Text(
                              controller
                                  .getQuizBucket()
                                  .toString()
                                  .toUpperCase()
                                  .toString(),
                              style: kBodyText3Style()
                                  .copyWith(color: kTeacherPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Quiz Subject',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Card(
                        margin: const EdgeInsets.only(top: 4),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 2, vertical: 4),
                            width: double.infinity,
                            child: Text(
                              controller
                                  .getSubject()
                                  .toString()
                                  .toUpperCase()
                                  .toString(),
                              style: kBodyText3Style()
                                  .copyWith(color: kTeacherPrimaryColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => Text(
                          'This is ${controller.page.value + 1} question out of ${controller.getTotalQs()}',
                          style: kBodyText3Style()
                              .copyWith(color: kTeacherPrimaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: kTeacherPrimaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                        height: 500,
                        width: double.infinity,
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: controller.getTotalQs(),
                          itemBuilder: ((context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        //height: 70,
                                        width: double.infinity,
                                        decoration: const BoxDecoration(
                                          color: kTeacherPrimaryshadeColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(24)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Text(
                                                '${controller.page.value + 1}.  Question ${controller.page.value + 1}',
                                                style: kBodyText3Style(),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.upload_file,
                                                    color: whiteColor,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        handleFileUpload();
                                                        //  controller.uploadImage();
                                                      },
                                                      child: Obx(
                                                        () => Text(
                                                          controller
                                                              .uploadText.value,
                                                          style:
                                                              kBodyText3Style(),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              if (isShowImage)
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 8, bottom: 8),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    child: Image.file(
                                                      File(pickedFile!.path!),
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Column(
                                        children: [
                                          QuizTextFormField(
                                            labelColor: whiteColor,
                                            labelText: 'Question',
                                            hintText: 'Type question',
                                            borderColor: whiteColor,
                                            cursorColor: whiteColor,
                                            hintColor: greyColor,
                                            isObscureText: false,
                                            focusNode: FocusNode(),
                                            controller: controller.qsStatement,
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          _createOption(),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              quizDebugPrint('e');
                                              controller.isCreating.value =
                                                  true;
                                              controller
                                                  .createThisQuiz(pickedFile)
                                                  .then((value) {
                                                pickedFile = null;
                                                isShowImage = false;
                                                controller.uploadText.value =
                                                    'Upload Image (OPTIONAL)';
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: Container(
                                                height: 45,
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12)),
                                                    color: whiteColor),
                                                width: double.infinity,
                                                child: Obx(() => controller
                                                            .isCreating.value ==
                                                        false
                                                    ? Center(
                                                        child: Text('Create',
                                                            style: kBodyText10Style()
                                                                .copyWith(
                                                                    color:
                                                                        kTeacherPrimaryColor)))
                                                    : const Center(
                                                        child: CircularProgressIndicator(
                                                            color:
                                                                kTeacherPrimaryColor,
                                                            strokeWidth: 1),
                                                      )),
                                              ),
                                            ),
                                          ),
                                          // MYElevatedButton(
                                          //   label: 'Create',
                                          //   labelWidget: Obx(() => controller
                                          //               .isCreating.value ==
                                          //           true
                                          //       ? const Center(
                                          //           child:
                                          //               CircularProgressIndicator(
                                          //                   strokeWidth: 1,
                                          //                   color: whiteColor),
                                          //         )
                                          //       : Center(
                                          //           child: Text(
                                          //             'Create',
                                          //             style: kElevatedButtonTextStyle()
                                          //                 .copyWith(
                                          //                     color:
                                          //                         kTeacherPrimaryColor),
                                          //           ),
                                          //         )),
                                          //   backgroundColor: whiteColor,
                                          //   function: () {
                                          //     controller.isCreating.value ==
                                          //         true;
                                          // controller
                                          //     .createThisQuiz(pickedFile)
                                          //     .then((value) {
                                          //   pickedFile = null;
                                          //   isShowImage = false;
                                          //   controller.uploadText.value =
                                          //       'Upload Image (OPTIONAL)';
                                          // });
                                          //   },
                                          //   textColor: kTeacherPrimaryColor,
                                          // ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          physics: const BouncingScrollPhysics(),
                          onPageChanged: (value) {
                            print(value);
                            //controller.pageController.
                            //controller.page.value = controller.page.value + 1;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  SingleChildScrollView _createOption() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: Column(
        children: [
          Row(
            children: [
              Obx(
                () => CircleAvatar(
                  backgroundColor: controller.onTapColor1.value,
                  child: Text(
                    'A',
                    style: kBodyText0Style(),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  child: OptionTextFormField(
                    borderColor: whiteColor,
                    controller: controller.option1,
                    cursorColor: whiteColor,
                    isObscureText: false,
                    labelColor: whiteColor,
                    labelText: 'Option 1',
                    contentColor: whiteColor,
                  ),
                ),
              ),
              Obx(() => Radio(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return whiteColor;
                    }),
                    toggleable: true,
                    activeColor: whiteColor,
                    value: 0,
                    groupValue: controller.correctOptionValue.value,
                    onChanged: (val) {
                      print(val);
                      controller.correctOptionValue.value = val!;
                    },
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Obx(
                () => CircleAvatar(
                  backgroundColor: controller.onTapColor1.value,
                  child: Text(
                    'B',
                    style: kBodyText0Style(),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  child: OptionTextFormField(
                    borderColor: whiteColor,
                    controller: controller.option2,
                    cursorColor: whiteColor,
                    isObscureText: false,
                    labelColor: whiteColor,
                    labelText: 'Option 2',
                    contentColor: whiteColor,
                  ),
                ),
              ),
              Obx(() => Radio(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return whiteColor;
                    }),
                    toggleable: true,
                    activeColor: whiteColor,
                    value: 1,
                    groupValue: controller.correctOptionValue.value,
                    onChanged: (val) {
                      print(val);
                      controller.correctOptionValue.value = val!;
                    },
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Obx(
                () => CircleAvatar(
                  backgroundColor: controller.onTapColor1.value,
                  child: Text(
                    'C',
                    style: kBodyText0Style(),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  child: OptionTextFormField(
                    borderColor: whiteColor,
                    controller: controller.option3,
                    cursorColor: whiteColor,
                    isObscureText: false,
                    labelColor: whiteColor,
                    labelText: 'Option 3',
                    contentColor: whiteColor,
                  ),
                ),
              ),
              Obx(() => Radio(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return whiteColor;
                    }),
                    toggleable: true,
                    activeColor: whiteColor,
                    value: 2,
                    groupValue: controller.correctOptionValue.value,
                    onChanged: (val) {
                      print(val);
                      controller.correctOptionValue.value = val!;
                    },
                  ))
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Obx(
                () => CircleAvatar(
                  backgroundColor: controller.onTapColor1.value,
                  child: Text(
                    'D',
                    style: kBodyText0Style(),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: SizedBox(
                  width: 200,
                  child: OptionTextFormField(
                    borderColor: whiteColor,
                    controller: controller.option4,
                    cursorColor: whiteColor,
                    isObscureText: false,
                    labelColor: whiteColor,
                    labelText: 'Option 4',
                    contentColor: whiteColor,
                  ),
                ),
              ),
              Obx(() => Radio(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return whiteColor;
                    }),
                    toggleable: true,
                    activeColor: whiteColor,
                    value: 3,
                    groupValue: controller.correctOptionValue.value,
                    onChanged: (val) {
                      print(val);
                      controller.correctOptionValue.value = val!;
                    },
                  ))
            ],
          ),
          // const SizedBox(
          //   height: 4,
          // ),
        ],
      ),
    );
  }
}

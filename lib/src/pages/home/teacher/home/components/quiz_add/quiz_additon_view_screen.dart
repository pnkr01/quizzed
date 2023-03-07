import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/src/global/shared.dart';
import 'package:quiz/src/pages/home/teacher/home/components/quiz_add/controller/quiz_addition_controller.dart';
import 'package:quiz/utils/quizTextField.dart';
import 'package:quiz/widget/option_text_form_field.dart';
import '../../../../../../../theme/app_color.dart';
import '../../../../../../../theme/gradient_theme.dart';
import '../../../../../../../utils/quizAppBar.dart';
import '../../../../../../../widget/custom_elevated_bottom.dart';

class QuizAdditionView extends GetView<AddQuizController> {
  const QuizAdditionView({super.key});
  static const routeName = '/addQuizBucket';

  @override
  Widget build(BuildContext context) {
    Get.put(AddQuizController());
    return Scaffold(
      backgroundColor: kTeacherPrimaryColor,
      appBar: const QuizAppbar(
        leading: SizedBox(),
        appBarColor: kTeacherPrimaryColor,
        titleText: 'Quizzed',
        preferredSize: Size.fromHeight(56),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
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
                      Text(
                        'Hi Prof. ${sharedPreferences.getString('tName')} you can start creating quiz',
                        style: kBodyText3Style()
                            .copyWith(color: kTeacherPrimaryColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Obx(
                        () => Text(
                          'This is ${controller.currentQs + 1} question out of ${controller.getTotalQs()}',
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
                        height: 400,
                        width: double.infinity,
                        child: PageView.builder(
                          itemCount: controller.getTotalQs(),
                          itemBuilder: ((context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SingleChildScrollView(
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
                                                '${controller.currentQs + 1}.  Question ${controller.currentQs + 1}',
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
                                                  Text(
                                                    'Upload Image (OPTIONAL)',
                                                    style: kBodyText3Style(),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 2,
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
                                            height: 20,
                                          ),
                                          MYElevatedButton(
                                            label: 'Create',
                                            backgroundColor: whiteColor,
                                            function: () {
                                              controller.createThisQuiz();
                                            },
                                            textColor: kTeacherPrimaryColor,
                                          ),
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
                          onPageChanged: (value) => print(value),
                        ),
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
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                child: Text('A'),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 200,
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
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const CircleAvatar(
                child: Text('B'),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 200,
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
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const CircleAvatar(
                child: Text('C'),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 200,
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
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              const CircleAvatar(
                child: Text('D'),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
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
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

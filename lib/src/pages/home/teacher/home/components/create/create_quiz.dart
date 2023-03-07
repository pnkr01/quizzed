import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz/theme/gradient_theme.dart';
import 'package:quiz/utils/quizAppBar.dart';
import 'package:quiz/utils/quizElevatedButon.dart';
import 'package:textfield_search/textfield_search.dart';
import '../../../../../../../theme/app_color.dart';
import '../../../../../../../utils/helper_widget.dart';
import '../../../../../../../utils/loading_dialog.dart';
import '../../../../../../../utils/quizTextField.dart';
import '../../../../../../../utils/size_configuration.dart';
import 'controller/create_quiz_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateQuiz extends GetView<CreateQuizController> {
  const CreateQuiz({super.key});
  static const routeName = '/createQuiz';

  @override
  Widget build(BuildContext context) {
    Get.put(CreateQuizController());
    var myController = Get.find<CreateQuizController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kTeacherPrimaryLightColor,
      appBar: const QuizAppbar(
        appBarColor: kTeacherPrimaryLightColor,
        titleText: 'Create Quiz',
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
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: controller.focusNodeTitle,
                        child: QuizTextFormField(
                          focusNode: controller.focusNodeTitle,
                          hintText: 'Enter quiz title',
                          contentColor: kTeacherPrimaryColor,
                          labelText: 'Quiz Title',
                          borderColor: kTeacherPrimaryColor,
                          cursorColor: kTeacherPrimaryColor,
                          hintColor: kTeacherPrimaryColor,
                          isObscureText: false,
                          controller: controller.title.value,
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: controller.focusNodeDescription,
                        child: QuizTextFormField(
                          focusNode: controller.focusNodeDescription,
                          hintText: 'Enter quiz description',
                          contentColor: kTeacherPrimaryColor,
                          labelText: 'Quiz Description',
                          borderColor: kTeacherPrimaryColor,
                          cursorColor: kTeacherPrimaryColor,
                          hintColor: kTeacherPrimaryColor,
                          isObscureText: false,
                          controller: controller.description.value,
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Obx(
                        () => controller.isFetching == true
                            ? const CircularProgressIndicator()
                            : TextFieldSearch(
                                label: '',
                                decoration: InputDecoration(
                                  hintText: 'Type more than 3 words to search',
                                  hintStyle: kBodyText3Style()
                                      .copyWith(color: greyColor, fontSize: 12),
                                  labelText: 'Subject',
                                  labelStyle: kBodyText3Style().copyWith(
                                      color: kTeacherPrimaryColor,
                                      fontSize: 14.sp),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          getProportionateScreenHeight(14.sp)),
                                    ),
                                    borderSide: const BorderSide(
                                        color: kTeacherPrimaryColor),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          getProportionateScreenHeight(14.sp)),
                                    ),
                                    borderSide: const BorderSide(
                                      color: kTeacherPrimaryColor,
                                    ),
                                  ),
                                ),
                                initialList: controller.showSubjectList,
                                //label: 'label',
                                controller: controller.search.value,
                                textStyle: kBodyText3Style()
                                    .copyWith(color: kTeacherPrimaryColor),
                                // getSelectedValue: (val) {
                                //   log(val.toString());
                                // },
                                // getSelectedValue: (val) {
                                //   print(val);
                                // },
                              ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: controller.focusNodesection,
                        child: QuizTextFormField(
                          focusNode: controller.focusNodesection,
                          hintText: 'Enter Section(e.g CSE-K)',
                          contentColor: kTeacherPrimaryColor,
                          labelText: 'Section',
                          borderColor: kTeacherPrimaryColor,
                          cursorColor: kTeacherPrimaryColor,
                          hintColor: kTeacherPrimaryColor,
                          isObscureText: false,
                          controller: controller.section.value,
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: controller.focusNodesemester,
                        child: QuizTextFormField(
                          focusNode: controller.focusNodesemester,
                          hintText: 'Enter Semester(i.e 1,2)',
                          contentColor: kTeacherPrimaryColor,
                          labelText: 'Semester',
                          borderColor: kTeacherPrimaryColor,
                          cursorColor: kTeacherPrimaryColor,
                          hintColor: kTeacherPrimaryColor,
                          isObscureText: false,
                          controller: controller.semester.value,
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: controller.focusNodeDtotalQs,
                        child: QuizTextFormField(
                          focusNode: controller.focusNodeDtotalQs,
                          hintText: 'Enter total Qustion',
                          contentColor: kTeacherPrimaryColor,
                          labelText: 'Question',
                          borderColor: kTeacherPrimaryColor,
                          cursorColor: kTeacherPrimaryColor,
                          hintColor: kTeacherPrimaryColor,
                          isObscureText: false,
                          controller: controller.totalQs.value,
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: controller.focusNodemarksPerQs,
                        child: QuizTextFormField(
                          focusNode: controller.focusNodemarksPerQs,
                          hintText: 'Enter each question marks',
                          contentColor: kTeacherPrimaryColor,
                          labelText: 'Marks',
                          borderColor: kTeacherPrimaryColor,
                          cursorColor: kTeacherPrimaryColor,
                          hintColor: kTeacherPrimaryColor,
                          isObscureText: false,
                          controller: controller.marksPerQs.value,
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      EnsureVisibleWhenFocused(
                        focusNode: controller.focusNodeduration,
                        child: QuizTextFormField(
                          focusNode: controller.focusNodeduration,
                          hintText: 'Enter duration',
                          contentColor: kTeacherPrimaryColor,
                          labelText: 'Test Duration',
                          borderColor: kTeacherPrimaryColor,
                          cursorColor: kTeacherPrimaryColor,
                          hintColor: kTeacherPrimaryColor,
                          isObscureText: false,
                          controller: controller.duration.value,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      QuizElevatedButton(
                          label: const Text('Create'),
                          backgroundColor: kTeacherPrimaryColor,
                          function: () {
                            showDialog(
                                context: context,
                                builder: ((context) => const LoadingDialog(
                                    message: 'Please wait')));
                            controller.checkThisCreateQuizTap();
                          }),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//   Card _chooseCourseCard() {
//     return Card(
//       color: whiteColor,
//       child: Obx(
//         () => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose Course',
//               style: kBodyText3Style()
//                   .copyWith(color: kTeacherPrimaryLightColor, fontSize: 14.sp),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 8),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   iconEnabledColor: kTeacherPrimaryColor,
//                   isExpanded: true,
//                   // Step 3.
//                   value: controller.dropdownValue.value,
//                   // Step 4.
//                   items: <String>['Select', 'BTECH', 'MTECH']
//                       .map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(
//                         value,
//                         style: kBodyText3Style()
//                             .copyWith(color: kTeacherPrimaryColor),
//                       ),
//                     );
//                   }).toList(),
//                   // Step 5.
//                   onChanged: (newValue) {
//                     controller.onChangeBranchvalue(newValue);
//                     controller.insertInBranchList(newValue!);
//                     controller.isBranchBlocked.value = false;
//                     //Get.reload();
//                     // setState(() {
//                     //   dropdownValue = newValue!;
//                     // });
//                     log(controller.selectedBranch.toString());
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Card _chooseBranchCard() {
//     return Card(
//       color: whiteColor,
//       child: Obx(
//         () => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose Branch',
//               style: kBodyText3Style()
//                   .copyWith(color: kTeacherPrimaryLightColor, fontSize: 14.sp),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 8),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                     iconEnabledColor: kTeacherPrimaryColor,
//                     isExpanded: true,
//                     value: controller.dropdownBranchValue.value,
//                     items: controller.selectedBranch
//                         .map((item) => DropdownMenuItem<String>(
//                               value: item,
//                               child: Text(
//                                 item,
//                                 style: kBodyText3Style()
//                                     .copyWith(color: kTeacherPrimaryColor),
//                               ),
//                             ))
//                         .toList(),
//                     onChanged:
//                         // ignore: unrelated_type_equality_checks
//                         Get.find<CreateQuizController>().isBranchBlocked ==
//                                 false
//                             ? (value) => {
//                                   controller.dropdownBranchValue.value = value!,
//                                   log(controller.dropdownBranchValue.value),
//                                   controller.addSubject(),
//                                   controller.isSemetserBlocked.value = false,
//                                 }
//                             : null),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Card _chooseSemCard() {
//     return Card(
//       color: whiteColor,
//       child: Obx(
//         () => Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose Semester',
//               style: kBodyText3Style()
//                   .copyWith(color: kTeacherPrimaryLightColor, fontSize: 14.sp),
//             ),
//             const SizedBox(
//               height: 4,
//             ),
//             Container(
//               margin: const EdgeInsets.only(left: 8),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<String>(
//                   iconEnabledColor: kTeacherPrimaryColor,
//                   isExpanded: true,
//                   // Step 3.
//                   value: controller.semesterValue.value.toString(),
//                   // Step 4.
//                   items: controller.selectSemester
//                       .map((item) => DropdownMenuItem<String>(
//                             value: item.toString(),
//                             child: Text(
//                               item.toString(),
//                               style: kBodyText3Style()
//                                   .copyWith(color: kTeacherPrimaryColor),
//                             ),
//                           ))
//                       .toList(),
//                   onChanged:
//                       // ignore: unrelated_type_equality_checks
//                       Get.find<CreateQuizController>().isSemetserBlocked ==
//                               false
//                           ? (value) => {
//                                 controller.dropdownBranchValue.value = value!,
//                                 log(controller.dropdownBranchValue.value),
//                                 controller.addSubject(),
//                               }
//                           : null,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:quizzed/src/pages/home/teacher/support/components/developer_card.dart';
import 'package:quizzed/theme/app_color.dart';
import 'package:quizzed/theme/gradient_theme.dart';
import 'package:quizzed/utils/quizAppBar.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const QuizAppbar(
        titleText: "Team",
        preferredSize: Size.fromHeight(60),
        appBarColor: kTeacherPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0, bottom: 8, right: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Text(
              "Lead and Mentored By :",
              style: kBodyText1Style(),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    const CircleAvatar(
                      backgroundColor: kTeacherPrimaryColor,
                      radius: 88,
                      child: CircleAvatar(
                        radius: 85,
                        backgroundImage: NetworkImage(
                            "https://media.licdn.com/dms/image/C5103AQGEzNEyvvc5AQ/profile-displayphoto-shrink_100_100/0/1582521988361?e=1697068800&v=beta&t=W6IQAdSS3rVRQm-_ymA3Jq9zm4axniIPvGaZGtjBpCg"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Anukampa Behera",
                      style: kBodyText7Style(),
                    ),
                    Text(
                      "Assistant Professor at ITER, SOA University | DevOps, AI &  ML",
                      style: kBodyText7Style().copyWith(
                          color: kTeacherPrimaryLightColor, fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            const DeveloperCard(
              name: "Krishna Mahato",
              bio: "Backend Developer",
              image:
                  "https://media.licdn.com/dms/image/D5603AQE8Oc0XhhZovw/profile-displayphoto-shrink_400_400/0/1691522674395?e=1697068800&v=beta&t=yRN94DSFTTx4rYv3Fa0QuCehGoXA1knn6PIehghtXjY",
              github: "https://github.com/krishna9304",
              linkedin: "https://www.linkedin.com/in/krishna-mahato/",
            ),
            const DeveloperCard(
              name: "Pawan Kumar",
              bio: "Flutter App Developer",
              image:
                  "https://media.licdn.com/dms/image/D4D03AQEmAVrTUwkw5w/profile-displayphoto-shrink_400_400/0/1686482968037?e=1697068800&v=beta&t=aOEM8LLJQwY4-9t47aLEV_8OwhR7t3TmdPYVxuptX3g",
              github: "https://github.com/pnkr01",
              linkedin: "https://www.linkedin.com/in/pawan-kumar-9490581b5/",
            ),
          ],
        ),
      ),
    );
  }
}

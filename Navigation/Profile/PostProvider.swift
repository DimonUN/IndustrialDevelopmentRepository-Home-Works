import Foundation
import UIKit

enum PostError: Error {
    case dataError
}

struct PostProvider {
    static func get() -> [Post]? {
        #if DEBUG
        return nil
        #else
        return [
            Post(
                title: "About the dangers of malnutrition",
                author: "Ignat",
                description: "An inadequate diet can lead to malnutrition. Malnutrition is a condition which is caused by an imbalance between what a person eats and the nutrients that they need to maintain good health. Malnutrition commonly occurs when someone does not eat enough food (sub-nutrition). However, it can also occur if a person has a poor diet that provides them with an incorrect balance of the basic food groups listed above. Therefore, it is possible for an obese person, whose diet consists mainly of ‘fast food’, to be malnourished because this type of food lacks the nutrients that their body requires. An inadequate diet can also lead to a person having a deficiency of one, or more, vitamins, minerals, or other essential substances. For example, a vitamin C (ascorbic acid) deficiency can occur if a person does not include enough fresh fruit and vegetables in their diet. This can lead to a condition called scurvy. See the ‘useful links’ section for more information about scurvy.",
                image: "post1",
                likes: 15,
                views: 103
            ),

            Post(
                title: "Yoga",
                author: "Maria",
                description: "The heightened stress and fast pace of today’s world make yoga more relevant than ever, says Sally Sherwin, a yoga instructor at the Center for Integrative & Lifestyle Medicine at Cleveland Clinic in Ohio, who is certified by Yoga Alliance, the world's largest nonprofit yoga association that certifies teachers and schools. “We spend so much time on autopilot, checking off things on our to-do list. Yoga can help people slow down,” she says. Yoga can help people manage stress and improve well-being, says Sherwin. “When you do yoga, your nervous system calms down and you get out of that fight-or-flight state, Sherwin says. “Just sitting and breathing can be yoga. You’re aware, you’re in the moment, and you can find peace in that moment,” she says.",
                image: "post2",
                likes: 71,
                views: 1310
            ),

            Post(
                title: "Positive networking",
                author: "Victor",
                description: "Networking is not only about trading information, but also serves as an avenue to create long-term relationships with mutual benefits.  Continue reading to find out why networking should be at the core of your career.",
                image: "post3",
                likes: 14,
                views: 209
            ),

            Post(
                title: "Summer travel 2022",
                author: "Evgenia",
                description: "Maybe you’re counting down the days until your summer vacation. Or just got word your next business meeting will be in Boise or Bangkok. You can boost your chances of having a healthy and happy trip if you do a little prep work before you leave home. Travel can be great for your health. Vacations can help you relax and reduce stress. Having fun and getting some exercise—like hiking or swimming—can benefit your heart and mind. But research has shown that your ability to successfully engage in healthy behaviors may decline more than you think once you’re away from your daily routine. Planning ahead can help you make smart choices and avoid pitfalls while traveling.",
                image: "post4",
                likes: 211,
                views: 2102
            ),

            Post(
                title: "Medical insurance",
                author: "Konstantin",
                description: "No one plans to fall ill or get hurt, but a serious illness can strike anyone at any time. The cost of treating the illness can cause severe financial strain on the savings you have accumulated over time. This means that you might have to compromise on providing your child the best quality education or defaulting on your home loan payments. Today, the cost of medical treatment is continuously rising.",
                image: "post5",
                likes: 54,
                views: 993
            ),

            Post(
                title: "Meet the sunset on the honeymoon",
                author: "Svetlana",
                description: "Whether you’re sitting on the beach, hiking in the mountains, or even relaxing in a rocking chair on your own front porch, watching a breathtaking sunset never gets old. Each day ends with a unique sunset that is unlike any that has come before or will come after. While there are no words or even pictures that can capture the true beauty of watching a sunset in person, these quotes aim to eloquently describe just how beautiful and inspiring they can be. This collection of quotes about sunsets will make great captions for your next Instagram post that features the beautiful colors of the sky as it transitions from day to night. They'll also inspire you to experience every sunset that you can. So whether you are looking for a short quote to use as a caption or a longer sunset quote for inspiration, you're sure to find plenty of beautiful sunset quotes that you love on this list.",
                image: "post6",
                likes: 289,
                views: 4123
            )
        ]
        #endif
    }
}

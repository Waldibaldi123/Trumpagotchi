//
//  Constants.swift
//  V2-Trumpagotchi
//
//  Created by Daniel Walder on 7/29/20.
//  Copyright © 2020 Daniel Walder. All rights reserved.
//

import Foundation
import SpriteKit

//MARK: - Out-Game Time Intervals

let angryIncInterval: Double = 120
let drinkInterval: Double = 2400            //but decrement angry by 10 each time
let angryWatchTVDecInterval: Double = 360
let angryPlayDecInterval: Double = 0.3

let disciplineDecInterval: Double = 240
let tweetInterval: Double = 3600            //but decrement discipline by 10 each time
let disciplineWatchTVDecInterval: Double = 240
let briefingAvailableInterval: Double = 1800

let tiredIncInterval: Double = 240
let tiredDecInterval: Double = 60
let tiredPlayIncInterval: Double = 5

let angryLoseInterval: Double = 16 * 3600
let disciplineLoseInterval: Double = 16 * 3600

//MARK: - In-Game Time Intervals

var randomIdleWalkInterval: Double {
    return Double.random(in: 5...10)
}
var randomTweetInterval: Double {
    return Double.random(in: 10...20)
}
var randomShrugInterval: Double {
    return Double.random(in: 10...20)
}

var randomDrinkInterval: Double {
    return Double.random(in: 15...20)
}

//MARK: - Trump Action Points

let relativeCokePoint = CGPoint(x: 0.827, y: 0.545)
let relativeSleepPoint = CGPoint(x: 0.418, y: 0.114)
let relativeShrugPoint = CGPoint(x: 0.622, y: 0.639)
let relativeNuclearSuitcaseActivePoint = CGPoint(x: 0.2, y: 0.15)

//MARK: - Positioning

let relativePosDict = [
    "2.16": [
        "timers": CGPoint(x: 0.5, y: 0.96),
        "background":  CGPoint(x: 0.5, y: 0.55),
        "desk": CGPoint(x: 0.5, y: 0.5),
        "cokeButton": CGPoint(x: 0.72, y: 0.56),
        "trophy": CGPoint(x: 0.28, y: 0.54),
        "cokeBottle": CGPoint(x: 0.5, y: 0.1),
        "briefing": CGPoint(x: 0.5, y: 0.55),
        "chair": CGPoint(x: 0.6, y: 0.62),
        "television": CGPoint(x: 0.8, y: 0.28),
        "flagRight": CGPoint(x: 0.75, y: 0.65),
        "flagLeft": CGPoint(x: 0.25, y: 0.65),
        "curtain": CGPoint(x: 0.5, y: 1.0),
        "smallTable": CGPoint(x: 0.18, y: 0.63),
        "nuclearSuitcase": CGPoint(x: 0.11, y: 0.65),
        "piggyBank": CGPoint(x: 0.25, y: 0.66),
        "exit": CGPoint(x: 0.045, y: 0.02),
        "trump": CGPoint(x: 0.5, y: 0.3)
    ],
    "1.77": [
        "timers": CGPoint(x: 0.5, y: 0.96),
        "background":  CGPoint(x: 0.5, y: 0.55),
        "desk": CGPoint(x: 0.5, y: 0.5),
        "cokeButton": CGPoint(x: 0.72, y: 0.56),
        "trophy": CGPoint(x: 0.28, y: 0.54),
        "cokeBottle": CGPoint(x: 0.5, y: 0.1),
        "briefing": CGPoint(x: 0.5, y: 0.55),
        "chair": CGPoint(x: 0.6, y: 0.62),
        "television": CGPoint(x: 0.8, y: 0.28),
        "flagRight": CGPoint(x: 0.75, y: 0.65),
        "flagLeft": CGPoint(x: 0.25, y: 0.65),
        "curtain": CGPoint(x: 0.5, y: 1.08),
        "smallTable": CGPoint(x: 0.18, y: 0.63),
        "nuclearSuitcase": CGPoint(x: 0.11, y: 0.65),
        "piggyBank": CGPoint(x: 0.20, y: 0.70),
        "exit": CGPoint(x: 0.045, y: 0.02),
        "trump": CGPoint(x: 0.5, y: 0.3)
    ]
]

let scaleToScreenDict = [
    "background": CGFloat(1.0),
    "desk": CGFloat(1.6),
    "cokeButton": CGFloat(6.8),
    "trophy": CGFloat(6.5),
    "cokeBottle": CGFloat(5.0),
    "briefing": CGFloat(8.0),
    "chair": CGFloat(3.8),
    "television": CGFloat(2.5),
    "flagRight": CGFloat(5.0),
    "flagLeft": CGFloat(5.0),
    "curtain": CGFloat(1.2),
    "smallTable": CGFloat(2.8),
    "nuclearSuitcase": CGFloat(5.0),
    "piggyBank": CGFloat(7.0),
    "exit": CGFloat(5.0),
    "trumpMAX": CGFloat(2.5),
    "trumpMIN": CGFloat(4.0),
    "tweetPile": CGFloat(6.0),
    "trashBin": CGFloat(5.0),
    "devAvatar": CGFloat(5.0),
    "commentObject": CGFloat(6.0)
]

//MARK: - Briefing

let briefingTouches = 10
let briefingLines = 10

//MARK: - Debate Game

let relativeTileHeight = CGFloat(5.0)
let tileStartDuration = CGFloat(3.0)
let initialDurationDecrement = CGFloat(0.65)

//MARK: - Covid Game

let covidFacts = [
    "74 actions by Trump administration to weaken environmental protection",
    "US second biggest contributor of CO2 emissions in the world",
    "US average temperature increased by 1.9F since record keeping",
    "Trump withdrew from the Paris Agreement to stop climate change",
    "Trump regarding climate change: \"I don’t believe it\"",
]

//MARK: - Notification Bodies

let angry100Body = "Trump is furious in his office! Take him outside before he finds the nuclear warhead button!"
let discipline0Body = "The world is burning and Trump keeps tweeting nonsense. Clean up after this dirty boy!"
let tired0Body = "Looks like Trump is awake again! Go kick him out of bed!"
let angryLooseBody = "Uh oh, Trump is about to start a nuclear war! Quick, calm him down!"
let disciplineLooseBody = "Trump is going crazy online while the world burns down! Quick, clean up his act!"

//MARK: - Dev Comments

let televisionComment = [
    "title" : "Cable News",
    "source" : "NY Times",
    "text" : "People close to Trump estimate that he spends a least 4 hours, and sometimes as much as twice that, in front of a television per day. For example, in the morning he watches CNN for news, \"Fox & Friends\" for comfort and \"Morning Joe\" for motivation. Confronted with criticsm, he furiously fires back on his phone. Trump passionately believes that the liberal left and media are out to destroy him, a perspective that has not shifted since he started his run for presidency."
]
let cokeButtonComment = [
    "title" : "The Coke Button",
    "source" : "Washington Post, CNN",
    "text" : "Trump drinks about a dozen Diet Cokes a day. Fittingly, he literally has a button on his desk that when pressed summons a White House Butler with the beverage. While Diet Coke is a healthier option than regular Coke, there are still many drawbacks that come with consumption at such a scale. Risk for Strokes and dementia are tripled, and there is higher risk of obesity, hypertension, metabolic syndrome and Type 2 diabetes. Furthermore, 12 cans of Diet Coke a day overshoots the safe amount of caffeine consumption by 2 cans, which can lead to migraines, insomnia, restlessness and muscle tremors."
]
let trophyComment = [
    "title" : "#1 healthiest president",
    "source" : "BBC",
    "text" : "If elected, Mr Trump, I can state unequivocally, will be the healthiest individual ever elected to the presidency - Harold Bornstein, Trump's former doctor, writes in a statement about Trump's health. Trump constantly prides himself with his outstanding physical and mental abilities, using sources like the above to back up his claims. However, turns out Bornstein did not write this letter; it was dictated by Trump himself. One can only determine Trump's actual state of health through his actions."
]
let lazyTrumpComment = [
    "title" : "Wakey wakey Trump",
    "source" : "NY Times",
    "text" : "Waking Trump up is not an issue, since the president usually is awake at 5:30am. However, the challenge lies in getting Trump out of bed. Mr. Kelly, former White House chief of staff, tried to reduce the amount of free time the president has for fiery tweets by accelerating the start of his workday, but only with modest success. Trump would still spend hours laying in bed and watching TV, before actually showing up to work at around 9:30am."
]
let briefingComment = [
    "title" : "Trump doesn't read",
    "source" : "Business Insider",
    "text" : "Trump reportedly does not read the written intelligence reports given to him. Although he does like looking at the graphs and satellite images, he prefers oral briefings. But even then, Trump veers off-topic, expresses skepticism or even stops listening when told he is wrong. Trump even blamed a January 23rd briefing for not adequately warning him of the threat the novel coronavirus posed - even though he received dozens of intelligence briefings on the matter, as well as warnings from scientists and other national security officials. "
]

//MARK: - Tweet Texts

let tweetContents = [
    TweetContent(text: "There will never be an \"Autonomous Zone\" in Washington, D.C., as long as I'm your President. If they try they will be met with serious force!", date: "8:45 AM - Jun 23, 2020"),
    TweetContent(text: "Actually, I think I'm leading in the Polls! @FoxNews @OANN", date: "11:45 AM - Aug 23, 2020"),
    TweetContent(text: "They are sending out 51,000,000 Ballots to people who haven’t even requested a Ballot. Many of those people don’t even exist. They are trying to STEAL this election. This should not be allowed!", date: "5:15 PM - Aug 20, 2020"),
    TweetContent(text: "HE SPIED ON MY CAMPAIGN, AND GOT CAUGHT!", date: "7:33 PM · Aug 19, 2020"),
    TweetContent(text: "Don’t buy GOODYEAR TIRES - They announced a BAN ON MAGA HATS. Get better tires for far less! (This is what the Radical Left Democrats do. Two can play the same game, and we have to start playing it now!).", date: "7:33 AM · Aug 19, 2020"),
    TweetContent(text: "IF YOU CAN PROTEST IN PERSON, YOU CAN VOTE IN PERSON!", date: "6:38 AM · Aug 19, 2020"),
    TweetContent(text: "Tell the Dems that we have more Cases because we do FAR more Testing than any other Country!", date: "6:35 PM · Aug 18, 2020"),
    TweetContent(text: "...Meanwhile, I gave America energy independence in fact, so much energy we could never use it all. The Bernie/Biden/AOC Green New Deal plan would take California’s failed policies to every American!", date: "11:38 AM · Aug 18, 2020"),
    TweetContent(text: "Looking back into history, the response by the ObamaBiden team to the H1N1 Swine Flu was considered a weak and pathetic one. Check out the polling, it’s really bad. The big difference is that they got a free pass from the Corrupt Fake News Media!", date: "4:10 AM · Aug 18, 2020"),
    TweetContent(text: "....My Administration and I built the greatest economy in history, of any country, turned it off, saved millions of lives, and now am building an even greater economy than it was before. Jobs are flowing, NASDAQ is already at a record high, the rest to follow. Sit back & watch!", date: "4:00 AM · Aug 18, 2020"),
    TweetContent(text: "Why is Congress scheduled to meet (on Post Office) next Monday, during the Republican Convention, rather than now, while the Dems are having their Convention. They are always playing games. GET TOUGH REPUBLICANS!!!", date: "1:15 PM · Aug 17, 2020"),
    TweetContent(text: "Just landed in Mankato, Minnesota!", date: "11:37 AM · Aug 17, 2020"),
    TweetContent(text: "The Democrats know the 2020 Election will be a fraudulent mess. Will maybe never know who won!", date: "4:46 AM · Aug 15, 2020"),
    TweetContent(text: "I have done more for WOMEN than just about any President in HISTORY! As we celebrate the 100th Anniversary of women’s voting rights, we should build a BEAUTIFUL STATUE in Washington D.C. to honor the many brave women who made this possible for our GREAT COUNTRY...", date: "9:20 AM · Aug 14, 2020"),
    TweetContent(text: "Very strange. Sleepy Joe never takes questions. Also, his reporters have zero drive. Why can’t my reporters behave like that? Something is going on!", date: "4:35 AM · Aug 15, 2020"),
    TweetContent(text: "Everybody does phony books on Donald Trump and Republicans, just like the Fake Dossier, which turned out to be a total fraud perpetrated by Crooked Hillary Clinton and the DNC...", date: "9:17 AM · Aug 14, 2020"),
    TweetContent(text: "Fake News will never change!", date: "6:45 AM · Aug 14, 2020"),
    TweetContent(text: "Big Stock Market Numbers!", date: "5:34 AM · Aug 11, 2020"),
    TweetContent(text: "More Testing, which is a good thing (we have the most in the world), equals more Cases, which is Fake News Gold. They use Cases to demean the incredible job being done by the great men & women of the U.S. fighting the China Plague!", date: "5:33 AM · Aug 11, 2020"),
    TweetContent(text: "Play College Football!", date: "11:13 AM · Aug 10, 2020"),
    TweetContent(text: "Major News Conference in Ten Minutes!", date: "1:05 PM · Aug 8, 2020"),
    TweetContent(text: "Pelosi and Schumer only interested in Bailout Money for poorly run Democrat cities and states. Nothing to do with China Virus! Want one trillion dollars. No interest. We are going a different way!", date: "2:03 PM · Aug 7, 2020"),
    TweetContent(text: "After yesterday’s statement, Sleepy Joe Biden is no longer worthy of the Black Vote!", date: "6:06 AM · Aug 7, 2020"),
    TweetContent(text: "I called the politicization of the China Virus by the Radical Left Democrats a Hoax, not the China Virus itself. Everybody knows this except for the Fake and very Corrupt Media!", date: "5:30 AM · Aug 7, 2020"),
    TweetContent(text: ".@CNN has no sources on the Task Force. Their “sources” are made up, pure fiction! Jim Acosta is a Fake reporter!", date: "7:05 AM · Aug 5, 2020"),
    TweetContent(text: "MAKE AMERICA GREAT AGAIN!", date: "3:30 AM · Aug 5, 2020"),
    TweetContent(text: "People are not happy that players are not standing for our National Anthem!", date: "5:20 AM · Aug 4, 2020"),
    TweetContent(text: "OPEN THE SCHOOLS!!!", date: "8:22 PM · Aug 3, 2020"),
    TweetContent(text: "FAKE NEWS IS THE ENEMY OF THE PEOPLE!", date: "4:49 AM · Aug 3, 2020"),
    TweetContent(text: "My visits last week to Texas and Florida had massive numbers of cheering people gathered along the roads and highways, thousands and thousands, even bigger (by far) than the crowds of 2016. Saw no Biden supporters, and yet some in the Fake News said it was an equal number. Sad!", date: "8:27 AM · Aug 3, 2020"),
    TweetContent(text: "Cases up because of BIG Testing! Much of our Country is doing very well. Open the Schools!", date: "5:03 AM · Aug 3, 2020"),
    TweetContent(text: "With the exception of New York & a few other locations, we’ve done MUCH better than most other Countries in dealing with the China Virus. Many of these countries are now having a major second wave. The Fake News is working overtime to make the USA (& me) look as bad as possible!", date: "4:46 AM · Aug 3, 2020"),
    TweetContent(text: "MAKE AMERICA GREAT AGAIN!", date: "6:56 PM · Aug 1, 2020"),
    TweetContent(text: "Somebody please tell Congressman Clyburn, who doesn’t have a clue, that the chart he put up indicating more CASES for the U.S. than Europe, is because we do MUCH MORE testing than any other country in the World. If we had no testing, or bad testing, we would show very few CASES..", date: "7:08 AM · Jul 31, 2020"),
    TweetContent(text: "Homeland Security is not leaving Portland until local police complete cleanup of Anarchists and Agitators!", date: "8:52 PM · Jul 31, 2020"),
    TweetContent(text: "We have more Cases because we do more Testing. It’s Lamestream Media Gold!", date: "8:08 PM · Jul 31, 2020"),
    TweetContent(text: ".....Our massive testing capability, rather than being praised, is used by the Lamestream Media and their partner, the Do Nothing Radical Left Democrats, as a point of scorn. This testing, and what we have so quickly done, is used as a Fake News weapon. Sad!", date: "7:08 AM · Jul 31, 2020"),
    TweetContent(text: "LAW & ORDER!", date: "4:30 AM · Jul 29, 2020"),
    TweetContent(text: "I was on Air Force One flying to the Great State of Texas, where I just landed. It is AMAZING in watching @FoxNews how different they are from four years ago. Not even watchable. They totally forgot who got them where they are!", date: "9:58 AM · Jul 29, 2020"),
    TweetContent(text: "Looking forward to live sports, but any time I witness a player kneeling during the National Anthem, a sign of great disrespect for our Country and our Flag, the game is over for me!", date: "3:24 AM · Jul 21, 2020"),
    TweetContent(text: "MAKE AMERICA GREAT AGAIN!", date: "4:45 AM · Jul 19, 2020"),
    TweetContent(text: "Corrupt Joe Biden wants to defund our police. He may use different words, but when you look at his pact with Crazy Bernie, and other things, that’s what he wants to do. It would destroy America!", date: "5:24 PM · Jul 17, 2020"),
    TweetContent(text: "LAW & ORDER!", date: "9:18 PM · Jul 13, 2020"),
    TweetContent(text: "The Silent Majority will reign!", date: "6:31 AM · Jul 13, 2020"),
    TweetContent(text: "Does anyone notice that the real Polls, as opposed to the Fake Suppression Polls also used in 2016, are starting to define Sleepy Joe Biden as someone totally ill-equipped to control the Radical Left, Crime, Cancel Culture, or to even come close to me on REBUILDING THE ECONOMY?", date: "6:48 PM · Jul 11, 2020"),
    TweetContent(text: "I LOVE @GoyaFoods!", date: "4:26 PM · Jul 10, 2020"),
    TweetContent(text: "Too many Universities and School Systems are about Radical Left Indoctrination, not Education. Therefore, I am telling the Treasury Department to re-examine their Tax-Exempt Status...", date: "8:49 AM · Jul 10, 2020"),
    TweetContent(text: "Now that we have witnessed it on a large scale basis, and firsthand, Virtual Learning has proven to be TERRIBLE compared to In School, or On Campus, Learning. Not even close! Schools must be open in the Fall. If not open, why would the Federal Government give Funding? It won’t!!!", date: "4:41 AM · Jul 10, 2020"),
    TweetContent(text: "POLITICAL WITCH HUNT!", date: "9:14 AM · Jul 9, 2020"),
    TweetContent(text: "PRESIDENTIAL HARASSMENT!", date: "5:40 AM · Jul 9, 2020"),
    TweetContent(text: "The Supreme Court sends case back to Lower Court, arguments to continue. This is all a political prosecution. I won the Mueller Witch Hunt, and others, and now I have to keep fighting in a politically corrupt New York. Not fair to this Presidency or Administration!", date: "7:38 AM · Jul 9, 2020"),
    TweetContent(text: "For the 1/100th time, the reason we show so many Cases, compared to other countries that haven’t done nearly as well as we have, is that our TESTING is much bigger and better. We have tested 40,000,000 people. If we did 20,000,000 instead, Cases would be half, etc. NOT REPORTED!", date: "5:39 AM · Jul 9, 2020"),
    TweetContent(text: "The highly respected Henry Ford Health System just reported, based on a large sampling, that HYDROXYCHLOROQUINE cut the death rate in certain sick patients very significantly. The Dems disparaged it for political reasons (me!). Disgraceful. Act now @US_FDA @TuckerCarlson @FoxNews", date: "7:32 PM · Jul 6, 2020"),
    TweetContent(text: "Corrupt Joe Biden and the Democrats don’t want to open schools in the Fall for political reasons, not for health reasons! They think it will help them in November. Wrong, the people get it!", date: "1:11 PM · Jul 6, 2020"),
    TweetContent(text: "SCHOOLS MUST OPEN IN THE FALL!!!", date: "11:40 AM · Jul 6, 2020"),
    TweetContent(text: "“Treatment with hydroxychloroquine cut the death rate significantly in sick patients hospitalized with COVID-19 – and without heart-related side-effects, according to a new study published by Henry Ford Health System. In a large-scale retrospective analysis...", date: "11:36 AM · Jul 6, 2020"),
    TweetContent(text: "There is a rise in Coronavirus cases because our testing is so massive and so good, far bigger and better than any other country. This is great news, but even better news is that death, and the death rate, is DOWN. Also, younger people, who get better much easier and faster!", date: "8:44 PM · Jul 2, 2020"),
    TweetContent(text: "Do not believe the Fake News Media. Oklahoma speech had the highest Saturday television ratings in @FoxNews history. @seanhannity dominated T.V. with my interview on Thursday night, more than @CNN & MSDNC COMBINED. These are the real polls, the Silent Majority, not FAKE POLLS!", date: "4:17 AM · Jun 27, 2020"),
    TweetContent(text: "When are the thugs, looters, and anarchists moving out of the so-called “Autonomous Zone” in Seattle? Get going!", date: "10:04 AM · Jun 25, 2020"),
    TweetContent(text: "LAW & ORDER!", date: "12:21 PM · Jun 24, 2020"),
    TweetContent(text: "We broke them up last night, fast. Numerous are, and will be, in prison!", date: "12:21 PM · Jun 23, 2020"),
    TweetContent(text: "PRESIDENTIAL HARASSMENT!", date: "11:41 AM · Jun 22, 2020"),
    TweetContent(text: "If people can go out and protest, riot, break into stores, and create all sorts of havoc, they can also go out and VOTE — and keep our Election Honest. With millions of mail-in ballots being sent out, who knows where they are going, and to whom?", date: "11:10 AM · Jun 22, 2020"),
    TweetContent(text: "RIGGED 2020 ELECTION: MILLIONS OF MAIL-IN BALLOTS WILL BE PRINTED BY FOREIGN COUNTRIES, AND OTHERS. IT WILL BE THE SCANDAL OF OUR TIMES!", date: "4:16 AM · Jun 22, 2020"),
    TweetContent(text: "Informed Dr. Fauci this morning that he has nothing to do with NFL Football. Forced Democrat run Minnesota to bring in the National Guard & end rioting & looting after seeing the destruction & crime in Minneapolis. 100% successful! Waiting to hear from Dem run Washington State...", date: "7:42 PM · Jun 19, 2020"),
    TweetContent(text: "Tony Fauci has nothing to do with NFL Football. They are planning a very safe and controlled opening. However, if they don’t stand for our National Anthem and our Great American Flag, I won’t be watching!!!", date: "8:48 AM · Jun 19, 2020"),
    TweetContent(text: "Why are the Democrats allowed to make fake and fraudulent ads. They should be called out. They did nothing when they had the chance. I have done FAR more than any President in first 3 1/2 years!", date: "7:25 AM · Jun 19, 2020"),
    TweetContent(text: "“THE SILENT MAJORITY IS STRONGER THAN EVER BEFORE.”", date: "6:45 AM · Jun 19, 2020"),
    TweetContent(text: "First thing the anarchists did upon taking over Seattle was “BUILD A WALL”. See, I was ahead of our times!", date: "11:47 AM · Jun 18, 2020"),
    TweetContent(text: "Do you get the impression that the Supreme Court doesn’t like me?", date: "8:10 AM · Jun 18, 2020"),
    TweetContent(text: "THE SILENT MAJORITY IS STRONGER THAN EVER!!!", date: "2:54 PM · Jun 14, 2020"),
    TweetContent(text: "Anarchists just took over Seattle and the Liberal Democrat Governor just said he knows “nothing about that”.", date: "10:24 AM · Jun 11, 2020"),
    TweetContent(text: "Our great National Guard Troops who took care of the area around the White House could hardly believe how easy it was. “A walk in the park”, one said. The protesters, agitators, anarchists (ANTIFA), and others, were handled VERY easily by the Guard, D.C. Police, & S.S. GREAT JOB!", date: "5:49 AM · Jun 11, 2020"),
    TweetContent(text: "LAW & ORDER!", date: "7:21 PM · Jun 10, 2020"),
    TweetContent(text: "Incredible! @FoxNews just took Congressional Hearing off the air just prior to important witness statements. More like CNN!!! Fox is lost!!", date: "7:56 AM · Jun 10, 2020"),
    TweetContent(text: "THE REAWAKENING OF AMERICA!", date: "6:41 AM · Jun 9, 2020"),
    TweetContent(text: "Buffalo protester shoved by Police could be an ANTIFA provocateur. 75 year old Martin Gugino was pushed away after appearing to scan police communications in order to black out the equipment. @OANN I watched, he fell harder than was pushed. Was aiming scanner. Could be a set up?", date: "5:34 AM · Jun 9, 2020"),
    TweetContent(text: "LAW & ORDER, NOT DEFUND AND ABOLISH THE POLICE. The Radical Left Democrats have gone Crazy!", date: "5:33 AM · Jun 8, 2020"),
    TweetContent(text: "Colin Powell was a pathetic interview today on Fake News CNN. In his time, he was weak & gave away everything to everybody - so bad for the USA. Also got the “weapons of mass destruction” totally wrong, and you know what that mistake cost us? Sad! Only negative questions asked.", date: "8:42 PM · Jun 7, 2020"),
    TweetContent(text: "If I wasn’t constantly harassed for three years by fake and illegal investigations, Russia, Russia, Russia, and the Impeachment Hoax, I’d be up by 25 points on Sleepy Joe and the Do Nothing Democrats. Very unfair, but it is what it is!!!", date: "3:41 PM · Jun 7, 2020"),
    TweetContent(text: "I built the greatest economy in the World, the best the U.S. has ever had. I am doing it again!", date: "3:08 PM · Jun 7, 2020"),
    TweetContent(text: "I have just given an order for our National Guard to start the process of withdrawing from Washington, D.C., now that everything is under perfect control. They will be going home, but can quickly return, if needed. Far fewer protesters showed up last night than anticipated!", date: "6:53 AM · Jun 7, 2020"),
    TweetContent(text: "...We should be standing up straight and tall, ideally with a salute, or a hand on heart. There are other things you can protest, but not our Great American Flag - NO KNEELING!", date: "1:08 PM · Jun 5, 2020"),
    TweetContent(text: "Oh no, the Dems are worried again. The only one that can kill this comeback is Sleepy Joe Biden!", date: "5:54 AM · Jun 5, 2020"),
    TweetContent(text: "Really Big Jobs Report. Great going President Trump (kidding but true)!", date: "5:33 AM · Jun 5, 2020"),
    TweetContent(text: "YOU DON’T BURN CHURCHES IN AMERICA!", date: "3:28 PM · Jun 4, 2020"),
    TweetContent(text: "LAW & ORDER!", date: "4:19 AM · Jun 3, 2020"),
    TweetContent(text: "Get tough police!", date: "3:47 AM · Jun 3, 2020"),
    TweetContent(text: "Washington, D.C., was the safest place on earth last night!", date: "4:22 PM · Jun 2, 2020"),
    TweetContent(text: "NYC, CALL UP THE NATIONAL GUARD. The lowlifes and losers are ripping you apart. Act fast! Don’t make the same horrible and deadly mistake you made with the Nursing Homes!!!", date: "8:10 AM · Jun 2, 2020"),
    TweetContent(text: "D.C. had no problems last night. Many arrests. Great job done by all. Overwhelming force. Domination. Likewise, Minneapolis was great (thank you President Trump!).", date: "6:19 AM · Jun 2, 2020"),
    TweetContent(text: "Fake News. Couldn’t hear them during speech!", date: "8:57 PM · Jun 1, 2020"),
    TweetContent(text: "FAKE NEWS!", date: "5:09 PM · May 31, 2020"),
    TweetContent(text: "Our National Guard stopped them cold last night. Should have been called up sooner!", date: "3:08 PM · May 31, 2020"),
    TweetContent(text: "The United States of America will be designating ANTIFA as a Terrorist Organization.", date: "9:23 AM · May 31, 2020"),
    TweetContent(text: "Here we go again. Fake News @CNN is blaming RUSSIA, RUSSIA, RUSSIA. They are sick losers with VERY bad ratings! P.S. Can’t blame China because they need the cash?", date: "10:04 AM · May 30, 2020"),
    TweetContent(text: "CHINA!", date: "6:01 AM · May 29, 2020"),
    TweetContent(text: "Twitter is doing nothing about all of the lies & propaganda being put out by China or the Radical Left Democrat Party. They have targeted Republicans, Conservatives & the President of the United States. Section 230 should be revoked by Congress. Until then, it will be regulated!", date: "4:10 AM · May 29, 2020"),
    TweetContent(text: "....These THUGS are dishonoring the memory of George Floyd, and I won’t let that happen. Just spoke to Governor Tim Walz and told him that the Military is with him all the way. Any difficulty and we will assume control but, when the looting starts, the shooting starts. Thank you!", date: "9:53 PM · May 28, 2020"),
    TweetContent(text: "All over the World the CoronaVirus, a very bad “gift” from China, marches on. Not good!", date: "7:34 AM · May 28, 2020"),
    TweetContent(text: "We have informed both India and China that the United States is ready, willing and able to mediate or arbitrate their now raging border dispute. Thank you!", date: "4:21 AM · May 27, 2020"),
    TweetContent(text: "OBAMAGATE!", date: "8:06 PM · May 24, 2020"),
]


# SpeakIn (iOS mobile app)
HackUmass IV Project
Team members: Alice Yang, Gunnar Horve, Irene Woo, Atal Akbari
Note: Alice's xcode did not work on her laptop so her commits are on Gunnar Horve's Github account.

## Inspiration
Journaling is a proven therapeutic process that everyone can benefit from. But, many people are too tired and forgetful at the end of the day to write journal entries every day. We developed SpeakIn, an iOS app that lets you speak into a microphone and transcribe what you say into an electronic journal on your phone.

## What it does
SpeakIn sends a once-daily push notification to journal.  Think of it is a blog, but with less commitment.  This app listens to you, and records and saves your thoughts.  SpeakIn tracks tracks these thoughts and transforms them into emotional scores with sentiment analysis.

## How we built it
1. Used Xcode's MVC for system architecture 
2. Used swift3's  AVAudioengine library to implement speech functionality 
3. Used Realm to create data structures for storage of journal entries
4. Used Indico to calculate positivity of journal entries
5. Used swift charts to graph the positivity of journal entries over time

## Challenges
+ Since Swift 3.0 was released a month ago, it has not many tutorials.
+ Our first project was an abject failure, so we had 20 hours to complete this one.

## Accomplishments that we're proud of
We have a working app, that accomplishes our MVP.  This almost never happens at a hackathon.  Two of our four member had never worked with Swift but made significant contributions.

## What we learned
Pair programming can be effective (especially at night when you are tired)! We also learned how to communicate effectively with people we've just meet.

## What's next for SpeakIn
+Attaching it to Amazon Echo.
+Create graphs for the other emotions (fear, sadness, etc) we collected.


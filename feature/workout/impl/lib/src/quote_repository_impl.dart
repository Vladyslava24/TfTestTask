import 'package:core/core.dart';
import 'package:workout_data/data.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  static const KEY_LAST_QUOTE_INDEX = "KEY_LAST_QUOTE_INDEX";

  final PrefsStorage prefsStorage;

  QuoteRepositoryImpl(this.prefsStorage);

  @override
  MapEntry<String,String> getNextQuote() {
    int index = prefsStorage.prefs.getInt(KEY_LAST_QUOTE_INDEX) ?? 0;
    if (index >= _quotes.length) {
      index = 0;
    } else {
      index++;
    }
    _saveCurrentIndex(index);
    return _quotes.entries.elementAt(index);
  }

  _saveCurrentIndex(int index) async {
    await prefsStorage.prefs.setInt(KEY_LAST_QUOTE_INDEX, index);
  }
}


final _quotes =
  {
    "I hated every minute of training, but I said, ‘Don’t quit. Suffer now and live the rest of your life as a champion.": "Muhammad Ali",
    "It is not the size of a man but the size of his heart that matters.": "Evander Holyfield",
    "Wisdom is always an overmatch for strength.": "Phil Jackson",
    "Do not let what you can not do interfere with what you can do.": "John Wooden",
    "You can’t put a limit on anything. The more you dream, the farther you get.": "Michael Phelps",
    "Excellence is the gradual result of always striving to do better.": "Pat Riley",
    "Make each day your masterpiece.": "John Wooden",
    "Without self-discipline, success is impossible, period.": "Lou Holtz",
    "If you don’t have confidence, you’ll always find a way not to win.": "Carl Lewis",
    "If you can believe it, the mind can achieve it.": "Ronnie Lott",
    "Your biggest opponent isn’t the other guy. It’s human nature.": "Bobby Knight",
    "You find that you have peace of mind and can enjoy yourself, get more sleep, and rest when you know that it was a one hundred percent effort that you gave–win or lose.": "Gordie Howe",
    "Always make a total effort, even when the odds are against you.": "Arnold Palmer",
    "Leadership, like coaching, is fighting for the hearts and souls of men and getting them to believe in you.": "Eddie Robinson",
    "I never left the field saying I could have done more to get ready and that gives me peace of mind.": "Peyton Manning",
    "The mind is the limit. As long as the mind can envision the fact that you can do something, you can do it, as long as you really believe 100 percent.": "Arnold Schwarzenegger",
    "When you win, say nothing, when you lose, say less.": "Paul Brown",
    "The principle is competing against yourself. It’s about self-improvement, about being better than you were the day before.": "Steve Young",
    "If you fail to prepare, you’re prepared to fail.": "Mark Spitz",
    "Champions keep playing until they get it right.": "Billie Jean King",
    "Good is not good when better is expected.": "Vin Scully",
    "Continuous effort — not strength or intelligence — is the key to unlocking our potential.": "Liane Cardes",
    "Most people never run far enough on their first wind to find out they’ve got a second.": "William James",
    "Make sure your worst enemy doesn’t live between your own two ears.": "Laird Hamilton",
    "Persistence can change failure into extraordinary achievement.": "Marv Levy",
    "Never give up, never give in, and when the upper hand is ours, may we have the ability to handle the win with the dignity that we absorbed the loss.": "Paul “Bear” Bryant",
    "An athlete cannot run with money in his pockets. He must run with hope in his heart and dreams in his head.": "Emil Zatopek",
    "The five S’s of sports training are: stamina, speed, strength, skill, and spirit; but the greatest of these is spirit.": "Ken Doherty",
    "One man practicing sportsmanship is far better than 50 preaching it.": "Knute Rockne",
    "You have to do something in your life that is honorable and not cowardly if you are to live in peace with yourself.": "Larry Brown",
    "When you’re riding, only the race in which you’re riding is important.": "Bill Shoemaker",
    "Age is no barrier. It’s a limitation you put on your mind.": "Jackie Joyner-Kersee",
    "I always felt that my greatest asset was not my physical ability, it was my mental ability.": "Bruce Jenner",
  };

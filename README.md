# Gilded Rose Kata Tech Test

## Contents
* [About](#About)
* [Technologies used](#Technologies)
* [The brief](#TheBrief)
* [Installation](#Installation)
* [RSpec Tests](#RSpec)

## <a name="About">About</a>:

I worked on this tech test for two days. First of all, I read through the brief carefully to then start having a look at the legacy code, which consisted of two classes, GildedRose and Item. The first one presented a 43 lines long method, a massive if/else statement. I didn't spend too much time trying to decipher it, but I played around with the code in the console based on the info I had and I wrote down some diagramming. The next step was to write the smallest tests possible and I didn't stop writing them until I thought I had covered all scenarios, to then get all my tests green with the legacy code. I then started refactoring, bearing in mind that the Item class must not have been touched. With the first refactoring I created small private methods which helped me trim down the long and intricate method, made sure all my tests passed, and then I did some more refactoring by making use of small classes whose only responsibility was to update the quality of an 'x' item.

## <a name="ChallengeSpecs">The brief</a>:

*"Hi and welcome to team Gilded Rose. As you know, we are a small inn with a prime location in a prominent city run by a friendly innkeeper named Allison. We also buy and sell only the finest goods. Unfortunately, our goods are constantly degrading in quality as they approach their sell by date.

We have a system in place that updates our inventory for us. It was developed by a no-nonsense type named Leeroy, who has moved on to new adventures. Your task is to add the new feature to our system so that we can begin selling a new category of items. First an introduction to our system:

- All items have a SellIn value which denotes the number of days we have to sell the item.

- All items have a Quality value which denotes how valuable the item is.

At the end of each day our system lowers both values for every item. Pretty simple, right? Well this is where it gets interesting:

- Once the sell by date has passed, Quality degrades twice as fast
- The Quality of an item is never negative
- “Aged Brie” actually increases in Quality the older it gets
- The Quality of an item is never more than 50
- “Sulfuras”, being a legendary item, never has to be sold and does not decrease in Quality
- “Backstage passe”, like aged brie, increases in Quality as its SellIn value approaches; Quality increases by 2 when there are 10 days or less and by 3 when there are 5 days or less but Quality drops to 0 after the concert

We have recently signed a supplier of conjured items. This requires an update to our system:

* “Conjured” items degrade in Quality twice as fast as normal items

Feel free to make any changes to the UpdateQuality method and add any new code as long as everything still works correctly. However, do not alter the Item class or Items property as those belong to the goblin in the corner who will insta-rage and one-shot you as he doesn’t believe in shared code ownership (you can make the UpdateQuality method and Items property static if you like, we’ll cover for you)."*

---

## <a name="Installation">Installation</a>
* To clone the repository:
```shell
$ git clone https://github.com/enonnai/gilded-rose
$ cd gilded-rose
$ bundle install
```

## <a name="Rspec">RSpec Tests</a>
* To run the tests:
```shell
$ cd gilded-rose
$ rspec
```

## <a name="Technologies">Technologies used</a>
* Ruby
* RSpec

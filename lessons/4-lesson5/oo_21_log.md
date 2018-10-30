### Class Structure and Style

- Add 2 subclasses(`Human` and `Npc`) to `class Player`
  - remove `:species` attribute
  - decouple `deal_to` from both `_make_choice` methods, then move these two methods in its own class.
  - make a new method `_turn` to encapsulate the logic of `_make_choice` and `deal_to`
  - move `ask_for_move` from `Game` to `Player`
  - integrate `display_all_cards` into `display_cards` while moving part of the displaying logic into `Player`

- simplify `readjust_cards_value`'s logic expression.

- change name of `big_ace_count` to more appropriate `large_ace_count`

### Functionality & UX

About the game cycle. I never played real 21 game, so sorry if I against the rule.

My initially thought is while the cards in each players' hands are changing, my willing of whether to be more conservative or more risky may also change.

For example:

1st turn:

- Human: `9` and `10` # total == 19    
- Npc: `[unknown]` and `10` # total > 10

In this situation, I think it's more likely I would win. So I choose **stay**.

2nd turn:

Maybe npc's total < 17, so it has to choose **hit**

- Npc: `[unknown]`, `10`, `10` # total > 20

Now I know next turn Npc must choose stay(total > 17) and it didn't get busted last turn so the `[unknown]` must be `A`, so it's total is 21, right on the winning point. If I don't wanna lose, there's only one choice -- taking the risk of asking for additional card and hope it would reach a tie.

---

Actually, the description "evaluate your cards in hand" is not accurate. It might have been "evaluate the situation".

1. Show the winning score at the beginning of the game.
2. Bug about can't recognize risk and winner correctly:
  The problem is because my previous version used only `'X'` as the mark for human player. And there's a method `human_choices` which returns all the cells human has taken:

```ruby
def human_choices
  cells.select { |_, owner| owner == 'X' }.keys
end
```

Through my previous testing process I only chose `'X'` as my mark, this disguised the bug. When user chooses mark other than `'X'`, it cannot get the correct choices that the use made, therefore it cannot figure out the correct winner and possible risk.

I fixed this bug, now it works for customized mark.

3. Improved `play_again?` method to only accept valid meaningful input.

4. Improved game UI, now the board will stick to the top of the screem.

5. Changed `system 'clear'` to `system('clear') || system('cls')`

6. Removed `require 'pry'` from the code.

7. Change all methods which end with `_com` to full word 'combination'

8. Improved the logic expression in method `someone_won_a_round?`

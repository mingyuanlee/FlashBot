## An Arbitrage Idea (Young & Simple)

Assume there is a Token A / Token B pair, which exists on both DEX 1 and DEX 2. We call the two pairs Pair 1 and Pair 2.<br>

### Trading Strategy

1. Borrow x Token B from Pair 1, and pay back some debt y in Token A.
2. Sell x Token B on Pair 2, and get some Token A in amount of y'.
3. If y' > y then we get a profit of y' - y.

### Tables to show how amounts change

1. Initial state

|         | Pair 1 | Pair 2 |
|---------|--------|--------|
| Token A | $a_1$     | $a_2$     |
| Token B | $b_1$     | $b_2$     |

2. After borrowing x Token B from Pair 1

|         | Pair 1           | Pair 2 |
|---------|------------------|--------|
| Token A | $a_1+\Delta a_1$ | $a_2-\Delta a_2$     |
| Token B | $b_1 - x$        | $b_2 + x$  |

### Set up some math equations

From $x * y = k$, we know that:

$$ (a_1+\Delta a_1) * (b_1 - x) = a_1 * b_1 $$

$$ (a_2-\Delta a_2) * (b_2 + x) = a_2 * b_2 $$

Since we are interested in $\Delta a_1$ and $\Delta a_2$, we extract them:

$$ \Delta a_1 = {a_1 x \over b_1 - x} $$

$$ \Delta a_2 = {a_2 x \over b_2 + x} $$

Thus, our profit will be:

$$ f(x) = \Delta a_2 - \Delta a_1 $$

### Use calculus to find maximum profit

$$ f'(x) = {a_2b_2 \over (b_2 + x)^2} - {a_1b_1 \over (b_1 - x)^2} $$

Let $ f'(x) = 0 $, and do some arithmetic:

$$ (a_1b_1 - a_2b_2)x^2 + 2b_1b_2(a_1+a_2)x + b_1b_2(a_1b_2 - a_2b_1) = 0 $$

This is a quadratic equation, so we just need to find the root and verify it's the maximum. Then we get the x we can borrow which maximizes our profit.

### What's in the contract now

1. Added pure functions to calculate the borrow amount x

### Real problems

1. Can these two transactions be atomic? What if the amount changes in the concurrency?
2. How do we compete against other bots?

### Comments

I know this is a naive model, but most brilliant models come from naive model. <br>
Let's keep learning and thinking!
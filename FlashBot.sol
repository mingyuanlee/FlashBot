pragma solidity ^0.7.0;

struct Pairs {
    uint256 a1; 
    uint256 a2;
    uint256 b1;
    uint256 b2;
}

contract FlashBot {

  /// calculate the borrow amount to maximize profit
  function calcBorrowAmount(Pairs memory pairs) internal pure returns (uint256 amount) {

    uint256 min1 = pairs.a1 < pairs.b1 ? pairs.a1 : pairs.b1;
    uint256 min2 = pairs.a2 < pairs.b2 ? pairs.a2 : pairs.b2;
    uint256 min = min1 < min2 ? min1 : min2;

    // choose appropriate number to divide based on the minimum number
    // this step is used to prevent overflows
    // so we divide d first, the multiply it back
    uint256 d;
    if (min > 1e24) {
        d = 1e20;
    } else if (min > 1e23) {
        d = 1e19;
    } else if (min > 1e22) {
        d = 1e18;
    } else if (min > 1e21) {
        d = 1e17;
    } else if (min > 1e20) {
        d = 1e16;
    } else if (min > 1e19) {
        d = 1e15;
    } else if (min > 1e18) {
        d = 1e14;
    } else if (min > 1e17) {
        d = 1e13;
    } else if (min > 1e16) {
        d = 1e12;
    } else if (min > 1e15) {
        d = 1e11;
    } else {
        d = 1e10;
    }

    (int256 a1, int256 a2, int256 b1, int256 b2) = (int256(pairs.a1 / d), int256(pairs.a2 / d), int256(pairs.b1 / d), int256(pairs.b2 / d));

    int256 a = a1 * b1 - a2 * b2;
    int256 b = 2 * b1 * b2 * (a1 + a2);
    int256 c = b1 * b2 * (a1 * b2 - a2 * b1);

    (int256 x1, int256 x2) = solveEquation(a, b, c);

    amount = (x1 > 0 && x1 < b1 && x1 < b2) ? uint256(x1) * d : uint256(x2) * d;
  }

  /// find root of quadratic equation: ax^2 + bx + c = 0
  function solveEquation(int256 a, int256 b, int256 c) internal pure returns (int256 x1, int256 x2) {
      int256 m = b**2 - 4 * a * c;
      // m < 0, no real solution
      require(m > 0, 'No root');

      int256 sqrtM = int256(sqrt(uint256(m)));
      x1 = (-b + sqrtM) / (2 * a);
      x2 = (-b - sqrtM) / (2 * a);
  }

  // this is the Babylonian Method to find square root
  function sqrt(uint256 x) returns (uint256 y) {
    uint z = (x + 1) / 2;
    y = x;
    while (z < y) {
        y = z;
        z = (x / z + z) / 2;
    }
  }

}
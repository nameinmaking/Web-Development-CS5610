defmodule CalcTest do
  use ExUnit.Case
  doctest Calc

  # test cases for addition operation
  test "Addition" do
    assert Calc.eval("2 + 3") == 5
    assert Calc.eval("2+3") == 5
  end

  # test cases for multiplication operation
  test "Multiplication" do
    assert Calc.eval("5 * 1") == 5
    assert Calc.eval("5*1") == 5
  end

  # test cases for division operation
  test "Division" do
    assert  Calc.eval("20 / 4") == 5
    assert  Calc.eval("20/4") == 5
  end

  # test cases for complex expression evaluation
  test "Complex Expressions" do
    assert Calc.eval("24 / 6 + (5 - 4)") == 5
    assert Calc.eval("24/6+(5-4)") == 5
    assert Calc.eval("3+4*5/6") == 6
    assert Calc.eval("(300+23)*(43-21)/(84+7) ") == 78
    assert Calc.eval("(4+8)*(6-5)/((3-2)*(2+2)) ") == 3
  end

  # test cases for BODMAS rules
  test "BODMAS test" do
    assert Calc.eval("1 + 3 * 3 + 1") == 11
    assert Calc.eval("1+3*3+1") == 11
  end

  # test cases for Exponentiation operation
  test "Exponentiation" do
    assert Calc.eval("2 ^ 4") == 16.0
    assert Calc.eval("2^4") == 16.0
  end

  # @tag watching: true
  # test "the fail" do
  #   assert 1 + 2 == 2
  # end
end

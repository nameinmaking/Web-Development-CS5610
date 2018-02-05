defmodule Calc do

  #  main fucntion for the program
  def main() do
    expr = IO.gets("")
    IO.puts eval(expr)
    main()
  end

  #  fucntion to evaluate the expression
  def eval(expr) do
    expr
    |> String.trim()            # remove the escape sequence
    |> String.codepoints()      # tokenize the string
    |> delete_all_spaces([])
    |> Enum.reverse             # since tail recurrsion is used
    |> tokenize([])             # for no spacing input
    |> infix_to_postfix([],[])
    |> evaluate_postfix([])
  end

  # function to delete the spaces (when a space is encountere => don't add it)
  defp delete_all_spaces([head|tail],new_list) when head === " " do
    	delete_all_spaces(tail,new_list)
  end

  # space delete fucntion to process when no space is encountered
	defp delete_all_spaces([head | tail], new_list) do
    delete_all_spaces(tail,[head | new_list])
  end

  # space delete function, stop condition
  defp delete_all_spaces([], new_list) do
    new_list
  end

  # fucntion for tokenization of expression, handling without space
  # expressions also
  defp tokenize(expr,list) do
    special_chars = ["+" , "-", "*", "/", "^","(",")"]

    cond do
      # when the expression is evaluated
      length(expr) == 0 ->
        list

      # when a speical character is encountered
      Enum.member?(special_chars, Enum.at(expr, 0))->
        token = Enum.at(expr,0)
        new_expr = Enum.drop(expr,1)
        tokenize(new_expr,list ++ [token])

    # when a number is encountered in the expression
     true ->
       token = Enum.at(list,-1)
       if (token != nil) do
         if !(String.contains? token, special_chars) do
           token = Enum.at(list,-1)
           new_expr = Enum.drop(expr,1)
           new_list = Enum.drop list,-1
           tokenize(new_expr, new_list ++ [Enum.join([token, Enum.at(expr, 0)])])
         else
           token = Enum.at(expr,0)
           new_expr = Enum.drop(expr,1)
           tokenize(new_expr,list ++ [token])
         end
      else
        token = Enum.at(expr,0)
        new_expr = Enum.drop(expr,1)
        tokenize(new_expr,list ++ [token])
      end
    end
  end

  # function to convert an infix expression to a postfix expression
  defp infix_to_postfix(expr, op_list, accumulator) do
    # IO.write(:stdio, expr)
    operators = ["+" , "-", "*", "/", "^"]

    cond do

      length(expr) == 0 ->
        if length(op_list) > 0 do
          infix_to_postfix(expr, Enum.drop(op_list, -1), accumulator ++ Enum.take(op_list, -1))
        else
          accumulator
        end

      # c1 -- marker
      # When an operator is encountered
      Enum.member?(operators, Enum.at(expr, 0))->

        new_expr = Enum.drop(expr,1)
        op = Enum.at(expr,0)

        if length(op_list) == 0 do
          infix_to_postfix(new_expr,op_list ++ [op],accumulator)
        else
          cond do
          # check precedence of the current token and operators in the Stack

          # same precedence
            (op == "^" && Enum.at(op_list,-1) == "^") ||
            (op == "/" && Enum.at(op_list,-1) == "/") ||
            (op == "/" && Enum.at(op_list,-1) == "*") ||
            (op == "*" && Enum.at(op_list,-1) == "/") ||
            (op == "*" && Enum.at(op_list,-1) == "*") ||
            (op == "+" && Enum.at(op_list,-1) == "+") ||
            (op == "+" && Enum.at(op_list,-1) == "-") ||
            (op == "-" && Enum.at(op_list,-1) == "-") ||
            (op == "-" && Enum.at(op_list,-1) == "+") ->
              infix_to_postfix(expr,Enum.drop(op_list,-1), accumulator ++ Enum.take(op_list,-1))

            # lower precedence
            (Enum.member?(["*","/","+","-"],op) && Enum.at(op_list,-1) == "^") ||
            (Enum.member?(["+","-"],op) && Enum.member?(["*","/","^"],Enum.at(op_list,-1))) ->
              infix_to_postfix(expr,Enum.drop(op_list, -1), accumulator ++ Enum.take(op_list,-1))

          # else || all the case with higher precedence
          true ->
            infix_to_postfix(new_expr, op_list ++ [op], accumulator)   # Note: Append, don't prepend
          end
        end

      # c1 -- marker
      # If the scanned character is an ‘(‘, push it to the stack
      Enum.at(expr,0) == "(" ->
        op = "("
        new_expr = Enum.drop(expr,1)
        infix_to_postfix(new_expr, op_list ++ [op], accumulator)   # Note: Append, don't prepend

      # c1 -- marker
      # If the scanned character is an ‘)’, pop
      Enum.at(expr,0) == ")" ->
        new_expr = Enum.drop(expr, 1)
        new_accumulator = pop(op_list, accumulator)
        infix_to_postfix(new_expr, Enum.at(new_accumulator,0), Enum.at(new_accumulator, 1))

      # when a numerical value is encountered
      true->
        new_expr = Enum.drop(expr, 1)
        num = String.to_integer(Enum.at(expr,0))
        infix_to_postfix(new_expr, op_list, accumulator ++ [num])
      end
    end

  # function to pop and output from the stack until an ‘(‘ is encountered.
  defp pop(stack,accumulator) do
    if Enum.at(stack, -1) == "(" do
      [Enum.drop(stack, -1), accumulator]
    else
      pop(Enum.drop(stack, -1), accumulator ++ Enum.take(stack, -1))
    end
  end

  # function to evaluate the postfix expression
  defp evaluate_postfix(expr,stack) do
    cond do
      length(expr) == 0 ->
        Enum.at(stack,0)      # pop the result from the Stack

      not Enum.member?(["+","-","*","/","^"],Enum.at(expr,0)) ->
        new_expr = Enum.drop(expr,1)
        num = Enum.at(expr,0)
        evaluate_postfix(new_expr,stack ++ [num])   # push it to the Stack

     true->
       first = Enum.at(stack,-2)
       second = Enum.at(stack,-1)

       op = Enum.at(expr,0)

       new_expr = Enum.drop(expr,1)
       temp_stack = Enum.drop(stack,-1)
       new_stack = Enum.drop(temp_stack,-1)

       result =
         case op do
           "^" ->
             :math.pow(first,second)
           "/" ->
             div(first,second)
           "*" ->
             first * second
           "+" ->
             first + second
           "-" ->
             first - second
         end
       evaluate_postfix(new_expr, new_stack ++ [result])
    end
  end
end

# Attribution:
# Infix to Postfix algorithm      : https://www.geeksforgeeks.org/stack-set-2-infix-to-postfix/
# Evaluation of Postfix Expression: https://www.geeksforgeeks.org/stack-set-4-evaluation-postfix-expression/
# Practice Examples               : https://cs.nyu.edu/courses/Fall12/CSCI-GA.1133-002/notes/InfixToPostfixExamples.pdf
# Example snippets for usage      : https://elixir-lang.org/docs.html

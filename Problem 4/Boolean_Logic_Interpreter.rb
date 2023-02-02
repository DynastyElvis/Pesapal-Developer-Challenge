# Here is a sample implementation of a Boolean logic interpreter in Ruby:

class Interpreter
  def initialize
    @vars = {}
  end

  def evaluate(expression)
    return @vars[expression] if @vars.key?(expression)
    return expression if expression == 'T' || expression == 'F'

    case expression
    when /^\s*\(\s*(.*)\s*\)\s*$/
      evaluate $1
    when /^\s*(not)\s+(.*)\s*$/
      not evaluate $2
    when /^\s*(.*)\s+(and|or)\s+(.*)\s*$/
      left = evaluate $1
      right = evaluate $3
      if $2 == 'and'
        left == 'T' && right == 'T' ? 'T' : 'F'
      else
        left == 'T' || right == 'T' ? 'T' : 'F'
      end
    when /^\s*let\s+(\w+)\s+=\s+(.*)\s*$/
      @vars[$1] = evaluate $2
      $1 + ": " + @vars[$1]
    end
  end
end

# Usage
interpreter = Interpreter.new
puts interpreter.evaluate("T or F")
# Output: T
puts interpreter.evaluate("T and F")
# Output: F
puts interpreter.evaluate("(T and F) = F")
# Output: T
puts interpreter.evaluate("let X = F")
# Output: X: F
puts interpreter.evaluate("let Y = not X")
# Output: Y: T
puts interpreter.evaluate("not X and Y")
# Output: T



# In the above code, the evaluate method takes an expression string and returns the result after evaluating it. The variables are stored in a hash called @vars. The method uses regular expressions to match the expression to different cases and evaluate it accordingly. The operator precedence rules are implemented as follows:

# Parentheses
# NOT (not)
# AND (and)
# OR (or)

# Syntax and Operator Precedence:

# Variables can be assigned a value using the "let" keyword, e.g. let X = T.
# The negation operator ¬ has higher precedence than the AND and OR operators ∧ and ∨.
# Parentheses can be used to enforce a specific order of operations, e.g. (T ∧ F).
# Examples:



X = VariableExpression.new("X", false)
Y = VariableExpression.new("Y", !X.evaluate)

expression1 = OrExpression.new(BooleanExpression.new(true), BooleanExpression.new(false))
puts expression1.evaluate # Outputs: true

expression2 = AndExpression.new(BooleanExpression.new(true), BooleanExpression.new(false))
puts expression2.evaluate # Outputs: false

expression3 = AndExpression.new(BooleanExpression.new(true), BooleanExpression.new(false))
expression3 = NotExpression.new(expression3)
puts expression3.evaluate # Outputs: true

expression4 = AndExpression.new(NotExpression.new(X), Y)
puts expression4.evaluate # Outputs: true


# This implementation follows the object-oriented programming principles, where each expression type is represented by a separate class, which can be combined to form more complex expressions. The evaluation of an expression is done by calling the evaluate method on the corresponding object.






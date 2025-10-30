def calculate_parentheses_value(expression):
    total_value = 0
    current_value = 0
    depth = 0
    add_mode = False  # To differentiate between concatenation and nesting

    for char in expression:
        if char == '(':
            if add_mode and depth == 0:
                total_value += current_value
                current_value = 0
            depth += 1
            add_mode = True
        elif char == ')':
            if depth > 0:
                depth -= 1
                if depth == 0:
                    current_value = max(current_value * 2, 1)
                    add_mode = False
            else:
                current_value += 1
            if depth == 0:
                total_value += current_value
                current_value = 0

    return total_value

# Test the function with examples:
examples = [
    "()",
    "(())",
    "((()))",
    "()()",
    "(())()",
    "()(()()()())()",
    "((()())(()()))"
]

for expr in examples:
    print(f"{expr} = {calculate_parentheses_value(expr)}")

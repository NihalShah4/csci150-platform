-- Seed script: 20 exercises per module (180 total), original content

-- written in the style/order of Starting Out with Python (Gaddis), not copied from it.

insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 1, 'Escape artist', 'Write a single print() statement that outputs the exact line below, including the double quotes and the apostrophe:
She said, "It''s already done!"
Think about which quote characters Python lets you use here before you start typing.', '# Print the exact line above, quotes and all
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 2, 'Order of operations I', 'Before writing any code, work out on paper what this expression equals: 4 + 3 * 2 - 6 / 2
Then write one print() statement that prints the result of that exact expression. Run it to check your prediction.', '# Print the result of: 4 + 3 * 2 - 6 / 2
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 3, 'Order of operations II', 'Predict the result of this expression first, then print it: (2 + 3) * (4 - 1) ** 2
Pay attention to parentheses and exponents.', '# Print the result of: (2 + 3) * (4 - 1) ** 2
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 4, 'Match the pattern: triangle', 'Using only print() statements, reproduce this exact triangle, one row per print() call:
*
**
***
****', '# Print the four rows above
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 5, 'Match the pattern: inverted triangle', 'Using only print() statements, reproduce this exact shape, one row per print() call:
****
***
**
*', '# Print the four rows above
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 6, 'Reorder the story', 'The four print() statements below are each correct on their own, but they are in the wrong order, so the program currently prints a confusing message. Rearrange the lines (do not change their text) so it prints a coherent story from start to finish.', 'print("Then I ran it and saw the output on screen.")
print("First, I opened my code editor.")
print("Finally, I fixed the bug and celebrated.")
print("Next, I typed my very first print statement.")
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 7, 'Spot the bug: typo', 'The program below should print two lines, but it has a typo that causes an error. Fix it so both lines print correctly.', 'print("Loading Pynt...")
prin("Ready to code.")
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 8, 'Spot the bug: quotes', 'The program below should print a sentence containing an apostrophe, but the quote marks are mismatched and it will not run. Fix it so it runs and prints correctly.', 'print(''Don''t stop coding.'')
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 9, 'Tabs and newlines', 'Using a single print() statement with escape sequences (\t and \n), produce output that looks like this exactly (a tab between the two words on the first row, then a new line before the second row):
Name	Score
Ada	100', '# One print() statement, using \t and \n
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 10, 'Automatic spacing', 'Using a single print() call with a comma between two words (not the + operator), produce this exact output: coffee break
Do it without typing the space character yourself, let print() add it.', '# print() with a comma between two words
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 11, 'Custom separator', 'Using print()''s sep argument, join the three words "red", "green", "blue" into one line separated by " - " so the output reads exactly: red - green - blue', '# print("red", "green", "blue", sep=...)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 12, 'Custom end', 'Using two separate print() statements and the end argument, make them appear on the SAME output line, reading exactly: Loading... Done', '# Two print() calls, first one needs end=...
print("Loading...")
print("Done")
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 13, 'Concatenate literals', 'Using the + operator to join string literals (no variables), print exactly: Py + thon = Python', '# Build the line using + between string literals
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 14, 'Repeat without retyping', 'Using the * operator on a string literal, print "ha" repeated six times in a row with nothing between them: hahahahahaha', '# Use string repetition with *, do not just type it out
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 15, 'Exact spacing: receipt', 'Using print() statements and spaces only, reproduce this exact two-line, right-aligned layout:
 Item  Price
Apple   1.00', '# Match the spacing exactly
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 16, 'Debug the parentheses', 'The program below is missing a closing parenthesis and will not run. Fix it.', 'print("Almost working"
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 17, 'Debug the string', 'The program below has an unterminated string literal and will not run. Fix it.', 'print("This string never closes)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 18, 'Predict then verify: modulus', 'Before running anything, work out what 17 % 5 equals on paper. Then write one print() statement for that exact expression and check your prediction.', '# Print the result of: 17 % 5
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 19, 'Predict then verify: division', 'Predict what 7 / 2 will print (think about whether Python''s / gives a whole number or a decimal), then print that exact expression to check.', '# Print the result of: 7 / 2
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('intro-computers-programming', 20, 'Build a signature block', 'Using exactly two print() statements, produce this exact two-line "signature", where the second line is a row of dashes exactly as long as the name above it:
Jordan Lee
----------', '# Exactly two print() statements
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 1, 'Store and greet', 'Read the user''s name with input(), store it in a variable, then print a greeting that uses that variable.', '# Read a name, store it, then greet
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 2, 'Sum two numbers', 'Read two numbers from the user with input() (remember input() gives you strings), convert them to int, and print their sum.', '# Read, convert to int, add, print
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 3, 'Average of three', 'Read three numbers from the user, convert them to float, and print their average.', '# Read three numbers and print their average
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 4, 'Swap without a third variable', 'Two variables are set below. Swap their values WITHOUT introducing a third variable, then print both to confirm the swap worked.', 'a = 5
b = 9
# Swap a and b here, then print both
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 5, 'Rectangle area and perimeter', 'Read a length and a width from the user, then compute and print both the area and the perimeter of the rectangle.', '# Read length and width, print area and perimeter
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 6, 'Celsius to Fahrenheit', 'Read a Celsius temperature from the user, convert it to Fahrenheit using F = C * 9/5 + 32, and print the result.', '# Convert Celsius to Fahrenheit
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 7, 'Cents to coins', 'Read a number of cents as an int. Using integer division (//) and modulus (%), compute how many quarters, dimes, nickels, and pennies make up that amount, printing each count.', '# Break the cents into quarters, dimes, nickels, pennies
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 8, 'Predict the type', 'Before running it, think about whether this expression produces an int or a float, then print it to check: 3 + 2.0', '# Print the result of: 3 + 2.0
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 9, 'Repeat a word n times', 'Read a word and a number n from the user, then print the word repeated n times in a row (remember to convert n to int before using it with *).', '# Read a word and a count, then repeat the word
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 10, 'Feet and inches', 'Read a total number of inches as an int. Using // and %, compute how many whole feet that is and how many inches are left over, then print both.', '# Convert total inches into feet and remaining inches
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 11, 'Simple interest', 'Read a principal, an interest rate (as a decimal like 0.05), and a time in years. Compute simple interest = principal * rate * time, and print it rounded to 2 decimal places using an f-string.', '# Compute and print simple interest, 2 decimal places
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 12, 'Miles to kilometers', 'Read a distance in miles, convert it to kilometers (1 mile = 1.60934 km), and print the result with exactly 2 decimal places.', '# Convert miles to kilometers, 2 decimal places
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 13, 'Order of operations with variables', 'Given the variables below, predict the result of the expression on paper first, then print it to check: result = a + b * c - d / 2', 'a = 4
b = 3
c = 2
d = 6
# Predict, then print: a + b * c - d / 2
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 14, 'Formatted receipt line', 'Read an item price and a quantity. Compute the total cost, then print a single formatted line using an f-string showing the quantity, item cost, and total, with money values to 2 decimal places.', '# Read price and quantity, print a formatted receipt line
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 15, 'Average speed', 'Read a distance and a time, compute speed = distance / time, and print it in a full sentence using an f-string that includes units (like mph).', '# Compute and print average speed with units
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 16, 'Reverse a two-digit number''s digits', 'Read a two-digit integer. Using // and % (no string slicing), extract its tens digit and ones digit, then print the number formed by swapping those two digits.', '# Extract tens and ones digits using // and %
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 17, 'BMI calculator', 'Read a weight in kilograms and a height in meters. Compute BMI = weight / height ** 2, and print it rounded to one decimal place.', '# Compute and print BMI, 1 decimal place
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 18, 'Sum and product', 'Read three separate numbers from the user. Print both their sum and their product.', '# Read three numbers, print sum and product
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 19, 'Fix the type error', 'The code below crashes because it tries to add a string to a number without converting it first. Fix it so it runs correctly and prints the total.', 'age_text = "25"
total = age_text + 5
print(total)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('input-processing-output', 20, 'Total cost with tax', 'Read a subtotal and a tax rate written as a decimal (like 0.07 for 7%). Compute the total including tax, and print it formatted to 2 decimal places.', '# Read subtotal and tax rate, print total with tax
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 1, 'Even or odd', 'Read an integer from the user and print whether it is even or odd, using the modulus operator.', '# Print whether the number is even or odd
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 2, 'Positive, negative, or zero', 'Read a number and print whether it is positive, negative, or zero.', '# Classify the number
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 3, 'Larger of two, no max()', 'Read two numbers and print the larger one, without using Python''s built-in max() function.', '# Find the larger value using if/else only
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 4, 'Largest of three, no max()', 'Read three numbers and print the largest one, without using max().', '# Find the largest of three values using if/elif/else
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 5, 'Letter grade classifier', 'Read a numeric score (0-100) and print the letter grade using these cutoffs: 90+ is A, 80-89 is B, 70-79 is C, 60-69 is D, below 60 is F.', '# Classify the score into a letter grade
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 6, 'Leap year checker', 'Read a year and determine if it is a leap year: divisible by 4, but not by 100 unless it is also divisible by 400. Print the result.', '# Determine whether the year is a leap year
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 7, 'Valid triangle check', 'Read three side lengths. A triangle is valid only if each side is less than the sum of the other two. Print whether the sides form a valid triangle.', '# Check the triangle inequality for all three sides
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 8, 'Voting eligibility', 'Read a person''s age and print whether they are eligible to vote (18 or older), using a boolean expression rather than just an if with no condition shown separately.', '# Determine voting eligibility
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 9, 'And vs or', 'Two yes/no answers are given below as strings. Convert each to True/False, then print the result of combining them with `and`, and separately with `or`, so you can see the difference.', 'answer1 = "yes"
answer2 = "no"
# Convert to booleans, then print the result of and, then or
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 10, 'Password length check', 'Read a password string and print whether it is at least 8 characters long.', '# Check the password length
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 11, 'Range check, one line', 'Read a number and print whether it falls between 10 and 20 inclusive, using a single chained comparison like 10 <= x <= 20 rather than two separate conditions joined with and.', '# Use a chained comparison: 10 <= x <= 20
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 12, 'Safe division with short-circuit', 'The variable divisor below might be zero. Using `and`, write a single boolean expression that checks divisor != 0 first so that the division is never actually attempted when divisor is 0, printing the safe result or a message if it is 0.', 'numerator = 10
divisor = 0
# Use short-circuit evaluation to avoid dividing by zero
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 13, 'Nested BMI classification', 'Read weight (kg) and height (m), compute BMI, then use nested or chained conditionals to classify it as underweight (<18.5), normal (18.5-24.9), overweight (25-29.9), or obese (30+).', '# Compute BMI, then classify it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 14, 'Rock paper scissors, one round', 'Two choices are given as strings ("rock", "paper", or "scissors"). Write the logic to print who wins, or "tie" if they match.', 'player1 = "rock"
player2 = "scissors"
# Determine and print the winner, or tie
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 15, 'FizzBuzz for one number', 'Read one integer. Print "Fizz" if divisible by 3, "Buzz" if divisible by 5, "FizzBuzz" if divisible by both, otherwise print the number itself.', '# Classic FizzBuzz logic for a single number
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 16, 'Tiered discount', 'Read a purchase total. If it is over 100, apply a 10% discount. If it is over 50 (but not over 100), apply 5%. Otherwise no discount. Print the final price.', '# Apply the correct discount tier
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 17, 'Combined boolean flags', 'Given the three boolean variables below, write ONE boolean expression that is true only when is_member is True AND (has_coupon OR is_holiday is True). Print the result.', 'is_member = True
has_coupon = False
is_holiday = True
# One combined boolean expression
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 18, 'Debug the grade cutoffs', 'The grade classifier below is checking its cutoffs in the wrong order (low to high with elif), so high scores get misclassified. Fix the order so it works correctly for all scores 0-100.', 'score = 95
if score >= 60:
    grade = "D"
elif score >= 70:
    grade = "C"
elif score >= 80:
    grade = "B"
elif score >= 90:
    grade = "A"
else:
    grade = "F"
print(grade)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 19, 'Divisible by both, one condition', 'Read a number and print whether it is divisible by both 3 and 7, using a single combined boolean condition rather than two nested if statements.', '# One combined condition checking divisibility by 3 and 7
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('decision-structures-boolean', 20, 'Season classifier', 'Read a month number (1-12) and print which season it falls in, using this simple mapping: 12,1,2 = Winter; 3,4,5 = Spring; 6,7,8 = Summer; 9,10,11 = Fall.', '# Classify the month into a season
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 1, 'Count to n', 'Read a number n and use a loop to print every whole number from 1 to n, one per line.', '# Print 1 through n using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 2, 'Sum from 1 to n', 'Read a number n and use a loop to compute the sum of all integers from 1 to n, then print the total.', '# Sum 1 through n using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 3, 'Countdown then liftoff', 'Read a number n and print a countdown from n down to 1 (one per line), then print "Liftoff!" after the loop finishes.', '# Countdown, then print Liftoff!
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 4, 'Multiplication table', 'Read a number and print its multiplication table for 1 through 10 (ten lines, like: 3 x 1 = 3).', '# Print the multiplication table for the number, 1-10
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 5, 'Sum of even numbers', 'Read a number n and use a loop to compute the sum of all even numbers from 1 to n, then print the total.', '# Sum only the even numbers from 1 to n
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 6, 'Factorial with a loop', 'Read a number n and compute n! (n factorial) using a loop, not recursion.', '# Compute n! using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 7, 'Sum of digits', 'Read a positive integer and use a while loop with // and % to compute the sum of its individual digits.', '# Sum the digits of the number using a while loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 8, 'Count the vowels', 'Read a word and use a loop to count how many of its letters are vowels (a, e, i, o, u).', '# Count vowels in the word using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 9, 'Validate with a loop', 'Keep asking the user for a number using a while loop until they enter a positive number, then print that number.', '# Keep asking until a positive number is entered
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 10, 'Sentinel-controlled sum', 'Read numbers one at a time in a loop and keep a running total, stopping when the user enters -1 (the sentinel value, not included in the total). Print the final total.', '# Keep a running total until -1 is entered
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 11, 'Square of stars', 'Read a number n and print an n by n square made entirely of asterisks, using nested loops.', '# Print an n by n square of stars using nested loops
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 12, 'Right triangle of stars', 'Read a number n and print a right triangle of asterisks with n rows (row 1 has one star, row 2 has two, and so on), using nested loops.', '# Print the triangle using nested loops
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 13, 'Running average', 'Read a count n, then read n numbers one at a time in a loop, computing and printing their average once all have been entered.', '# Read n numbers in a loop, then print their average
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 14, 'Count target guesses', 'Read how many guesses were made, then read that many guesses in a loop, counting and printing how many of them matched a fixed target number of 7.', '# Count how many guesses equal 7
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 15, 'First n Fibonacci numbers', 'Read a number n and print the first n numbers of the Fibonacci sequence (0, 1, 1, 2, 3, 5, ...) using a loop.', '# Print the first n Fibonacci numbers
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 16, 'Prime checker with a loop', 'Read a number and use a loop to determine whether it is prime, printing the result.', '# Determine if the number is prime using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 17, 'Break on first match', 'Loop through the numbers 1 to 100 and stop as soon as you find the first one divisible by both 7 and 5, printing it (use break to stop the loop early).', '# Find and print the first number 1-100 divisible by both 7 and 5
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 18, 'Skip the odd numbers', 'Loop through the numbers 1 to 20, using continue to skip odd numbers, and print only the even ones.', '# Print only the even numbers from 1 to 20
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 19, 'Debug the infinite loop', 'The while loop below never updates its counter variable, so it will run forever. Fix it so it correctly counts from 1 to 5 and stops.', 'count = 1
while count <= 5:
    print(count)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('repetition-structures', 20, 'Guess the number', 'A secret number is fixed at 42 below. Using a while loop, keep reading guesses and print "too high" or "too low" until the guess matches, then print a congratulations message.', 'secret = 42
# Loop until the guess matches secret
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 1, 'Simple greeting function', 'Write a function that takes a name and returns a greeting string. Call it with a couple of different names and print the results.', '# Define a greeting function, then call and print it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 2, 'Square a number', 'Write a function that takes a number and returns its square. Test it with at least three different numbers.', '# Define a square function and test it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 3, 'Is even, as a function', 'Write a function that returns True if a number is even and False otherwise. Test it on several numbers.', '# Define an is_even function and test it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 4, 'Larger of two, as a function', 'Write a function that takes two numbers and returns the larger one, without using max(). Test it.', '# Define the function and test it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 5, 'Sum and product, one function', 'Write a function that takes two numbers and returns both their sum and their product as a tuple. Call it and unpack both results when printing.', '# Return a tuple of (sum, product) and unpack it at the call site
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 6, 'Default parameter', 'Write a function that takes a name and an optional greeting word (defaulting to "Hello"). Call it once using the default and once overriding it, printing both results.', '# Define the function with a default parameter
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 7, 'Celsius to Fahrenheit function', 'Write a function that converts Celsius to Fahrenheit and returns the result. Test it with a few values.', '# Define the conversion function and test it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 8, 'A function calling a function', 'Write a helper function that squares a number, then write a second function that uses the first to compute the sum of the squares of two numbers.', '# Define square(), then sum_of_squares() that uses it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 9, 'Local vs global', 'A variable named message is defined outside the function below, and a different value with the same name is defined inside it. Predict what prints inside versus outside the function, then run it to check.', 'message = "outside"

def show():
    message = "inside"
    print(message)

show()
print(message)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 10, 'Validate range, as a function', 'Write a function that takes a number and returns True only if it is between 1 and 100 inclusive. Test it with numbers inside and outside that range.', '# Define the range-check function and test it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 11, 'Global counter', 'Write a function that increments and returns a global counter each time it is called (using the global keyword). Call it three times, printing the counter after each call.', 'counter = 0
# Define a function that increments and returns counter
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 12, 'Recursive countdown', 'Write a recursive function (a function that calls itself) that prints numbers from n down to 1.', '# Define a recursive countdown function
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 13, 'Recursive factorial', 'Write a recursive function to compute n factorial.', '# Define a recursive factorial function
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 14, 'Recursive sum', 'Write a recursive function that returns the sum of all integers from 1 to n.', '# Define a recursive sum function
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 15, 'Sum of first n even numbers', 'Write a function that takes n and returns the sum of the first n even numbers, using a loop inside the function.', '# Define the function using a loop inside it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 16, 'Guard clause for negatives', 'Write a function that returns None immediately if its input is negative, otherwise returns the input raised to the power 0.5 (an approximation of square root). Test it with both a negative and a positive number.', '# Define the function with an early return for negatives
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 17, 'Perfect square checker', 'Write a function that checks whether a given number is a perfect square (its square root is a whole number), without using any built-in square root function beyond ** 0.5. Test it on a few numbers.', '# Define is_perfect_square and test it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 18, 'Formatted cost string', 'Write a function that takes a price and a quantity and returns a formatted string showing the total cost to 2 decimal places. Print the returned string.', '# Define the function and print its returned string
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 19, 'Debug the missing return', 'The function below is supposed to return the square of a number, but it never actually returns anything, so calling it prints None. Fix it.', 'def square(n):
    result = n * n

print(square(4))
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('functions', 20, 'Two functions working together', 'Write one function that returns True only if a number is positive, and a second function that uses a loop and the first function to keep asking the user for input until they provide a valid positive number, then print it.', '# Define is_positive(), then use it inside a validation loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 1, 'Write and read a file', 'Write the string "Hello, file!" to a file called notes.txt, then open it again and print its contents.', '# Write to notes.txt, then read and print it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 2, 'Append to a file', 'Write two lines to a file using write mode, then append a third line using append mode. Read the file back and print all three lines.', '# Write two lines, append a third, then read and print all
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 3, 'Count lines in a file', 'Write three lines of text to a file, then read it back and count and print how many lines it contains.', '# Write three lines, then count them when reading back
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 4, 'Catch a ValueError', 'Write code that attempts to convert a non-numeric string to an int inside a try block, catching the resulting ValueError and printing a friendly message instead of crashing.', 'text = "not a number"
# Try converting text to int, catch ValueError
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 5, 'Safe division', 'Write code that divides two numbers, but catches ZeroDivisionError if the divisor is 0, printing a friendly message in that case instead of crashing.', 'numerator = 10
divisor = 0
# Divide safely with try/except
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 6, 'Multiple except blocks', 'Read two numbers from the user and attempt to divide them. Handle ValueError (invalid input) and ZeroDivisionError (dividing by zero) with two separate, clearly different messages.', '# Read two numbers, divide safely, handle both error types
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 7, 'Handle a missing file', 'Attempt to open a file that does not exist, catching the FileNotFoundError and printing a friendly message instead of letting the program crash.', '# Try to open a nonexistent file safely
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 8, 'Validate then write', 'Read a number from the user. If it is not a valid number, catch the error and print a message. If it is valid, write it to a file called number.txt.', '# Validate the input, then write it to a file if valid
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 9, 'Sum numbers from a file', 'Write several numbers, one per line, to a file. Then read them back, convert each to int, and print their total sum.', '# Write numbers to a file, read them back, sum them
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 10, 'Try, except, else', 'Write code that attempts a calculation inside a try block, using an else block that only runs if no exception occurred, printing a success message there.', '# Use try/except/else
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 11, 'Try, except, finally', 'Write code with a finally block that always prints "Done attempting" regardless of whether an exception occurred.', '# Use try/except/finally
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 12, 'Friendlier custom message', 'Catch a specific exception (your choice, like ValueError) and print a clearer, custom message explaining what went wrong in plain English, rather than the default error text.', '# Catch the exception and print a custom explanation
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 13, 'Word count from a file', 'Write a full sentence to a file, then read it back and print how many words it contains.', '# Write a sentence, then count its words when reading back
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 14, 'Overwrite vs append', 'Write to the same file twice using write mode (showing the first content is erased), then write to it twice using append mode (showing content accumulates). Print the final contents of each case.', '# Demonstrate write mode vs append mode
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 15, 'Safe average from a file', 'Read numbers from a file and compute their average inside a try/except, so that if the file turns out to be empty (causing a ZeroDivisionError), a friendly message prints instead of crashing.', '# Compute an average from file contents safely
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 16, 'Skip invalid values in a loop', 'Given the list-like values below (as strings), attempt to convert each to an int inside a loop, catching and skipping any that fail, and printing only the successfully converted numbers.', 'values = ["10", "oops", "25", "nah", "7"]
# Convert each to int where possible, skip invalid ones
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 17, 'Write a small report', 'Compute the sum and average of three fixed numbers, write a short formatted report with both values to a file, then read and print the file''s contents.', '# Compute sum/average, write a report file, then read it back
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 18, 'Raise a custom exception', 'Write code that raises an exception (using raise) if a password string is shorter than 8 characters, and catches it elsewhere with a helpful message.', 'password = "abc"
# Raise an exception if too short, then catch and handle it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 19, 'Nested try/except', 'Write code with a try block inside another try block, showing that an inner exception can be caught separately from an outer one.', '# Nested try/except blocks
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('files-exceptions', 20, 'Debug the wrong exception type', 'The code below is trying to catch a division-by-zero error, but it is catching the wrong exception type, so the program still crashes. Fix it so it catches the correct exception.', 'try:
    result = 10 / 0
except ValueError:
    print("Something went wrong")
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 1, 'Build and print a list', 'Create a list of five numbers, print the whole list, then print just the first and last elements.', '# Create the list, then print it, first, and last
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 2, 'Sum a list without sum()', 'Given a list of numbers, use a loop to compute and print their sum, without using the built-in sum().', 'numbers = [4, 8, 15, 16, 23, 42]
# Add them up using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 3, 'Find the max without max()', 'Given a list of numbers, find and print the largest value using a loop, without using max().', 'numbers = [3, 17, 9, 42, 8]
# Find the largest using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 4, 'Count occurrences', 'Given a list with repeated values, count and print how many times the value 7 appears in it.', 'values = [7, 2, 7, 9, 7, 1]
# Count how many times 7 appears
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 5, 'Reverse a list manually', 'Given a list, print it in reverse order using a loop, without using reverse() or [::-1].', 'items = [1, 2, 3, 4, 5]
# Print items in reverse using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 6, 'Slicing practice', 'Given a list of 10 numbers, print just the first three, just the last three, and everything except the first and last.', 'numbers = [1,2,3,4,5,6,7,8,9,10]
# Print the three slices described above
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 7, 'Modify a list in place', 'Given a list, use append() to add one new value and remove() to delete a specific existing value, then print the final list.', 'cart = ["apples", "bread", "milk"]
# Add "eggs", remove "bread", then print cart
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 8, 'Sort manually', 'Given a small list of numbers, sort it using your own loop-based approach (not the built-in sort()), and print the sorted result.', 'numbers = [5, 2, 9, 1, 7]
# Sort using your own logic, not sort()
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 9, 'Sort with sorted()', 'Given the same idea, use sorted() to sort a list ascending, then print it sorted descending as well.', 'numbers = [5, 2, 9, 1, 7]
# Use sorted(), ascending and descending
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 10, 'List of tuples', 'Given a list of (name, score) tuples, loop through it and print each student''s name with their score in a formatted line.', 'students = [("Ada", 95), ("Sam", 88), ("Lee", 76)]
# Loop through and print each student and score
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 11, 'Tuple unpacking', 'Given a tuple representing (x, y) coordinates, unpack it into two variables and print a message using both.', 'point = (3, 7)
# Unpack into x and y, then print a message
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 12, 'Remove duplicates, preserving order', 'Given a list with duplicate values, build a new list containing only the unique values, preserving their original order, without using set().', 'values = [1, 2, 2, 3, 1, 4, 3]
# Build a new list with duplicates removed, order preserved
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 13, 'List comprehension: evens', 'Given a list of numbers, build a new list containing only the even ones using a list comprehension.', 'numbers = [1,2,3,4,5,6,7,8,9,10]
# Build a list of only the even numbers
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 14, 'Average of a list', 'Given a list of numbers, compute and print their average.', 'scores = [88, 92, 79, 95, 84]
# Compute and print the average
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 15, 'Nested list (matrix)', 'Given a small 2D list representing a grid, use nested loops to print every value in it.', 'grid = [[1,2,3],[4,5,6],[7,8,9]]
# Print every value using nested loops
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 16, 'Search a list', 'Given a list and a target value, search for the target and print its index if found, or a not-found message otherwise.', 'numbers = [10, 25, 33, 47, 52]
target = 47
# Search for target, print index or not-found message
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 17, 'Merge two lists', 'Given two lists of numbers, combine them into one list, print the combined list, then print it sorted.', 'a = [3, 1, 4]
b = [9, 2, 6]
# Combine into one list, print it, then print it sorted
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 18, 'Second largest value', 'Given a list of numbers, find and print the second-largest value.', 'numbers = [12, 45, 2, 45, 33, 7]
# Find and print the second-largest value
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 19, 'Tuples are immutable', 'Given a tuple, attempt to change one of its elements, catch the resulting TypeError, and print a message explaining that tuples cannot be changed.', 'point = (1, 2)
# Try to modify point[0], catch the error, explain it
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('lists-tuples', 20, 'Debug the max-finding bug', 'The code below is meant to find the maximum value in a list, but it starts the running maximum at 0, which fails for lists of all-negative numbers. Fix it so it works correctly for any list.', 'numbers = [-5, -2, -9, -1]
current_max = 0
for n in numbers:
    if n > current_max:
        current_max = n
print(current_max)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 1, 'Length and indexing', 'Given a string, print its length, its first character, and its last character.', 'word = "programming"
# Print length, first character, last character
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 2, 'Slicing practice', 'Given a longer string, print just the first 5 characters, the last 5 characters, and everything in between.', 'text = "the quick brown fox"
# Print the first 5, last 5, and the middle
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 3, 'Upper and lower', 'Given a mixed-case string, print an all-uppercase version and an all-lowercase version.', 'text = "Hello World"
# Print uppercase and lowercase versions
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 4, 'Reverse with slicing', 'Given a string, print it reversed using slicing.', 'word = "python"
# Print the reversed word using slicing
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 5, 'Reverse with a loop', 'Do the same reversal as before, but this time using a loop instead of slicing.', 'word = "python"
# Print the reversed word using a loop
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 6, 'Palindrome checker', 'Given a word, determine and print whether it reads the same forwards and backwards.', 'word = "level"
# Determine and print whether word is a palindrome
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 7, 'Count a specific character', 'Given a string, count and print how many times the letter ''s'' appears in it.', 'text = "mississippi"
# Count occurrences of the letter s
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 8, 'Count vowels and consonants', 'Given a string, count and print separately how many vowels and how many consonants it contains.', 'text = "hello there"
# Count vowels and consonants separately
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 9, 'Word count', 'Given a sentence, count and print how many words it contains, using split().', 'sentence = "the quick brown fox jumps"
# Count the words in the sentence
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 10, 'Replace a substring', 'Given a sentence, replace one specific word with another and print the result.', 'sentence = "I love bugs in my code"
# Replace "bugs" with "features", print the result
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 11, 'Strip and clean', 'Given a string with extra leading and trailing spaces, clean it up and print the cleaned version alongside its original length versus its cleaned length.', 'messy = "   hello there   "
# Clean it, print original length and cleaned length
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 12, 'Join a list into a sentence', 'Given a list of words, join them into a single sentence string with spaces between them.', 'words = ["the", "quick", "brown", "fox"]
# Join the words into one sentence
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 13, 'Split and rejoin with a different separator', 'Given a sentence, split it into a list of words, then rejoin those words using a hyphen instead of spaces.', 'sentence = "learning python is fun"
# Split into words, then rejoin with hyphens
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 14, 'Simple letter shift', 'Given a single lowercase letter and a shift amount, compute and print the letter that results from shifting it forward in the alphabet by that amount, wrapping from z back to a.', 'letter = "y"
shift = 3
# Compute the shifted letter, wrapping past z
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 15, 'Double every character', 'Given a word, use a loop to build a new string where every character is duplicated (so "cat" becomes "ccaatt"), then print the result.', 'word = "cat"
# Build a new string with every character doubled
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 16, 'Title case manually', 'Given a sentence, capitalize the first letter of every word without using the built-in title() method.', 'sentence = "the great gatsby"
# Capitalize each word manually
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 17, 'All-digits checker', 'Given a string, determine whether every character in it is a digit, without using isdigit(), by comparing each character against ''0'' through ''9''.', 'text = "12345"
# Check manually whether every character is a digit
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 18, 'Find all positions of a character', 'Given a string and a target character, print every index at which that character appears.', 'text = "mississippi"
target = "s"
# Print every index where target appears
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 19, 'Format a phone number', 'Given a string of exactly 10 digits, insert dashes to format it as a standard phone number: XXX-XXX-XXXX.', 'digits = "5551234567"
# Format digits as XXX-XXX-XXXX
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('more-about-strings', 20, 'Debug the prefix check', 'The code below is meant to check whether a string starts with the prefix "pre", but it has an off-by-one slicing error. Fix it so the check works correctly.', 'text = "prefix"
prefix = "pre"
if text[0:2] == prefix:
    print("Starts with prefix")
else:
    print("Does not start with prefix")
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 1, 'Build and access a dictionary', 'Create a dictionary of three menu items with prices, print the whole dictionary, then print just the price of one specific item.', '# Create the dictionary, print it, then print one price
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 2, 'Update and add entries', 'Given an existing dictionary, update the price of one existing item and add a brand new item, then print the final dictionary.', 'menu = {"coffee": 3.5, "tea": 3.0}
# Update coffee''s price, add a new item, print the result
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 3, 'Loop through keys and values', 'Given a dictionary, loop through it and print each key alongside its value in a formatted line.', 'inventory = {"apples": 10, "bananas": 5, "cherries": 20}
# Loop through and print each key/value pair
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 4, 'Check membership before accessing', 'Given a dictionary, check whether a specific key exists before trying to access it, printing an appropriate message either way.', 'prices = {"apple": 1.0, "banana": 0.5}
check_item = "cherry"
# Check membership before accessing prices[check_item]
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 5, 'Word frequency counter', 'Given a sentence, build a dictionary that counts how many times each word appears in it.', 'sentence = "the cat sat on the mat and the cat slept"
# Build a word-count dictionary
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 6, 'Most common value', 'Given a word-frequency dictionary, find and print the word that appears most often.', 'counts = {"the": 5, "cat": 3, "mat": 1}
# Find and print the most common word
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 7, 'Remove a key safely', 'Given a dictionary, remove one specific key, handling the case where it might not exist, then print the result.', 'data = {"a": 1, "b": 2, "c": 3}
# Safely remove key "z" (which does not exist), then print data
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 8, 'Nested dictionary access', 'Given a dictionary of students where each value is itself a dictionary of subject grades, print one specific student''s grade in one specific subject.', 'students = {
    "Ada": {"math": 95, "science": 88},
    "Sam": {"math": 78, "science": 91}
}
# Print Sam''s science grade
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 9, 'Dictionary comprehension', 'Given a list of numbers, build a dictionary mapping each number to its square, using a dictionary comprehension.', 'numbers = [1, 2, 3, 4, 5]
# Build {number: square} using a dict comprehension
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 10, 'Invert a dictionary', 'Given a dictionary with unique values, build a new dictionary where the keys and values are swapped.', 'original = {"a": 1, "b": 2, "c": 3}
# Build a new dictionary with keys and values swapped
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 11, 'Merge two dictionaries', 'Given two dictionaries, combine them into one, with the second dictionary''s values overwriting the first''s on any shared keys.', 'first = {"a": 1, "b": 2}
second = {"b": 20, "c": 3}
# Merge them so second overwrites shared keys
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 12, 'Set membership check', 'Given a set of allowed usernames, check whether a specific username is in the set and print the result.', 'allowed = {"ada", "sam", "lee"}
check_user = "sam"
# Check membership and print the result
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 13, 'Remove duplicates with a set', 'Given a list with duplicate values, convert it to a set to remove duplicates, then print the result as a sorted list.', 'values = [3, 1, 4, 1, 5, 9, 2, 6, 5]
# Remove duplicates using a set, print sorted
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 14, 'Union and intersection', 'Given two sets representing two groups of students, print which students are in either group (union) and which are in both (intersection).', 'group_a = {"Ada", "Sam", "Lee"}
group_b = {"Sam", "Max", "Lee"}
# Print the union, then the intersection
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 15, 'Set difference', 'Given two sets, print which elements are in the first set but not the second.', 'set_a = {1, 2, 3, 4}
set_b = {3, 4, 5, 6}
# Print elements in set_a but not set_b
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 16, 'Counting unique values', 'Given a list of values with repeats, use a set to count and print how many unique values it contains.', 'values = [1, 2, 2, 3, 3, 3, 4]
# Count unique values using a set
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 17, 'Safe lookup with get()', 'Given a dictionary, use get() with a default value to safely look up a key that might not exist, without causing a KeyError.', 'ages = {"Ada": 25, "Sam": 30}
# Look up "Lee" safely with get(), using a default of "unknown"
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 18, 'Group data with a dictionary', 'Given a list of (name, category) pairs, build a dictionary that groups all the names under their category as lists.', 'people = [("Ada", "science"), ("Sam", "math"), ("Lee", "science")]
# Build {category: [names]}
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 19, 'Symmetric difference', 'Given two sets, print the elements that are in exactly one of the sets but not both.', 'set_a = {1, 2, 3}
set_b = {2, 3, 4}
# Print the symmetric difference
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
insert into exercises (module_slug, sort_order, title, prompt, starter_code) values ('dictionaries-sets', 20, 'Debug the KeyError', 'The code below is meant to count word frequency, but it crashes with a KeyError the first time it sees any new word, because it assumes the key already exists. Fix it.', 'counts = {}
words = ["cat", "dog", "cat"]
for w in words:
    counts[w] += 1
print(counts)
') on conflict (module_slug, sort_order) do update set title = excluded.title, prompt = excluded.prompt, starter_code = excluded.starter_code;
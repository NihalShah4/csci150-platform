-- Reference solutions (answer key), admin-only visibility via exercise_answers table.

insert into exercise_answers (exercise_id, answer_key) select id, 'print(''She said, "It\''s already done!"'')
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print(4 + 3 * 2 - 6 / 2)
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print((2 + 3) * (4 - 1) ** 2)
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print(''*'')
print(''**'')
print(''***'')
print(''****'')
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print(''****'')
print(''***'')
print(''**'')
print(''*'')
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("First, I opened my code editor.")
print("Next, I typed my very first print statement.")
print("Then I ran it and saw the output on screen.")
print("Finally, I fixed the bug and celebrated.")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("Loading Pynt...")
print("Ready to code.")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("Don''t stop coding.")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("Name\tScore\nAda\t100")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("coffee", "break")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("red", "green", "blue", sep=" - ")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("Loading...", end=" ")
print("Done")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("Py" + " + " + "thon" + " = " + "Python")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("ha" * 6)
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print(" Item  Price")
print("Apple   1.00")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("Almost working")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("This string never closes")
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print(17 % 5)
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print(7 / 2)
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print("Jordan Lee")
print("-" * len("Jordan Lee"))
' from exercises where module_slug = 'intro-computers-programming' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'name = input("What is your name? ")
print("Hello, " + name + "!")
' from exercises where module_slug = 'input-processing-output' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = int(input("Enter a number: "))
b = int(input("Enter another number: "))
print(a + b)
' from exercises where module_slug = 'input-processing-output' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = float(input())
b = float(input())
c = float(input())
print((a + b + c) / 3)
' from exercises where module_slug = 'input-processing-output' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = 5
b = 9
a, b = b, a
print(a, b)
' from exercises where module_slug = 'input-processing-output' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'length = float(input("Length: "))
width = float(input("Width: "))
print("Area:", length * width)
print("Perimeter:", 2 * (length + width))
' from exercises where module_slug = 'input-processing-output' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'celsius = float(input("Celsius: "))
fahrenheit = celsius * 9 / 5 + 32
print(fahrenheit)
' from exercises where module_slug = 'input-processing-output' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'cents = int(input("Cents: "))
quarters = cents // 25
cents %= 25
dimes = cents // 10
cents %= 10
nickels = cents // 5
cents %= 5
pennies = cents
print("Quarters:", quarters)
print("Dimes:", dimes)
print("Nickels:", nickels)
print("Pennies:", pennies)
' from exercises where module_slug = 'input-processing-output' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'print(3 + 2.0)
' from exercises where module_slug = 'input-processing-output' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'word = input("Word: ")
n = int(input("How many times: "))
print(word * n)
' from exercises where module_slug = 'input-processing-output' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'total_inches = int(input("Total inches: "))
feet = total_inches // 12
inches = total_inches % 12
print("Feet:", feet)
print("Inches:", inches)
' from exercises where module_slug = 'input-processing-output' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'principal = float(input())
rate = float(input())
time = float(input())
interest = principal * rate * time
print(f"{interest:.2f}")
' from exercises where module_slug = 'input-processing-output' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'miles = float(input("Miles: "))
km = miles * 1.60934
print(f"{km:.2f}")
' from exercises where module_slug = 'input-processing-output' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = 4
b = 3
c = 2
d = 6
result = a + b * c - d / 2
print(result)
' from exercises where module_slug = 'input-processing-output' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'price = float(input("Price: "))
qty = int(input("Quantity: "))
total = price * qty
print(f"{qty} x ${price:.2f} = ${total:.2f}")
' from exercises where module_slug = 'input-processing-output' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'distance = float(input("Distance: "))
time = float(input("Time: "))
speed = distance / time
print(f"Average speed: {speed:.2f} mph")
' from exercises where module_slug = 'input-processing-output' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'num = int(input(''Two-digit number: ''))
tens = num // 10
ones = num % 10
print(ones * 10 + tens)
' from exercises where module_slug = 'input-processing-output' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'weight = float(input("Weight (kg): "))
height = float(input("Height (m): "))
bmi = weight / height ** 2
print(f"{bmi:.1f}")
' from exercises where module_slug = 'input-processing-output' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = float(input())
b = float(input())
c = float(input())
print("Sum:", a + b + c)
print("Product:", a * b * c)
' from exercises where module_slug = 'input-processing-output' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'age_text = "25"
total = int(age_text) + 5
print(total)
' from exercises where module_slug = 'input-processing-output' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'subtotal = float(input("Subtotal: "))
tax_rate = float(input("Tax rate: "))
total = subtotal * (1 + tax_rate)
print(f"{total:.2f}")
' from exercises where module_slug = 'input-processing-output' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("Number: "))
if n % 2 == 0:
    print("Even")
else:
    print("Odd")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = float(input("Number: "))
if n > 0:
    print("Positive")
elif n < 0:
    print("Negative")
else:
    print("Zero")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = float(input())
b = float(input())
if a > b:
    print(a)
else:
    print(b)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = float(input())
b = float(input())
c = float(input())
if a >= b and a >= c:
    print(a)
elif b >= a and b >= c:
    print(b)
else:
    print(c)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'score = float(input("Score: "))
if score >= 90:
    print("A")
elif score >= 80:
    print("B")
elif score >= 70:
    print("C")
elif score >= 60:
    print("D")
else:
    print("F")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'year = int(input("Year: "))
if year % 4 == 0 and (year % 100 != 0 or year % 400 == 0):
    print("Leap year")
else:
    print("Not a leap year")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = float(input())
b = float(input())
c = float(input())
if a < b + c and b < a + c and c < a + b:
    print("Valid triangle")
else:
    print("Not a valid triangle")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'age = int(input("Age: "))
can_vote = age >= 18
print(can_vote)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'answer1 = "yes"
answer2 = "no"
b1 = answer1 == "yes"
b2 = answer2 == "yes"
print(b1 and b2)
print(b1 or b2)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'password = input("Password: ")
print(len(password) >= 8)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'x = int(input("Number: "))
print(10 <= x <= 20)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numerator = 10
divisor = 0
if divisor != 0 and numerator / divisor > 1:
    print(numerator / divisor)
else:
    print("Cannot divide safely")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'weight = float(input("Weight (kg): "))
height = float(input("Height (m): "))
bmi = weight / height ** 2
if bmi < 18.5:
    print("Underweight")
elif bmi < 25:
    print("Normal")
elif bmi < 30:
    print("Overweight")
else:
    print("Obese")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'player1 = "rock"
player2 = "scissors"
if player1 == player2:
    print("tie")
elif (player1 == "rock" and player2 == "scissors") or (player1 == "scissors" and player2 == "paper") or (player1 == "paper" and player2 == "rock"):
    print("Player 1 wins")
else:
    print("Player 2 wins")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("Number: "))
if n % 15 == 0:
    print("FizzBuzz")
elif n % 3 == 0:
    print("Fizz")
elif n % 5 == 0:
    print("Buzz")
else:
    print(n)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'total = float(input("Total: "))
if total > 100:
    total *= 0.90
elif total > 50:
    total *= 0.95
print(total)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'is_member = True
has_coupon = False
is_holiday = True
result = is_member and (has_coupon or is_holiday)
print(result)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'score = 95
if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
elif score >= 60:
    grade = "D"
else:
    grade = "F"
print(grade)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("Number: "))
print(n % 3 == 0 and n % 7 == 0)
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'month = int(input("Month (1-12): "))
if month in (12, 1, 2):
    print("Winter")
elif month in (3, 4, 5):
    print("Spring")
elif month in (6, 7, 8):
    print("Summer")
else:
    print("Fall")
' from exercises where module_slug = 'decision-structures-boolean' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
for i in range(1, n + 1):
    print(i)
' from exercises where module_slug = 'repetition-structures' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
total = 0
for i in range(1, n + 1):
    total += i
print(total)
' from exercises where module_slug = 'repetition-structures' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
for i in range(n, 0, -1):
    print(i)
print("Liftoff!")
' from exercises where module_slug = 'repetition-structures' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'num = int(input("Number: "))
for i in range(1, 11):
    print(f"{num} x {i} = {num * i}")
' from exercises where module_slug = 'repetition-structures' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
total = 0
for i in range(1, n + 1):
    if i % 2 == 0:
        total += i
print(total)
' from exercises where module_slug = 'repetition-structures' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
result = 1
for i in range(1, n + 1):
    result *= i
print(result)
' from exercises where module_slug = 'repetition-structures' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("Number: "))
total = 0
while n > 0:
    total += n % 10
    n //= 10
print(total)
' from exercises where module_slug = 'repetition-structures' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'word = input("Word: ")
count = 0
for ch in word:
    if ch.lower() in "aeiou":
        count += 1
print(count)
' from exercises where module_slug = 'repetition-structures' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("Number: "))
while n <= 0:
    n = int(input("Enter a positive number: "))
print(n)
' from exercises where module_slug = 'repetition-structures' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'total = 0
num = int(input("Number (-1 to stop): "))
while num != -1:
    total += num
    num = int(input("Number (-1 to stop): "))
print(total)
' from exercises where module_slug = 'repetition-structures' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
for row in range(n):
    line = ""
    for col in range(n):
        line += "*"
    print(line)
' from exercises where module_slug = 'repetition-structures' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
for row in range(1, n + 1):
    print("*" * row)
' from exercises where module_slug = 'repetition-structures' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("How many numbers: "))
total = 0
for i in range(n):
    total += float(input("Number: "))
print(total / n)
' from exercises where module_slug = 'repetition-structures' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'tries = int(input("How many guesses: "))
count = 0
for i in range(tries):
    guess = int(input("Guess: "))
    if guess == 7:
        count += 1
print(count)
' from exercises where module_slug = 'repetition-structures' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'n = int(input("n: "))
a, b = 0, 1
for i in range(n):
    print(a)
    a, b = b, a + b
' from exercises where module_slug = 'repetition-structures' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'num = int(input("Number: "))
is_prime = num > 1
for i in range(2, num):
    if num % i == 0:
        is_prime = False
        break
print(is_prime)
' from exercises where module_slug = 'repetition-structures' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'for i in range(1, 101):
    if i % 7 == 0 and i % 5 == 0:
        print(i)
        break
' from exercises where module_slug = 'repetition-structures' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'for i in range(1, 21):
    if i % 2 != 0:
        continue
    print(i)
' from exercises where module_slug = 'repetition-structures' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'count = 1
while count <= 5:
    print(count)
    count += 1
' from exercises where module_slug = 'repetition-structures' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'secret = 42
guess = int(input("Guess: "))
while guess != secret:
    if guess > secret:
        print("Too high")
    else:
        print("Too low")
    guess = int(input("Guess: "))
print("Correct! You got it.")
' from exercises where module_slug = 'repetition-structures' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def greet(name):
    return "Hello, " + name + "!"

print(greet("Ada"))
print(greet("Sam"))
' from exercises where module_slug = 'functions' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def square(n):
    return n * n

print(square(3))
print(square(5))
print(square(10))
' from exercises where module_slug = 'functions' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def is_even(n):
    return n % 2 == 0

print(is_even(4))
print(is_even(7))
' from exercises where module_slug = 'functions' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def larger(a, b):
    if a > b:
        return a
    return b

print(larger(3, 9))
' from exercises where module_slug = 'functions' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def sum_and_product(a, b):
    return a + b, a * b

s, p = sum_and_product(4, 5)
print(s, p)
' from exercises where module_slug = 'functions' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def greet(name, greeting="Hello"):
    return greeting + ", " + name

print(greet("Ada"))
print(greet("Ada", "Hi"))
' from exercises where module_slug = 'functions' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def celsius_to_fahrenheit(c):
    return c * 9 / 5 + 32

print(celsius_to_fahrenheit(0))
print(celsius_to_fahrenheit(100))
' from exercises where module_slug = 'functions' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def square(n):
    return n * n

def sum_of_squares(a, b):
    return square(a) + square(b)

print(sum_of_squares(3, 4))
' from exercises where module_slug = 'functions' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'message = "outside"

def show():
    message = "inside"
    print(message)

show()
print(message)
' from exercises where module_slug = 'functions' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def in_range(n):
    return 1 <= n <= 100

print(in_range(50))
print(in_range(150))
' from exercises where module_slug = 'functions' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'counter = 0

def increment():
    global counter
    counter += 1
    return counter

print(increment())
print(increment())
print(increment())
' from exercises where module_slug = 'functions' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def countdown(n):
    if n < 1:
        return
    print(n)
    countdown(n - 1)

countdown(5)
' from exercises where module_slug = 'functions' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def factorial(n):
    if n <= 1:
        return 1
    return n * factorial(n - 1)

print(factorial(5))
' from exercises where module_slug = 'functions' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def sum_to_n(n):
    if n <= 0:
        return 0
    return n + sum_to_n(n - 1)

print(sum_to_n(5))
' from exercises where module_slug = 'functions' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def sum_first_n_evens(n):
    total = 0
    count = 0
    num = 2
    while count < n:
        total += num
        num += 2
        count += 1
    return total

print(sum_first_n_evens(4))
' from exercises where module_slug = 'functions' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def safe_sqrt(n):
    if n < 0:
        return None
    return n ** 0.5

print(safe_sqrt(-4))
print(safe_sqrt(9))
' from exercises where module_slug = 'functions' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def is_perfect_square(n):
    root = n ** 0.5
    return root == int(root)

print(is_perfect_square(16))
print(is_perfect_square(15))
' from exercises where module_slug = 'functions' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def format_cost(price, qty):
    total = price * qty
    return f"Total: ${total:.2f}"

print(format_cost(3.5, 4))
' from exercises where module_slug = 'functions' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def square(n):
    result = n * n
    return result

print(square(4))
' from exercises where module_slug = 'functions' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'def is_positive(n):
    return n > 0

def get_positive_number():
    num = int(input("Enter a positive number: "))
    while not is_positive(num):
        num = int(input("Enter a positive number: "))
    return num

print(get_positive_number())
' from exercises where module_slug = 'functions' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'with open("notes.txt", "w") as f:
    f.write("Hello, file!")

with open("notes.txt", "r") as f:
    print(f.read())
' from exercises where module_slug = 'files-exceptions' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'with open("notes.txt", "w") as f:
    f.write("Line one\n")
    f.write("Line two\n")

with open("notes.txt", "a") as f:
    f.write("Line three\n")

with open("notes.txt", "r") as f:
    print(f.read())
' from exercises where module_slug = 'files-exceptions' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'with open("notes.txt", "w") as f:
    f.write("one\ntwo\nthree\n")

with open("notes.txt", "r") as f:
    lines = f.readlines()
    print(len(lines))
' from exercises where module_slug = 'files-exceptions' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "not a number"
try:
    num = int(text)
except ValueError:
    print("That is not a valid number.")
' from exercises where module_slug = 'files-exceptions' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numerator = 10
divisor = 0
try:
    print(numerator / divisor)
except ZeroDivisionError:
    print("Cannot divide by zero.")
' from exercises where module_slug = 'files-exceptions' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    a = int(input("Number: "))
    b = int(input("Number: "))
    print(a / b)
except ValueError:
    print("Please enter valid numbers.")
except ZeroDivisionError:
    print("Cannot divide by zero.")
' from exercises where module_slug = 'files-exceptions' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    with open("missing.txt", "r") as f:
        print(f.read())
except FileNotFoundError:
    print("That file does not exist.")
' from exercises where module_slug = 'files-exceptions' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    num = int(input("Number: "))
    with open("number.txt", "w") as f:
        f.write(str(num))
except ValueError:
    print("Invalid number, nothing was written.")
' from exercises where module_slug = 'files-exceptions' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'with open("nums.txt", "w") as f:
    f.write("1\n2\n3\n4\n")

total = 0
with open("nums.txt", "r") as f:
    for line in f:
        total += int(line.strip())
print(total)
' from exercises where module_slug = 'files-exceptions' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    result = 10 / 2
except ZeroDivisionError:
    print("Error")
else:
    print("Success:", result)
' from exercises where module_slug = 'files-exceptions' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    result = 10 / 2
except ZeroDivisionError:
    print("Error")
finally:
    print("Done attempting")
' from exercises where module_slug = 'files-exceptions' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    num = int("abc")
except ValueError:
    print("That input needs to be a whole number, please try again.")
' from exercises where module_slug = 'files-exceptions' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'with open("sentence.txt", "w") as f:
    f.write("the quick brown fox jumps")

with open("sentence.txt", "r") as f:
    text = f.read()
    print(len(text.split()))
' from exercises where module_slug = 'files-exceptions' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'with open("demo.txt", "w") as f:
    f.write("first\n")
with open("demo.txt", "w") as f:
    f.write("second\n")
with open("demo.txt", "r") as f:
    print("write mode result:", f.read())

with open("demo2.txt", "a") as f:
    f.write("first\n")
with open("demo2.txt", "a") as f:
    f.write("second\n")
with open("demo2.txt", "r") as f:
    print("append mode result:", f.read())
' from exercises where module_slug = 'files-exceptions' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'with open("nums.txt", "w") as f:
    f.write("")

try:
    with open("nums.txt", "r") as f:
        values = [int(line) for line in f if line.strip()]
    print(sum(values) / len(values))
except ZeroDivisionError:
    print("The file was empty.")
' from exercises where module_slug = 'files-exceptions' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'values = ["10", "oops", "25", "nah", "7"]
for v in values:
    try:
        print(int(v))
    except ValueError:
        continue
' from exercises where module_slug = 'files-exceptions' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [10, 20, 30]
total = sum(numbers)
avg = total / len(numbers)
with open("report.txt", "w") as f:
    f.write(f"Sum: {total}\nAverage: {avg}\n")

with open("report.txt", "r") as f:
    print(f.read())
' from exercises where module_slug = 'files-exceptions' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'password = "abc"
try:
    if len(password) < 8:
        raise ValueError("Password too short")
except ValueError as e:
    print(e)
' from exercises where module_slug = 'files-exceptions' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    try:
        num = int("bad")
    except ValueError:
        print("Inner: invalid number")
    result = 10 / 0
except ZeroDivisionError:
    print("Outer: division by zero")
' from exercises where module_slug = 'files-exceptions' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'try:
    result = 10 / 0
except ZeroDivisionError:
    print("Something went wrong")
' from exercises where module_slug = 'files-exceptions' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [4, 8, 15, 16, 23]
print(numbers)
print(numbers[0])
print(numbers[-1])
' from exercises where module_slug = 'lists-tuples' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [4, 8, 15, 16, 23, 42]
total = 0
for n in numbers:
    total += n
print(total)
' from exercises where module_slug = 'lists-tuples' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [3, 17, 9, 42, 8]
largest = numbers[0]
for n in numbers:
    if n > largest:
        largest = n
print(largest)
' from exercises where module_slug = 'lists-tuples' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'values = [7, 2, 7, 9, 7, 1]
count = 0
for v in values:
    if v == 7:
        count += 1
print(count)
' from exercises where module_slug = 'lists-tuples' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'items = [1, 2, 3, 4, 5]
for i in range(len(items) - 1, -1, -1):
    print(items[i])
' from exercises where module_slug = 'lists-tuples' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [1,2,3,4,5,6,7,8,9,10]
print(numbers[:3])
print(numbers[-3:])
print(numbers[1:-1])
' from exercises where module_slug = 'lists-tuples' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'cart = ["apples", "bread", "milk"]
cart.append("eggs")
cart.remove("bread")
print(cart)
' from exercises where module_slug = 'lists-tuples' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [5, 2, 9, 1, 7]
for i in range(len(numbers)):
    for j in range(len(numbers) - 1):
        if numbers[j] > numbers[j + 1]:
            numbers[j], numbers[j + 1] = numbers[j + 1], numbers[j]
print(numbers)
' from exercises where module_slug = 'lists-tuples' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [5, 2, 9, 1, 7]
print(sorted(numbers))
print(sorted(numbers, reverse=True))
' from exercises where module_slug = 'lists-tuples' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'students = [("Ada", 95), ("Sam", 88), ("Lee", 76)]
for name, score in students:
    print(f"{name}: {score}")
' from exercises where module_slug = 'lists-tuples' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'point = (3, 7)
x, y = point
print(f"x is {x} and y is {y}")
' from exercises where module_slug = 'lists-tuples' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'values = [1, 2, 2, 3, 1, 4, 3]
unique = []
for v in values:
    if v not in unique:
        unique.append(v)
print(unique)
' from exercises where module_slug = 'lists-tuples' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [1,2,3,4,5,6,7,8,9,10]
evens = [n for n in numbers if n % 2 == 0]
print(evens)
' from exercises where module_slug = 'lists-tuples' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'scores = [88, 92, 79, 95, 84]
print(sum(scores) / len(scores))
' from exercises where module_slug = 'lists-tuples' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'grid = [[1,2,3],[4,5,6],[7,8,9]]
for row in grid:
    for value in row:
        print(value)
' from exercises where module_slug = 'lists-tuples' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [10, 25, 33, 47, 52]
target = 47
found = False
for i in range(len(numbers)):
    if numbers[i] == target:
        print(i)
        found = True
        break
if not found:
    print("not found")
' from exercises where module_slug = 'lists-tuples' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'a = [3, 1, 4]
b = [9, 2, 6]
combined = a + b
print(combined)
print(sorted(combined))
' from exercises where module_slug = 'lists-tuples' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [12, 45, 2, 45, 33, 7]
sorted_numbers = sorted(numbers, reverse=True)
print(sorted_numbers[1])
' from exercises where module_slug = 'lists-tuples' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'point = (1, 2)
try:
    point[0] = 5
except TypeError:
    print("Tuples cannot be changed.")
' from exercises where module_slug = 'lists-tuples' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [-5, -2, -9, -1]
current_max = numbers[0]
for n in numbers:
    if n > current_max:
        current_max = n
print(current_max)
' from exercises where module_slug = 'lists-tuples' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'word = "programming"
print(len(word))
print(word[0])
print(word[-1])
' from exercises where module_slug = 'more-about-strings' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "the quick brown fox"
print(text[:5])
print(text[-5:])
print(text[5:-5])
' from exercises where module_slug = 'more-about-strings' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "Hello World"
print(text.upper())
print(text.lower())
' from exercises where module_slug = 'more-about-strings' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'word = "python"
print(word[::-1])
' from exercises where module_slug = 'more-about-strings' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'word = "python"
reversed_word = ""
for ch in word:
    reversed_word = ch + reversed_word
print(reversed_word)
' from exercises where module_slug = 'more-about-strings' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'word = "level"
print(word == word[::-1])
' from exercises where module_slug = 'more-about-strings' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "mississippi"
count = 0
for ch in text:
    if ch == "s":
        count += 1
print(count)
' from exercises where module_slug = 'more-about-strings' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "hello there"
vowels = 0
consonants = 0
for ch in text:
    if ch.isalpha():
        if ch.lower() in "aeiou":
            vowels += 1
        else:
            consonants += 1
print(vowels, consonants)
' from exercises where module_slug = 'more-about-strings' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'sentence = "the quick brown fox jumps"
print(len(sentence.split()))
' from exercises where module_slug = 'more-about-strings' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'sentence = "I love bugs in my code"
print(sentence.replace("bugs", "features"))
' from exercises where module_slug = 'more-about-strings' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'messy = "   hello there   "
cleaned = messy.strip()
print(len(messy), len(cleaned))
' from exercises where module_slug = 'more-about-strings' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'words = ["the", "quick", "brown", "fox"]
print(" ".join(words))
' from exercises where module_slug = 'more-about-strings' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'sentence = "learning python is fun"
words = sentence.split()
print("-".join(words))
' from exercises where module_slug = 'more-about-strings' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'letter = "y"
shift = 3
new_code = (ord(letter) - ord("a") + shift) % 26 + ord("a")
print(chr(new_code))
' from exercises where module_slug = 'more-about-strings' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'word = "cat"
result = ""
for ch in word:
    result += ch * 2
print(result)
' from exercises where module_slug = 'more-about-strings' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'sentence = "the great gatsby"
words = sentence.split()
capitalized = []
for w in words:
    capitalized.append(w[0].upper() + w[1:])
print(" ".join(capitalized))
' from exercises where module_slug = 'more-about-strings' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "12345"
all_digits = True
for ch in text:
    if ch < "0" or ch > "9":
        all_digits = False
print(all_digits)
' from exercises where module_slug = 'more-about-strings' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "mississippi"
target = "s"
for i in range(len(text)):
    if text[i] == target:
        print(i)
' from exercises where module_slug = 'more-about-strings' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'digits = "5551234567"
formatted = digits[:3] + "-" + digits[3:6] + "-" + digits[6:]
print(formatted)
' from exercises where module_slug = 'more-about-strings' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'text = "prefix"
prefix = "pre"
if text[0:3] == prefix:
    print("Starts with prefix")
else:
    print("Does not start with prefix")
' from exercises where module_slug = 'more-about-strings' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'menu = {"coffee": 3.5, "tea": 3.0, "juice": 2.5}
print(menu)
print(menu["tea"])
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 1 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'menu = {"coffee": 3.5, "tea": 3.0}
menu["coffee"] = 4.0
menu["muffin"] = 2.75
print(menu)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 2 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'inventory = {"apples": 10, "bananas": 5, "cherries": 20}
for key, value in inventory.items():
    print(f"{key}: {value}")
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 3 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'prices = {"apple": 1.0, "banana": 0.5}
check_item = "cherry"
if check_item in prices:
    print(prices[check_item])
else:
    print("Not found")
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 4 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'sentence = "the cat sat on the mat and the cat slept"
counts = {}
for word in sentence.split():
    if word in counts:
        counts[word] += 1
    else:
        counts[word] = 1
print(counts)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 5 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'counts = {"the": 5, "cat": 3, "mat": 1}
best_word = None
best_count = -1
for word, c in counts.items():
    if c > best_count:
        best_count = c
        best_word = word
print(best_word)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 6 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'data = {"a": 1, "b": 2, "c": 3}
data.pop("z", None)
print(data)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 7 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'students = {
    "Ada": {"math": 95, "science": 88},
    "Sam": {"math": 78, "science": 91}
}
print(students["Sam"]["science"])
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 8 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'numbers = [1, 2, 3, 4, 5]
squares = {n: n * n for n in numbers}
print(squares)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 9 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'original = {"a": 1, "b": 2, "c": 3}
inverted = {v: k for k, v in original.items()}
print(inverted)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 10 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'first = {"a": 1, "b": 2}
second = {"b": 20, "c": 3}
merged = {**first, **second}
print(merged)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 11 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'allowed = {"ada", "sam", "lee"}
check_user = "sam"
print(check_user in allowed)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 12 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'values = [3, 1, 4, 1, 5, 9, 2, 6, 5]
unique = set(values)
print(sorted(unique))
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 13 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'group_a = {"Ada", "Sam", "Lee"}
group_b = {"Sam", "Max", "Lee"}
print(group_a | group_b)
print(group_a & group_b)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 14 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'set_a = {1, 2, 3, 4}
set_b = {3, 4, 5, 6}
print(set_a - set_b)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 15 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'values = [1, 2, 2, 3, 3, 3, 4]
print(len(set(values)))
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 16 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'ages = {"Ada": 25, "Sam": 30}
print(ages.get("Lee", "unknown"))
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 17 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'people = [("Ada", "science"), ("Sam", "math"), ("Lee", "science")]
groups = {}
for name, category in people:
    if category not in groups:
        groups[category] = []
    groups[category].append(name)
print(groups)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 18 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'set_a = {1, 2, 3}
set_b = {2, 3, 4}
print(set_a ^ set_b)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 19 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
insert into exercise_answers (exercise_id, answer_key) select id, 'counts = {}
words = ["cat", "dog", "cat"]
for w in words:
    if w not in counts:
        counts[w] = 0
    counts[w] += 1
print(counts)
' from exercises where module_slug = 'dictionaries-sets' and sort_order = 20 on conflict (exercise_id) do update set answer_key = excluded.answer_key;
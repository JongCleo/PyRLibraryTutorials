# yield
def fibonacci_generator():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

for i in fibonacci_generator():
    if i > 1000:
        break
    print(i)

# generators
a = (x * x for x in range(100))
print(sum(a))
print(sum(a))

# Counter
from collections import Counter
a = Counter('blue')
b = Counter('yellow')

print(a)
print(b)
print((a + b).most_common(3))

# defaultdict
from collections import defaultdict
my_dict = defaultdict(lambda: 'Default Value')
my_dict['a'] = 42
my_dict['a']
my_dict['b']

# trees with defaultdict
from collections import defaultdict
import json

def tree():
    return defaultdict(tree)

root = tree()
root['Page']['Python']['defaultdict']['Title'] = "Thing A"
root['Page']['Python']['defaultdict']['Subtitle'] = "Thing B"
root['Page']['Java'] = None
print(json.dumps(root, indent=4))

# kind of like expand.grid
from itertools import permutations
for p in permutations(['a', 'b', 'c', 'd']):
    print(p)

# combinations
from itertools import combinations
for c in combinations([1, 2, 3, 4], 2):
    print(c)

# context managers
@contextmanager
def colored_output(color):
    print("\033[%sm" % color, end="")
    yield
    print("\033[0m", end="")

print("Hello, World!")
with colored_output(32):
    print("Now in color!")
print("So cool.")

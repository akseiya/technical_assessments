class Fibonacci:
  cache = [0,1]
  def get_nth(self, n):
    if n < 1: raise 'Fibonacci sequence starts at position 1'
    if n < len(self.cache): return self.cache[n - 1]
    for m in range(len(self.cache), n):
      new_item = self.cache[m - 1] + self.cache[m - 2]
      self.cache.append(new_item)
    return self.cache[n - 1]

def fibonacci(n):
  "Returns n-th expression in Fibonacci sequence"
  if n == 1: return 0
  if n == 2: return 1
  return fibonacci(n - 1) + fibonacci(n - 2)


fibo = Fibonacci()

assert fibo.get_nth(2) == 1
assert fibo.get_nth(3) == 1
assert fibonacci(9) == 21
for i in range(1, 35):
  if i % 10 == 0: print()
  print(fibonacci(i), end='\t', flush=True)
print()
for i in range(100, 110):
  if i % 10 == 0: print()
  print(fibo.get_nth(i), end='\t', flush=True)
print()
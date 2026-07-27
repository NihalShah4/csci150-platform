export const PYTHON_FACTS = [
  "Python is named after Monty Python's Flying Circus, not the snake.",
  "Instagram runs one of the largest Python codebases in the world.",
  "Python's creator, Guido van Rossum, started the language as a holiday project in 1989.",
  "NASA uses Python for data analysis on some of its space missions.",
  "The 'zen of Python' is a real, built-in Easter egg, type import this in any Python shell.",
  "Spotify uses Python heavily for backend data processing.",
  "Python is often the first language taught at top universities because of how readable it is.",
  "The print() function you're using right now traces back to Python's very first release in 1991.",
  "Python powers a huge share of modern machine learning, including tools like PyTorch and TensorFlow.",
  "You can write a working 'Hello, world' program in Python in a single line, no setup required.",
];

export function randomFact(exclude?: string) {
  let fact = PYTHON_FACTS[Math.floor(Math.random() * PYTHON_FACTS.length)];
  if (fact === exclude && PYTHON_FACTS.length > 1) {
    return randomFact(exclude);
  }
  return fact;
}

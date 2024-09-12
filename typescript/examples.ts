
// EXAMPLE: destructured function parameters
// TypeScript requires a name be given 

function foo(args: {
  x: number,
  s: string, 
  }) {
  const { x, s } = args;
  return s + x.toString();
}

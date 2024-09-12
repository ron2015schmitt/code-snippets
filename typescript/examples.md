
### EXAMPLE: destructured function parameters
Similar to JavaScript but TypeScript requires a name be given, such as `args` in the example below 

```TypeScript
function foo(args: {
  x: number,
  s: string, 
  }): string {
  const { x, s } = args;
  return s + x.toString();
}
```

### EXAMPLE: Type AND operator

```TypeScript
type A = { a: number };
type B = { b: string };
type C = { c: boolean };
type ABC = A & B & C;

let y: ABC = { a: 10, b: "hello", c: true };

```
The above type is equivalent to 

```TypeScript
type ABC = { a: number } & { b: string } & { c: boolean };
```

 or simply

```TypeScript
type ABC = {
  a: number,
  b: string,
  c: boolean,
};
```

### EXAMPLE: Interface AND operator

The same syntax works with `interface`'s.

```TypeScript
interface A_I {
  a: number,
};

interface B_I {
  b: string,
};

let p1: A_I = { a: 10 };
let p2: B_I = { b: "hello" };
let p3: A_I & B_I = { a: 10, b: "times" };
```


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
type AandBandC = A & B & C;

const y: AandBandC = { a: 10, b: "hello", c: true };

function foo(args: AandBandC): string {
  const { a, b, c }: AandBandC = args;
  return a.toString() + b + c.toString();
}
```
The above type is equivalent to 

```TypeScript
type AandBandC = { a: number } & { b: string } & { c: boolean };
```

 or simply

```TypeScript
type AandBandC = {
  a: number,
  b: string,
  c: boolean,
};
```

The following code compiles

```TypeScript
type A = { a: number };
type B = { b: string };
type AandB = A & B;

const x: any = { a: 10, b: "hello", c: true }
let y: AandB = x;  // <-- This works: with somewhat surprising result y = { a: 10, b: "hello", c: true }
y = x as AandB;    // This will give same result

const w: any = { a: 10 }
let z: AandB = w;   // <-- This works: with surprising result y = { a: 10 }
z = w as AandB;     // This will give same result
```

But the following are non-examples that fail to compile
```TypeScript
let y: AandB; 
y = { a: 10, b: "hello", c: true }  // <-- COMPILER ERROR: you cannot provide extra fields when assigning from a *literal*
y = { a: 10 }   // <-- COMPILER ERROR:  You must provide both a and b when assigning from a *literal*
y = { b: 10 }   // <-- COMPILER ERROR:  You must provide both a and b when assigning from a *literal*
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

export class MyClass implements A_I, B_I {
  a: number;
  b: string;

  constructor(args: A_I & B_I) {
    this.a = args.a;
    this.b = args.b;
  }
}
```


### EXAMPLE: Type OR operator





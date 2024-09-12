
### EXAMPLE: destructured function parameters
Similar to JavaScript but TypeScript requires a name be given, such as `args` below 

```TypeScript
function foo(args: {
  x: number,
  s: string, 
  }) {
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
```
is equivalent to 

```TypeScript
type ABC = { a: number } & { b: string } & { c: boolean };
```
 and 

 ```TypeScript
type ABC = {
a: number,
b: string,
c: boolean,
};
```

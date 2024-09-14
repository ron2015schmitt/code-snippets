
## Spread operator

Assignment goes from left to right in order

```javascript
x = { a: 5, b: 7};
y = {...x, a: -1};  // y = { a: -1, b: 7 }
y = {a: -1, ...x};  // y = { a: 5, b: 7 }
```

## Currying 

Currying is a transformation of functions that translates a function from callable as f(a, b, c) into callable as f(a)(b)(c)

```javascript
function curry(func) {
  return function curried(...args) {
    if (args.length >= func.length) {
      return func.apply(this, args);
    } else {
      return function (...args2) {
        return curried.apply(this, args.concat(args2));
      }
    }
  };
}
```

## nested access to object properties
```javascript
const get = (object, path, defaultValue = undefined) => {
  let value = path
    .split('.')
    .reduce((o, p) => o == null ? undefined : o[p], object);
  return (value !== undefined) ? value : defaultValue;
}
```

Usage example
```javascript
let x = {  
  value: 12,
  y: {
    value: 23,
    z: {
      value: 34,      
    },
  },
}

console.log(
  get(x, "value",-1)
)
// result --> 12

console.log(
  get(x, "y.value",-1)
)
// result --> 23

console.log(
  get(x, "y.z.value",-1)
)
// result --> 34

console.log(
  get(x, "y.z.w",-1)
)
// result --> -1
```

## instanceof

```javascript
new Set() instanceof Set  // true
null instanceof Set  // false
!(null instanceof Set)  //  true
null !instanceof Set  // !<--syntax error
```

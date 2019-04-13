# FizzBuzz
### What is *FizzBuzz*?
*FizzBuzz* is originally a children's exercise in divisibility that peculiarly developed into a weed-out, programming interview question. Children would count from 1 and say "fizz" in place of numbers divisible by 3, "buzz" in place of numbers divisible by 5, and "fizzbuzz" in place of numbers divisible by 3 and 5. Read the wiki on it [here](https://en.wikipedia.org/wiki/Fizz_buzz).

### How is this exercise translated to computer programming?
In the programming language of interest, the programmer will execute this exercise for all integers from 1 to 100. The interviewee will replace numbers that are divisible by 3 with the word "fizz," replace those divisible by 5 with the word "buzz," replace those divisible by both 3 and 5 with the combination of the two words "fizzbuzz," and print the numbers that meet none of the 3 criteria to the console.

*Example Output*:
```
[1] "1"
[1] "2"
[1] "fizz"
[1] "4"
[1] "buzz"
[1] "fizz"
[1] "7"
[1] "8"
```

The R script included in this repository records my attempt to write the shortest R code to achieve the above goal.

### How it works:
##### ```for(i in 1:100) {print(paste0...```
The R script will iterate for values 1 through 100, inclusive. For each "count" of the iteration, a character vector will be printed. This is because the ```paste0()``` function returns a character vector. ```paste0``` is a special case of the ```paste()``` function wherein the ```sep``` argument is set to ""; it is slightly more efficient here.

##### ```"fizz"[!i %% 3], "buzz"[!i %% 5]```
%% is the [modulo operator](https://en.wikipedia.org/wiki/Modulo_operation) which provides the remainder after division. If the number is divisible by the dividend, then remainder 0 is returned. Otherwise, a non-zero remainder is returned. Therefore, if ```i``` is not divisible by 3, a non-zero remainder is returned. Negating the remainder will produce ```FALSE``` if non-zero (since negation of non-zero values are coerced to ```FALSE```) and ```TRUE``` if ```0``` (since ```!0``` evaluates ```TRUE```).

Now, in R, when an index of 0 is subset, an empty vector is returned. When an index of 1 is subset, the first element of the vector is returned. Since a string in R is simply a character vector of length 1, subsetting index 1 will always return the string. ```"fizz"[0]``` returns ```character(0)```, an empty character vector. ```"fizz"[1]``` returns ```"fizz"```. The same is true of ```"buzz"[0]``` and ```"buzz"[1]```.

##### ```i[all(i %% c(3, 5))]))```
If ```i``` is not divisible by either 3 or 5, then ```i %% c(3,5)``` will evaluate to a non-zero vector of length 2 that denotes the remainder when ```i``` is divided by 3 and the remainder when ```i``` is divided by 5, respectively. ```all(i %% c(3,5))``` will evaluate to ```TRUE``` in this case, since none of the values equal either ```0``` or ```FALSE```. The entire expression ```i[all(i %% c(3, 5))]))``` will then evaluate to ```i[1]``` and return the numeric value of ```i```.

If ```i``` is divisible by either 3 or 5, then the expression will evaluate to a vector of length 2 with at least one ```0``` value. ```all(...)``` will evaluate ```FALSE```, and ```i[0]``` will be returned -- an empty numeric vector.

### Note about warnings on output:

The logical primitives ```any()``` and ```all()``` will coerce doubles to a logical, so a warning will be output:

```
> for(i in 1:100) {print(paste0("fizz"[!i %% 3], "buzz"[!i %% 5], i[all(i %% c(3, 5))]))}
[1] "1"
[1] "2"
[1] "fizz"
[1] "4"
[1] "buzz"
[1] "fizz"
[1] "7"
[1] "8"
...
[1] "fizz"
[1] "94"
[1] "buzz"
[1] "fizz"
[1] "97"
[1] "98"
[1] "fizz"
[1] "buzz"
There were 50 or more warnings (use warnings() to see the first 50)
```
If this is unsatisfactory, one can use the following code instead:
```
> for(i in 1:100) {print(paste0("fizz"[!i %% 3], "buzz"[!i %% 5], i[!any(!i %% c(3, 5))]))}
```
Using logical negation on the argument of ```any()``` will evaluate to either TRUE or FALSE (the value will be coerced before reaching ```any()```) while negating the ```any()``` function as a whole will return the result to
its original logical value.

An example of coercion with ```any()```:

```
> any(5)
[1] TRUE
Warning message:
In any(5) : coercing argument of type 'double' to logical
```

An example that circumvents coercion within the function ```any()```:
```
> any(!5)
[1] FALSE
> !any(!5)
[1] TRUE

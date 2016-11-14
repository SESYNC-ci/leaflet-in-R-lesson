---
---

## Data types and variables

As most programming languages, Python supports basic data types for integers
(`int`), real numbers (`float`), character strings (`str`) and logical 
True/False values (`bool`).

The type of a variable is automatically set when a value is assigned to it,
 using the `=` operator. It can be queried with the built-in `type()`
 function.
 

~~~python
>>> i = 3
>>> type(i)
<class 'int'>

~~~
{:.term}



===

Python supports the usual arithmetic operators:
 `+`, `-`, `*`, `/`, `**` (exponent)  
and comparison operators: 
 `==` (equal), `!=` (non-equal), `<`, `>`, `<=`, `>=` .
 
Both `int` and `float` values can be mixed within an expression; the result is a `float`.


~~~python
>>> r = i + 1.5
>>> print(r, 'is of', type(r))
4.5 is of <class 'float'>

~~~
{:.term}



===

In the code above, we introduced the `print` statement, which prints the output
of multiple Python expressions on the same line, separated by spaces. 
Note that quoted character strings (here, 'is of') are printed as is. 

Let's define a new string variable.


~~~python
>>> s = 'three'
>>> type(s)
<class 'str'>

~~~
{:.term}



===

In Python, the same operator can perform different functions based on the
data types of the operands. See what happens if you "add" two character
strings.


~~~python
>>> s + ' four'
'three four'

~~~
{:.term}


With the basics of assembly instructions out of the way, we will discuss the basics of memory that we will need.

We will have to allocate memory in our program for arrays, strings, numbers, and more. However, we won't deal with dynamically allocating memory (such as with malloc) or anything like that. We will just bake the memory we need into the executable program itself through the assembly equivalent of global variables.

We can allocate strings and numbers in NASM using the following syntax,

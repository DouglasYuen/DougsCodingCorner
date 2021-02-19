# Doug's Coding Corner

This is a general repo for my various code snippets, samples and exercises

## Shopping Budgets

This test takes an array of items and a budget to determine how many different ways there are of buying things if one is to stay within a certain budget. Because of the function used to create the array of possible combiations, the runtime of this code is O(n^2). The budgets and prices are only passed in as integers in this test case, although the function generating the array combinations accepts generics.

## Array Products

Given an array, the objective is to find the product of the array except for the item at the current index. Both the solutions for where division is allowed, and not allowed, are given. Both run in O(n) time. The latter uses dynamic programming to break the array into a suffix array, and for O(1) space complexity, we store the product of the left array rather than the entire left array.

## Occurances Of

This is a simple way to find the number of repeated elements in an abitrary array using Swift's built-in filter() function and runs in O(n).

## BinaryStringMatching

This function determines how many occurances of a given substring matching a binary pattern are in a string. Here, the original string is first converted into a binary string, making it easier to compare the pattern against. The function runs in O(n).

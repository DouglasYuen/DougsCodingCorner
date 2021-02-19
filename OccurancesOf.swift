/**
Given an array of integers, determine how many times a certain number passed in is repeated.
**/

//********************//
// BODY FUNCTIONS
//********************//

// Main function, a linear search
// Overall time complexity: O(n)
// Explanation: We're doing an array filter function on the condition that a value in the array is equal to the target value. Filter is O(n), and all the other operations are O(1)

func occurancesOf(_ target:Int, in array:[Int]) -> Int
{
	// Create a filtered array where the items must be equal to the target
	let filtered = array.filter({$0 == target})
	
	// Get the count of the filtered array and return it
	let count = filtered.count
	
	return count	
}

//********************//
// TEST
//********************//

let testArray = [1, 1, 2, 2, 2, 2, 3]
let target = 2

let resultant = occurancesOf(target, in:testArray)

print(resultant)
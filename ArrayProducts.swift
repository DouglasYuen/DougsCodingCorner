/**
Given an array of integers, return a new array such that each element at index i of the new array is the product of all the numbers in the original array except the one at i.
**/

//********************//
// BODY FUNCTIONS
//********************//

// Function for if division were allowed
// Time complexity: O(n)
// Explanation: We have one reduce operation, which is O(n), and one loop, which is O(n). The total is O(2n), but asymptotically, this is O(n)
// Space complexity: O(1)
// Explanation: We're creating a new array to hold the results, which requires constant space

func productsDivision(input:[Int]) -> [Int]
{
	// Create a new array to store the products
	var resultant:[Int] = []
	
	// Precalculate the array's total product
	let product = input.reduce(1, *)
	
	// For every item in the array
	for index in (0..<input.count)
	{
		// Take the quotient of the total product with what's at input[index], which is a O(n)
		resultant.append(product / input[index])
	}
	
	return resultant
}

// Function for if division were not allowed: we'll need to split the array into a left and right array, traverse the right array to computer a partial product, and then use the original array to compute the remaining product.
// Time complexity: O(n)
// Explanation: Since we're using for-loops in sequence, without nesting, the time complexity remains O(n)
// Space complexity: O(1)
// Explanation: We're creating a new array to hold the results, which requires constant space

func productsSplit(input:[Int]) -> [Int]
{
	// Create a new array to hold the results and initialise everything with 1
	var resultant:[Int] = [Int](repeating: 1, count: input.count)

	// Working backwards, traverse the input array and compute product of the suffix array
	// This acts as the right array
	for index in (0..<(input.count - 1)).reversed()
	{
		resultant[index] = resultant[index + 1] * input[index + 1]
	}
	
	// Variable for the product of the left side of the array
	// To keep overhead low, we'll compute the product rather than store the entire prefix array
	var left = 1

	//Iterate through the original input array
	for index in 0..<input.count
	{
		// At index 0, there is nothing to the left.
		if index == 0
		{
			// The product at index 0 is whatever was at index 0 in the suffix array
			resultant[index] = left * resultant[index]
		}
		
		// Everywhere else, there is a value at index - 1
		else
		{
			// The product "left" is whatever value was in the index array's index - 1 position
			left = left * input[index - 1]
			// Take the product of the "left" and what is in the resultant to get the final product at the index
			resultant[index] = left * resultant[index]
		}
	}
	
	// When done, return the resultant array
	return resultant
}

//********************//
// TEST
//********************//

let inputArray = [1, 2, 3, 4, 5]

let resultsDivision = productsDivision(input: inputArray)
let resultsSplit = productsSplit(input: inputArray)

print(resultsDivision)
print(resultsSplit)

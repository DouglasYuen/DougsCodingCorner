//********************//
// BODY FUNCTIONS
//********************//

// Main function
// Overall time complexity: O(n^2)
// Explanation: combinations() is O(n^2) because of the nested for-loops, and for-loop in checkPossibleCombinations() is O(n). Assignments and conditionals are O(1). Total is O(n^2) + O(n), but asymptotically, this is just O(n^2)

func checkPossibleCombinations(budget:Int, shoes:[Int], skirts:[Int], tops:[Int], hats:[Int]) -> Int
{
	
	// First, get all items into an array of arrays
	let items = [shoes, skirts, tops, hats]
	
	// Initially, there are no combinations in budget
	var totalPossible:Int = 0
	
	// Create an array of the combinations
	let itemCombos = combinations(of: items)

	//Iterate through and see if a combination is in budget
	for combination in itemCombos
	{
		// If it is, increment the possible counter
		if isInBudget(limit: budget, items: combination)
		{
			totalPossible += 1
		}
	}
	
	// Return when finished
	return totalPossible
}

// Iteratively creates an array with all possible combinations of arrays passed in
// For fun, make this a generic

func combinations<T>(of array:[[T]]) -> [[T]]
{
	// Reduce the array, which is initially an empty array of arrays
	return array.reduce([[]]){
		var output:[[T]] = []
	
		// For every array of arrays "i"
		for i in $0
		{
			// For every T in the array "j"
			for j in $1
			{
				// Add the item of j to i, the array of arrays
				output.append(i + [j])
			}
		}
		
		// Return when done
		return output
	}
}

// Helper function to see if items are in budget, return a bool when done

func isInBudget(limit:Int, items:[Int]) -> Bool
{
	let total = items.reduce(0, +)
	return total <= limit
}

//********************//
// TEST
//********************//

let shoes = [4]
let skirts = [2, 2]
let tops = [2, 3, 1]
let hats = [2, 3]

let budget = 10

let result = checkPossibleCombinations(budget:budget, shoes:shoes, skirts:skirts, tops:tops, hats:hats)

print(result)

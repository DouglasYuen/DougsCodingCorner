/**
Given a string and a pattern, determine how many time the pattern appears in the string provided that the pattern is a binary string, where 0 represents integers and 1 represents consonants.
**/

//********************//
// BODY FUNCTIONS
//********************//

// Main function
// Overall time complexity: O(n)
// Explanation: We're doing two for-loops (O(n) each): the first is to create the binary string, then we step through the ranges to generate a partial string. If the partial string matches, then add to the count.

func matching(text:String, pattern:String) -> Int
{
	// Instead of comparing letters, we'll compare 0s and 1s
	let binaryString = toBinary(text: text)
	
	// At first, we have zero instances of our pattern in the text
	var instancesOf = 0
	
	// Starting at index zero, up to the highest value shorter than the pattern
	for i in 0...binaryString.count - pattern.count
	{	
	
		// Get the start index in the binary string as being at i
		let start = String.Index(utf16Offset: i, in: binaryString)
		
		// Get the end index in the binary string as being wherever the pattern ends
		let end = String.Index(utf16Offset: i + (pattern.count), in: binaryString)
	
		// Create the partial string
		let partialString = String(binaryString[start..<end])
		
		// If we have a match, increment the instancesOf counter
		if partialString == pattern
		{
			instancesOf += 1
		}
	}
	
	// When done everything, return it
	return instancesOf
}

// Helper function to convert a string into binary based on vowels and consonants 

func toBinary(text:String) -> String
{
	// Vowels are defined
	let vowels = ["a", "e", "i", "o", "u"]
	
	// Create output to hold everything
	var outputString = ""
	
	// For each letter, let 0 be a vowel, 1 be a consonant
	for char in text.lowercased()
	{
		if vowels.contains(String(char))
		{
			outputString.append("0")
		}
		
		else
		{
			outputString.append("1")
		}
	}
	
	return outputString
}

//********************//
// TEST
//********************//

let test = matching(text: "amazing", pattern: "1")
print(test)
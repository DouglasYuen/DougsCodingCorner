/**
Validate an arbiturary Sudoku puzzle: a puzzle is valid if it does not contain a duplicate value in the same row, column or square.
**/

//********************//
// BODY FUNCTIONS
//********************//

// Valudates the Sudoku, passed in as a 2D array
// Accepts an array of integers, where '0' values represent empty cells
// Time complexity: O(n^2)
// Explanation: The most expensive operation is creating the blocks, which requires an additional .reduce() operation inside the for loop. This is a naive solution, will need to improve the efficiency!

func validateSudoku(_ sudoku:[[Int]]) -> Bool
{
	// Get the size of the Sudoku puzzle
	
	let size = Float(sudoku.count)
	let squareRoot = Int(size.squareRoot())
	
	// Initially, the Sudoku is invalid
	
	var validRows = false
	var validColumns = false
	var validBlocks = false
	
	// First, validate the rows
	// If there was a row that isn't valid, stop
	// Otherwise, every row is valid
	
	for i in 0..<sudoku.count
	{
		if !validate(line:sudoku[i])
		{
			validRows =  false
			break
		}
		
		validRows =  true
	}
	
	// Then, validate the columns
	// We'll create columns first and then validate these
	
	for i in 0..<sudoku.count
	{
		var column:[Int] = []
		
		for j in 0..<sudoku[i].count
		{
			column.append(sudoku[j][i])
		}
		
		if !validate(line:column)
		{
			validColumns =  false
			break
		}
		
		validColumns =  true
	}
	
	// Finally, validate each block
	// Create a sequence representing the stride size
	// This determines where to start a block
	// "Block size" is how many items each block has
	// "Offset" is how many indecies the last block is from the starting index
	
	let first = 0
	let last = sudoku.count - 1
	let blockSize = squareRoot
	let offset = blockSize - 1
	
	let sequence = stride(from: first, to: last, by: blockSize)

	// Loop through the sequence and make the block from the Sudoku at the starting (i, j) defined by the sequence
	//TODO:- create the array of blocks first and then it's more efficient to check these
	
	outerLoop: for i in sequence
	{
		var block:[Int] = []
		
		for j in sequence
		{
			block = makeBlock(sudoku:sudoku, startRow:i, startColumn:j, offset: offset).flatMap{$0}

			if !validate(line: block)
			{
				validBlocks = false
				break outerLoop
			}
			
			validBlocks = true
		}
	}
	
	// When done, check to see if the Sudoku is valid (i.e. rows, columns and blocks are good)
	// Then return this value as a boolean
	
	let validSudoku =  validRows && validColumns && validBlocks
	return validSudoku
}

// Returns if a line passed in, representing the row, column or block of integers, is valid
// First, remove the zeroes (empty cells), and then make the check

func validate(line:[Int]) -> Bool
{
	let cleaned = line.filter{$0 > 0}
	return cleaned.isUnique
}

// From the Sudoku passed in, make all of the blocks inside that Sudoku
// "Offset" refers to the upper bound on the index for the block (a block of size 3 has an offsert of 2, for instance)
// Returns a 2D array

func makeBlock(sudoku:[[Int]], startRow:Int, startColumn:Int, offset:Int) -> [[Int]]
{
	var block:[[Int]] = []
	let blockOffset = offset

	for i in startRow...(startRow + blockOffset)
	{
		var subRow:[Int] = []
		
		for j in startColumn...(startColumn + blockOffset)
		{
			subRow.append(sudoku[i][j])
		}
		
		block.append(subRow)
	}
	
	return block
}

//********************//
// SUPPORT FUNCTIONS
//********************//

enum DuplicateError: Error { case duplicate }

// Array extension: check to see if an array has duplicate values
// Attempt to create a dictionary with the array's contents as keys
// If the key already exists, throw an error and return false: the array isn't unqiue (i.e. has duplicate(s))

extension Array where Element: Hashable
{
	var isUnique: Bool
	{
		do
		{
			_ = try Dictionary(self.map { ($0, ()) }, uniquingKeysWith: { _, _ in
				throw DuplicateError.duplicate
			})
			return true
		}
		
		catch
		{
			return false
		}
	}
}

//********************//
// TEST
//********************//

let sudokuGood2X2Unfilled = [
	[1, 0, 0, 0],
	[0, 0, 0, 4],
	[0, 0, 2, 0],
	[0, 3, 0, 0]
]

let sudokuBadX2Unfilled  = [
	[1, 0, 0, 0],
	[0, 0, 0, 4],
	[0, 0, 2, 0],
	[1, 3, 0, 2]
]

let sudokuGood3X3Filled = [
	[8,3,5,4,1,6,9,2,7],
	[2,9,6,8,5,7,4,3,1],
	[4,1,7,2,9,3,6,5,8],
	[5,6,9,1,3,4,7,8,2],
	[1,2,3,6,7,8,5,4,9],
	[7,4,8,5,2,9,1,6,3],
	[6,5,2,7,8,1,3,9,4],
	[9,8,1,3,4,5,2,7,6],
	[3,7,4,9,6,2,8,1,5]
]

let sudokuBad3X3Filled = [
	[8,3,5,4,1,6,9,2,7],
	[2,9,6,8,5,7,4,3,1],
	[5,6,9,1,3,4,2,8,2],
	[1,2,3,6,7,8,5,4,9],
	[1,2,3,6,7,8,5,4,9],
	[7,4,8,5,2,9,1,6,3],
	[6,5,2,7,8,1,3,9,4],
	[9,8,1,3,4,5,2,7,6],
	[3,7,4,9,6,2,8,1,5]
]

let sudokuGood3X3Unfilled = [
	[5, 3, 0, 0, 7, 0, 0, 0, 0],
	[6, 0, 0, 1, 9, 5, 0, 0, 0],
	[0, 9, 8, 0, 0, 0, 0, 6, 0],
	[8, 0, 0, 0, 6, 0, 0, 0, 3],
	[4, 0, 0, 8, 0, 3, 0, 0, 1],
	[7, 0, 0, 0, 2, 0, 0, 0, 6],
	[0, 6, 0, 0, 0, 0, 2, 8, 0],
	[0, 0, 0, 4, 1, 9, 0, 0, 5],
	[0, 0, 0, 0, 8, 0, 0, 7, 9]
]

let sudokuBad3X3Unfilled = [
	[6, 3, 0, 1, 7, 0, 0, 0, 0],
	[6, 0, 0, 1, 9, 5, 0, 0, 0],
	[0, 9, 8, 0, 0, 0, 0, 6, 0],
	[8, 0, 0, 0, 6, 0, 0, 0, 3],
	[4, 0, 0, 8, 0, 3, 0, 0, 1],
	[7, 0, 0, 0, 2, 0, 0, 0, 6],
	[0, 6, 0, 0, 0, 0, 2, 8, 0],
	[0, 0, 0, 4, 1, 9, 0, 0, 5],
	[0, 0, 0, 0, 8, 0, 0, 7, 9]
]

let sudokuZero3X3 = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0]
]

let sudokuGood4X4Unfilled = [
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
]

let sudokuBad4X4Unfilled = [
	[1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0],
	[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0]
]

print(validateSudoku(largeBad))

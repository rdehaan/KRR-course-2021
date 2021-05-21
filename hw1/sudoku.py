import sys, os
import argparse
import math

from codetiming import Timer

### Check if a solved sudoku is correct
def check_solved_sudoku(sudoku,k):
    # Check if each row has different values
    # (return False if not)
    for row in sudoku:
        if set(row) != set(range(1,k**2+1)):
            return False
    # Check if each row has different values
    # (return False if not)
    for j in range(k**2):
        if set(sudoku[i][j] for i in range(k**2)) != set(range(1,k**2+1)):
            return False
    # Check if each block has different values
    # (return False if not)
    for i1 in range(0,k):
        for j1 in range(0,k):
            values = []
            for i2 in range(0,k):
                for j2 in range(0,k):
                    i = i1*k + i2
                    j = j1*k + j2
                    values.append(sudoku[i][j])
            if set(values) != set(range(1,k**2+1)):
                return False
    # If no check failed, return True
    return True


### Read sudoku from file
def read_sudoku_from_file(filename):
    try:
        file = open(filename, "r")
        sudoku = []
        for line in file.readlines():
            if line.strip() != "":
                row = list(map(int,line[:-1].strip().split(" ")))
                sudoku.append(row)
        height = len(sudoku)
        k = int(math.sqrt(height))
        if height == k**2:
            rows_correct = True
            for row in sudoku:
                if len(row) != height:
                    rows_correct = False
                for entry in row:
                    if not (isinstance(entry, int) and 0 <= entry and entry <= height):
                        rows_correct = False
            if not rows_correct:
                print("Wrong input format")
                return None,None
            else:
                return (k,sudoku)
        else:
            print("Wrong input format")
            return None,None
    except Exception as e:
        print("Something went wrong while reading from " + filename + " (" + str(e) + ")")
        return None,None


### Plain representation (for file storage)
def plain_repr(sudoku,k):
    repr = ""
    # Add the rows plainly, with spaces as separator
    for row in sudoku:
        repr += " ".join(map(str,row)) + "\n"
    # Return the constructed string (without trailing '\n')
    return repr[:-1]

### Pretty printing representation
def pretty_repr(sudoku,k):
    repr = ""
    numwidth = len(str(k**2))
    def pretty_line(k):
        return "+" + "+".join(["-"*((numwidth+1)*k+1)]*k) + "+\n"

    # Add a line separator at the beginning
    repr += pretty_line(k)
    rownum = 0
    # Go through all rows of the sudoku
    for i in range(0,k):
        for j in range(0,k):
            # Add a row of the sudoku
            repr += "| "
            for u in range(0,k):
                for v in range(0,k):
                    if sudoku[rownum][u*k+v] != 0:
                        repr += str(sudoku[rownum][u*k+v]).zfill(numwidth) + " "
                    else:
                        repr += " "*numwidth + " "
                repr += "| "
            repr += "\n"
            rownum += 1
        # Add a line separator after every k'th row
        repr += pretty_line(k)
    # Return the constructed string (without trailing '\n')
    return repr[:-1]


###
class suppress_stdout_stderr(object):
    '''
    A context manager for doing a "deep suppression" of stdout and stderr in
    Python, i.e. will suppress all print, even if the print originates in a
    compiled C/Fortran sub-function.
       This will not suppress raised exceptions, since exceptions are printed
    to stderr just before a script exits, and after the context manager has
    exited (at least, I think that is why it lets exceptions through).
    (From: https://stackoverflow.com/questions/11130156/suppress-stdout-stderr-print-from-python-functions)
    '''
    def __init__(self):
        # Open a pair of null files
        self.null_fds =  [os.open(os.devnull,os.O_RDWR) for x in range(2)]
        # Save the actual stdout (1) and stderr (2) file descriptors.
        self.save_fds = (os.dup(1), os.dup(2))

    def __enter__(self):
        # Assign the null pointers to stdout and stderr.
        os.dup2(self.null_fds[0],1)
        os.dup2(self.null_fds[1],2)

    def __exit__(self, *_):
        # Re-assign the real stdout/stderr back to (1) and (2)
        os.dup2(self.save_fds[0],1)
        os.dup2(self.save_fds[1],2)
        # Close the null files
        os.close(self.null_fds[0])
        os.close(self.null_fds[1])


###
### Solver that uses recursion and propagation
###
def solve_sudoku_prop(sudoku,k):

    # Initialize data structure
    sudoku_possible_values = []
    for row in sudoku:
        row_possibilities = []
        for element in row:
            if element == 0:
                possibilities = list(range(1,k**2+1))
            else:
                possibilities = [element]
            row_possibilities.append(possibilities)
        sudoku_possible_values.append(row_possibilities)

    # Find a cell where there is still more than one possibility
    def find_uncertain_cell(sudoku_possible_values):
        for i in range(k**2):
            for j in range(k**2):
                possibilities = sudoku_possible_values[i][j]
                if len(possibilities) > 1:
                    return (i,j)
        return None

    # Check if we ran into a contradiction
    def contradiction(sudoku_possible_values):
        # Contradiction type 1: some cell has no further possible values
        for i in range(k**2):
            for j in range(k**2):
                possibilities = sudoku_possible_values[i][j]
                if len(possibilities) == 0:
                    return True
        # Contradiction type 2a: two cells in the same row are assigned the same value
        for i in range(k**2):
            certain_values = []
            for j in range(k**2):
                possibilities = sudoku_possible_values[i][j]
                if len(possibilities) == 1:
                    value = possibilities[0]
                    if value in certain_values:
                        return True
                    else:
                        certain_values.append(value)
        # Contradiction type 2b: two cells in the same column are assigned the same value
        for j in range(k**2):
            certain_values = []
            for i in range(k**2):
                possibilities = sudoku_possible_values[i][j]
                if len(possibilities) == 1:
                    value = possibilities[0]
                    if value in certain_values:
                        return True
                    else:
                        certain_values.append(value)
        # Contradiction type 2c: two cells in the same block are assigned the same value
        for i1 in range(k):
            for j1 in range(k):
                certain_values = []
                for i2 in range(k):
                    for j2 in range(k):
                        i = i1*k + i2
                        j = j1*k + j2
                        possibilities = sudoku_possible_values[i][j]
                        if len(possibilities) == 1:
                            value = possibilities[0]
                            if value in certain_values:
                                return True
                            else:
                                certain_values.append(value)
        return False

    # Make a deep copy
    def deep_copy(sudoku_possible_values):
        copy = []
        for row in sudoku_possible_values:
            row_copy = []
            for element in row:
                element_copy = element.copy()
                row_copy.append(element_copy)
            copy.append(row_copy)
        return copy

    # Recursive function to solve the sudoku, using propagate()
    def solve_recursively(sudoku_possible_values):
        # Check if we ran into a contradiction:
        if contradiction(sudoku_possible_values):
            return None
        else:
            # Propagate
            sudoku_possible_values = propagate(sudoku_possible_values,k)
            # Check for contradictions
            if contradiction(sudoku_possible_values):
                return None
            # Find a cell that is still uncertain
            uncertain_cell = find_uncertain_cell(sudoku_possible_values)
            if uncertain_cell == None:
                return sudoku_possible_values
            else:
                i,j = uncertain_cell
                # Recurse on the different values for cell i,j
                possibilities = sudoku_possible_values[i][j]
                for poss in possibilities:
                    sudoku_possible_values_copy = deep_copy(sudoku_possible_values)
                    sudoku_possible_values_copy[i][j] = [poss]
                    answer = solve_recursively(sudoku_possible_values_copy)
                    if answer != None:
                        return answer
            # If no solution was found in the recursion, conclude there is no solution
            return None

    # Solve the sudoku by recursion
    solution = solve_recursively(sudoku_possible_values)
    if solution == None:
        return None
    # Transform the data structure into a solution, and return it
    solved_sudoku = []
    for i in range(k**2):
        row = []
        for j in range(k**2):
            possibilities = solution[i][j]
            if len(possibilities) != 1:
                return None
            else:
                row.append(possibilities[0])
        solved_sudoku.append(row)
    return solved_sudoku



### Main
def sudoku(input, verbose, solver):

    input = "inputs/easy3.sudoku"
    verbose = "True"
    solver = "sat"

    # Read sudoku from input file
    if verbose:
        print("Reading sudoku from " + input + "..")
    k,sudoku = read_sudoku_from_file(input)
    if sudoku == None:
        print("Exiting..")
        return

    # Print information, in verbose mode
    if verbose:
        print("Input sudoku:")
        print(pretty_repr(sudoku,k))

    # Solve the sudoku using the selected solver
    solved_sudoku = None
    if solver == "sat":
        #timer = Timer(name="solving-time", text="Did SAT encoding & solving in {:.2f} seconds")
        if verbose:
            print("Solving sudoku using the SAT encoding..")
            #timer.start()
        with suppress_stdout_stderr():
            solved_sudoku = sudoku
            #solved_sudoku = solve_sudoku_SAT(sudoku,k)

        ##if verbose:
            ##timer.stop()
    elif solver == "csp":
        timer = Timer(name="solving-time", text="Did CSP encoding & solving in {:.2f} seconds")
        if verbose:
            print("Solving sudoku using the CSP encoding..")
            timer.start()
        with suppress_stdout_stderr():
            solved_sudoku = solve_sudoku_CSP(sudoku,k)
        if verbose:
            timer.stop()
    elif solver == "asp":
        timer = Timer(name="solving-time", text="Did ASP encoding & solving in {:.2f} seconds")
        if verbose:
            print("Solving sudoku using the ASP encoding..")
            timer.start()
        with suppress_stdout_stderr():
            solved_sudoku = solve_sudoku_ASP(sudoku,k)
        if verbose:
            timer.stop()
    elif solver == "ilp":
        timer = Timer(name="solving-time", text="Did ILP encoding & solving in {:.2f} seconds")
        if verbose:
            print("Solving sudoku using the ILP encoding..")
            timer.start()
        with suppress_stdout_stderr():
            solved_sudoku = solve_sudoku_ILP(sudoku,k)
        if verbose:
            timer.stop()
    elif solver == "prop":
        timer = Timer(name="solving-time", text="Did recursive solving with propagation in {:.2f} seconds")
        if verbose:
            print("Solving sudoku using recursion and propagation..")
            timer.start()
        with suppress_stdout_stderr():
            solved_sudoku = solve_sudoku_prop(sudoku,k)
        if verbose:
            timer.stop()

    # Print the solved sudoku
    if solved_sudoku == None:
        print("NO SOLUTION FOUND")
    else:
        if check_solved_sudoku(solved_sudoku,k) == True:
            print(pretty_repr(solved_sudoku,k))
        else:
            print("INCORRECT SOLUTION FOUND")
            print(pretty_repr(solved_sudoku,k))
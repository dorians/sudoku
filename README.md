Sudoku solver
=============

It's a tool written in ruby to solve sudoku. You can use it as a library or with a command line.

Instalation
-----------

    gem install sudoku-solver

Usage
-----

If you want use it on Ubuntu you should add path to folder with gem's executable files (I really don't know why it 
isn't set by default):

    export PATH=$PATH:/var/lib/gems/1.8/bin

Now you can use it:

    solve-sudoku file
    
A file parameter must be a correct path to file with sudoku which should look like this:

    +---+---+---+
    | 6 |   | 2 |
    |   |   |73 |
    |  8| 5 |6  |
    +---+---+---+
    | 9 |5  |  4|
    | 5 |3 8| 7 |
    |4  |  9| 1 |
    +---+---+---+
    |  6| 1 |2  |
    | 31|   |   |
    | 7 |   | 4 |
    +---+---+---+
    
If you can use this program as library check sources of executable file.
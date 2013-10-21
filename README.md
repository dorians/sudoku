Sudoku solver
=============

It's a tool written in ruby which was created to solve sudoku. You can use it as a library or with a command line.

Instalation
-----------

    gem install sudoku-solver

Usage
-----

If you want to use it on Ubuntu you should add path to folder with gems' executable files (I really don't know why it 
isn't set by default):

    export PATH=$PATH:/var/lib/gems/1.8/bin

Now you can use it by typing:

    solve-sudoku file
    
A file parameter must be a correct path to file containing sudoku and should look like this:

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
    
If you want to use this program as library, please check source of an executable file.

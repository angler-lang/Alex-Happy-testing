# Alex-Happy-testing
Toy calculators for testing Alex and Happy

## *Pure calculator*

Prefix operations with integers. The possible operations are `+`, `-`, `*` and `/`, an end of line can be commented with `# comment`.

#### Example

    > + 10 5
    15
    > * + 10 5 20
    300
    > * 20 + 10 5       # comments are after `#`
    300
    > / 16 * 6 - 20 4   # equivalent to 16 / ((20 - 4) * 6)
    0
    > / 1 0             # in case of division by zero
    -- división entre cero
    > - 5 * 2           # in case of a parsing error
    -- error de parseo
    >                   # control-D to end the program

**Note:** the "`> `" at the start of every line should be written by the program, not the user.

## *Stateful calculator*

Infix operations with integers and identifiers. The possible operations are `+`, `-`, `*` and `/`, parenthesis can be used `(` and `)`, an end of line can be commented with `# comment`.

To define a new identifier, use the syntax `let <identifier> = <expression>`.

#### Example

    > 10 + 5
    15
    > let x = 5         # first time `x` was seen
    -- x creado
    > (10 + x) * 20
    300
    > let x = x + 1     # in case of updating an identifier
    -- x actualizado
    > x
    6
    > 16 / (x * (20 - 4))
    0
    > x / 0
    -- división entre cero
    > - 5 * 2
    -- error de parseo
    >

**Note:** the "`> `" at the start of every line should be written by the program, not the user.

# Tcl docs

Tcl is command-oriented language. A basic command syntax is:

```tcl
commandName arg1 arg2 arg3 ...
```

The character for comments is `#`.

You can refer to a variable using the `$` symbol.

In Tcl, square brackets `[]` indicate *command substitution*. Whenever the Tcl interpreter sees `[ ... ]`, it treats whatever is inside the brackets as a command to be executed first.

In Tcl, curly braces `{}` serve primarily as *grouping delimiters* that turn everything between them into a literal string (with minimal substitutions). They are used in several ways:

- Grouping Command Arguments
- Preventing Variable and Command Substitutions
- Multi-Line Grouping
- Protecting expr Expressions

| Tcl functions            | Description                                |
| ------------------------ | ------------------------------------------ |
| `puts`                   | Print to the std output                    |
| `set <var_name> <value>` | Create simple variables                    |
| `clock seconds`          | Returns the time in seconds since the call |
| `expr`                   | Evaluate an expression command                                            |


## References

https://www.tcl.tk/man/tcl8.5/tutorial/Tcl41.html
# empty-folder-deleter
A simple script for deleting empty directories in Linux.

## Use
`/empty-folder-deleter.sh path/to/directory [-va]`

### Verbose mode
Verbose mode prints a message stating that an empty folder has been found and is about to be deleted. This option is enabled by typing `v` when running the program, as shown above.

### Ask mode
Ask mode prints a message warning that an empty folder has been found and is about to be deleted. Asks the user if he/she is sure about it and has to enter an `Y` for a yes or an `N` for a no. To enable this feature, an `a` has to be typed when running the program, as shown above.

Ask mode and Verbose mode are complimentary.

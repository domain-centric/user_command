# user_command

## Command
The Command class is a unified definition of a user command.
A Command has a (dynamic):
 - name
 - action (code to execute when the user clicks on the command)
 - (optional) icon
 - (optional) visibility

## Command widgets
Command's can be used in the following widgets:
 - CommandTextButton
 - CommandElevatedButton
 - CommandPopupMenuItem (e.g. Within a CommandPopupMenu)
 - CommandToolbarButton (e.g. Within a CommandToolbar)
 - Etc...

## Command widget styling
These widgets all have a single style class that:
 - uses reasonable formatting defaults when no style parameters are given.
 - contains style parameters for all the formatting:
   - sizing
   - colors
   - fonts
   - padding
   - aligning
   - elevation
   - etc

## Installation and usage

See [Installation and usage][TODO]

## Example

See [Example][TODO]

## Online Demo

See [Online demo][TODO]
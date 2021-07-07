# user_command

## Command
The Command class is a unified definition of a user command.
A Command has a (dynamic):
 - name
 - action (code to execute when the user clicks on the command)
 - (optional) icon
 - (optional) visibility

Note that the Command class has no disabled state, because [disabled buttons suck](https://axesslab.com/disabled-buttons-suck/).

## Command widgets
Command's can be used in the following widgets:
 - CommandTextButton
 - CommandElevatedButton
 - CommandOutlinedButton
 - CommandPopupMenuItem (e.g. Within a CommandPopupMenu)
 - CommandPopupMenuButton
 - CommandPopupMenuWrapper
 - CommandToolbarButton (e.g. Within a CommandToolbar)
 - CommandTile (e.g. Within a CommandListView)
 - Etc...

## Command widget styling
These Command widgets all have a single style class that:
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

See [Installation and usage](TODO)

## Example

See [Example](TODO)

## Online Demo

See [Online demo](TODO)
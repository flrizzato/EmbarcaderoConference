"Marine Adventures" aka "mastapp"
=========================================

2014.04.17 - pawel.glowacki@embarcadero.com

Updated to Delphi XE6 RTM


=========================================

2014.03.21 - pawel.glowacki@embarcadero.com

Update to Delphi XE6 beta 7
Changed default style to "Glossy"
Added "UpdateAppCaption" private method to include current style name in the main form's caption

===========================================


2014.02.11 - pawel.glowacki@embarcadero.com

Updated to Delphi XE5 Update 2
Changed default style "Cyan Night"

Project -> Options -> Forms -> Appearance
Verify „Cyan Night” style is selected in the combo

Project -> View Source
Highlight this line of code:
 TStyleManager.TrySetStyle('Cyan Night');

Run application
Click on „Browse” and „Parts” to display multiple forms at once, reposition
Change style from „Styles” combo and observe style changed in all forms

===========================================

2013.05.16 - pawel.glowacki@embarcadero.com

"Marine Adventures" is the old "mastapp" demo converted to XE4 and InterBase XE3.
This is a starting point for the multi-device, FireMonkey version of this demo. 
The InterBase database file "MASTSQL2.IB" needs to be copied to "C:\Data" folder.
The "VCL" folder contains a VCL version of the demo with VCL styles enabled and has been converted by Stephen Ball from IBX to DBExpress.



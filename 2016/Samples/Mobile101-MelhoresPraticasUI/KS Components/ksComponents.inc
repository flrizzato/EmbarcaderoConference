

{$IFDEF VER290}
{$DEFINE XE8_OR_NEWER}
{$ENDIF}

{$IFDEF VER300}
{$DEFINE XE8_OR_NEWER}
{$DEFINE XE10_OR_NEWER}
{$ENDIF}

{$IFDEF VER310}
{$DEFINE XE8_OR_NEWER}
{$DEFINE XE10_OR_NEWER}
{$DEFINE XE11_OR_NEWER}
{$ENDIF}

{ *** HTML SUPPORT - PLEASE READ ***

In order to use the HTML formatting within ksListView, you will need to have the
TMS Pack for FireMonkey installed.

You can get this from the following link...
http://www.tmssoftware.com/site/tmsfmxpack.asp

Once installed, simply uncomment the conditional define below }

{.$DEFINE USE_TMS_HTML_ENGINE}

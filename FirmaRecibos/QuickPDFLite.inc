QuickPDFLite        CLASS,Type,MODULE('QuickPDFLite.clw'),LINK('QuickPDFLite.clw',_QPLLiteLinkMode_),DLL(_QPLLiteDllMode_)

              ! Properties -----------------------------------------------------------------------
W                          &Window
cOLE                       Short
DllName                    STRING('DebenuPDFLibraryLite1114.dll {16}')
ProgID                     STRING('DebenuPDFLibraryLite1114.PDFLibrary {46}')

              ! Methods -----------------------------------------------------------------------
Init                        Procedure(*Window W,Short OLEControl),VIRTUAL,Proc
AddImageFromFile            PROCEDURE(STRING FileName, long Options),LONG,VIRTUAL,PROC
AddLinkToWeb                PROCEDURE(REAL Left,REAL Top, REAL Width, REAL Height,STRING Link, LONG Options),LONG,VIRTUAL,PROC
AddStandardFont             PROCEDURE(LONG StandardFontID),LONG,VIRTUAL,PROC
DocumentCount               PROCEDURE(),LONG,VIRTUAL
DrawImage                   PROCEDURE(REAL Left,REAL Top, REAL Width, REAL Height),LONG,VIRTUAL,PROC
DrawText                    PROCEDURE(REAL XPos,REAL YPos, STRING Text_),LONG,VIRTUAL,PROC
DrawTextBox                 PROCEDURE(REAL XPos,REAL YPos, REAL Width, REAL Height, STRING Text_, LONG Options),LONG,VIRTUAL,PROC
FindImages                  PROCEDURE(),LONG,VIRTUAL
GetInformation              PROCEDURE(LONG Key),STRING,VIRTUAL
GetPageBox                  PROCEDURE(LONG BoxType, LONG Dimension),REAL,VIRTUAL
HasFontResources            PROCEDURE(),LONG,VIRTUAL
ImageCount                  PROCEDURE(),LONG,VIRTUAL
ImageHeight                 PROCEDURE(),LONG,VIRTUAL
ImageWidth                  PROCEDURE(),LONG,VIRTUAL
LastErrorCode               PROCEDURE(),LONG,VIRTUAL
Linearized                  PROCEDURE(),LONG,VIRTUAL
LoadFromFile                PROCEDURE(STRING FileName, STRING Password),LONG,VIRTUAL,PROC
MergeDocument               PROCEDURE(LONG DocumentID),LONG,VIRTUAL,PROC
NewDocument                 PROCEDURE(),LONG,VIRTUAL
NewPage                     PROCEDURE(),LONG,VIRTUAL
NormalizePage               PROCEDURE(LONG NormalizeOptions),LONG,VIRTUAL
OpenInAdobe                 PROCEDURE(STRING PDFFile),VIRTUAL
PageCount                   PROCEDURE(),LONG,VIRTUAL
PageHeight                  PROCEDURE(),REAL,VIRTUAL
PageRotation                PROCEDURE(),LONG,VIRTUAL
PageWidth                   PROCEDURE(),REAL,VIRTUAL
RemoveDocument              PROCEDURE(LONG DocumentID),LONG,VIRTUAL,PROC
RotatePage                  PROCEDURE(LONG PageRotation),LONG,VIRTUAL,PROC
SaveToFile                  PROCEDURE(STRING FileName),LONG,VIRTUAL,PROC
SecurityInfo                PROCEDURE(LONG SecurityItem),LONG,VIRTUAL,PROC
SelectDocument              PROCEDURE(LONG DocumentID),LONG,VIRTUAL,PROC
SelectedDocument            PROCEDURE(),LONG,VIRTUAL,PROC
SelectFont                  PROCEDURE(LONG FontID),LONG,VIRTUAL,PROC
SelectImage                 PROCEDURE(LONG ImageID),LONG,VIRTUAL,PROC
SelectPage                  PROCEDURE(LONG PageNumber),LONG,VIRTUAL,PROC
SetBaseURL                  PROCEDURE(STRING NewBaseURL),LONG,VIRTUAL,PROC
SetInformation              PROCEDURE(LONG Key, STRING NewValue),LONG,VIRTUAL,PROC
SetMeasurementUnits         PROCEDURE(LONG MeasurementUnits),LONG,VIRTUAL,PROC
SetOrigin                   PROCEDURE(LONG Origin),LONG,VIRTUAL,PROC
SetPageBox                  PROCEDURE(LONG BoxType, REAL Left,REAL Top, REAL Width, REAL Height),LONG,VIRTUAL,PROC
SetPageDimensions           PROCEDURE(REAL NewPageWidth, REAL NewPageHeight),LONG,VIRTUAL,PROC
SetPageSize                 PROCEDURE(STRING PaperName),LONG,VIRTUAL,PROC
SetTextAlign                PROCEDURE(LONG TextAlign),LONG,VIRTUAL,PROC
SetTextColor                PROCEDURE(REAL Red,REAL Green,REAL Blue),LONG,VIRTUAL,PROC
SetTextSize                 PROCEDURE(REAL TextSize),LONG,VIRTUAL,PROC
SetTextUnderline            PROCEDURE(LONG Underline),LONG,VIRTUAL,PROC
                  END
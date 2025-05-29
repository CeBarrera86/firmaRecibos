

   MEMBER('QPLLiteDemoC10.clw')                            ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('QPLLITEDEMOC10008.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
DrawText PROCEDURE 

RegKey               CSTRING('j54n78w65pg5f799n6wc4o36y<0>{38}') !
PDFFileName          CSTRING('PdfControl.pdf<0>{113}')     !
NewValue             CSTRING(256)                          !
TotalFields          LONG                                  !
sTopic               CSTRING(20)                           !
NullString           CSTRING(2)                            !
OutputFormat         STRING('BMP')                         !
OutPDFFileName       CSTRING(128)                          !
ImageFileName        CSTRING('MultiPage.tif<0>{114}')      !
TotalPages           LONG(72)                              !
KS_Op                CSTRING('open')                       !
KS_param             CSTRING(2)                            !
KS_path              CSTRING(128)                          !
InstanceID           LONG                                  !
QPL             QuickPDFLite
window               WINDOW('Draw Text'),AT(,,123,36),FONT('MS Sans Serif',8),DOUBLE,CENTER,GRAY,MDI,MODAL,SYSTEM
                       OLE,AT(5,1,11,8),USE(?Ole1),HIDE
                       END
                       BUTTON('Create'),AT(9,9,45,14),USE(?Create),FONT('MS Sans Serif',8)
                       BUTTON('Close'),AT(71,9,45,14),USE(?Close),FONT('MS Sans Serif',8)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('DrawText')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?Create
  SELF.VCRRequest &= VCRRequest
  SELF.Errors &= GlobalErrors                              ! Set this windows ErrorManager to the global ErrorManager
  CLEAR(GlobalRequest)                                     ! Clear GlobalRequest after storing locally
  CLEAR(GlobalResponse)
  SELF.AddItem(Toolbar)
  IF SELF.Request = SelectRecord
     SELF.AddItem(?Close,RequestCancelled)                 ! Add the close control to the window manger
  ELSE
     SELF.AddItem(?Close,RequestCompleted)                 ! Add the close control to the window manger
  END
  SELF.Open(window)                                        ! Open window
  QPL.Init(Window,?OLE1)
  Do DefineListboxStyle
  INIMgr.Fetch('DrawText',window)                          ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('DrawText',window)                       ! Save window data to non-volatile store
  END
  GlobalErrors.SetProcedureName
  RETURN ReturnValue


ThisWindow.TakeAccepted PROCEDURE

ReturnValue          BYTE,AUTO

Looped BYTE
  CODE
  LOOP                                                     ! This method receive all EVENT:Accepted's
    IF Looped
      RETURN Level:Notify
    ELSE
      Looped = 1
    END
    CASE ACCEPTED()
    OF ?Close
       POST(EVENT:CloseWindow)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?Create
      ThisWindow.Update()
      ! Set the origin for the co-ordinates to be the
      ! top left corner of the page. (optional)
      
      QPL.SetOrigin(1)
      
      ! Draw text on the blank document that's already in memory
      QPL.DrawText(100, 200, 'Hello world from Clarion')
      
      ! Draw text in a text box. Specify width and height
      ! of the text box.
      
      QPL.DrawTextBox(350, 150, 200, 200, 'This text was drawn using the DrawTextBox function. Similar to the DrawText function except that the alignment can be specified and line wrapping occurs.', 1)
      
      QPL.SetTextColor(0.9, 0.2, 0.5)
      QPL.SetTextSize(30)
      
      QPL.DrawText(100, 100, 'Big and Colorful.')
      
      ! Save the document with the text you!ve just written to disk
      If QPL.SaveToFile('drawtext.pdf') = 1 Then
        Message('File drawtext.pdf written successfully')
        QPL.OpenInAdobe('drawtext.pdf')
      Else
       Message('Error, file could not be written')
      End
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


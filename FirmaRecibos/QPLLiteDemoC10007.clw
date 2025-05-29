

   MEMBER('QPLLiteDemoC10.clw')                            ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('QPLLITEDEMOC10007.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
AddLinkToWeb PROCEDURE 

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
window               WINDOW('Add Link to Web'),AT(,,123,36),FONT('MS Sans Serif',8),DOUBLE,CENTER,GRAY,MDI,MODAL, |
  SYSTEM
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
  GlobalErrors.SetProcedureName('AddLinkToWeb')
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
  INIMgr.Fetch('AddLinkToWeb',window)                      ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('AddLinkToWeb',window)                   ! Save window data to non-volatile store
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
      ! When the DQPL object is initiated a blank document
      ! is created and selected in memory by default.
      
      ! Set the origin for the co-ordinates to be the
      ! top left corner of the page.
      
      QPL.SetOrigin(1)
      
      ! Adding a link to the web is easy
      ! with the AddLinkToWeb function
      
      QPL.AddLinkToWeb(200, 100, 60, 20, 'http://www.klarisoft.com/KSNews_160.htm', 1)
      
      ! Hyperlinks and text are two separate
      ! elements in a PDF, so we'll draw some
      ! text now so that you know where the
      ! hyperlink is located on the page.
      
      QPL.DrawText(205, 114, 'Click me!')
      
      ! Save the document with the text you!ve just written to disk
      If QPL.SaveToFile('web-link.pdf') = 1 Then
        Message('File web-link.pdf written successfully')
        QPL.OpenInAdobe('web-link.pdf')
      Else
       Message('Error, file could not be written')
      End
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


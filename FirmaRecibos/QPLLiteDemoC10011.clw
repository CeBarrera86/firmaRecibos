

   MEMBER('QPLLiteDemoC10.clw')                            ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('QPLLITEDEMOC10011.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
TextAndFont PROCEDURE 

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
fontID1              LONG                                  !
fontID2              LONG                                  !
fontID3              LONG                                  !
fontID4              LONG                                  !
fontID5              LONG                                  !
QPL             QuickPDFLite
window               WINDOW('Different Fonts'),AT(,,123,36),FONT('MS Sans Serif',8),DOUBLE,CENTER,GRAY,MDI,MODAL, |
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
  GlobalErrors.SetProcedureName('TextAndFont')
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
  INIMgr.Fetch('TextAndFont',window)                       ! Restore window settings from non-volatile store
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('TextAndFont',window)                    ! Save window data to non-volatile store
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
      !  Use the AddStandardFont function to add a font to
      !  the default blank document and get the return
      !  value which is the font ID.
      
      fontID1 = QPL.AddStandardFont(0)
      
      !  Select the font using its font ID
      
      QPL.SelectFont(fontID1)
      
      !  Draw some text onto the document to see if
      !  everything is working OK.
      
      QPL.DrawText(100, 700, 'Courier')
      
      !  Repeat exercise to see what a couple of other
      !  fonts will look like as well.
      
      fontID2 = QPL.AddStandardFont(1)
      QPL.SelectFont(fontID2)
      QPL.DrawText(100, 650, 'CourierBold')
      
      fontID3 = QPL.AddStandardFont(2)
      QPL.SelectFont(fontID3)
      QPL.DrawText(100, 600, 'CourierBoldOblique')
      
      fontID4 = QPL.AddStandardFont(3)
      QPL.SelectFont(fontID4)
      QPL.DrawText(100, 550, 'Helvetica')
      
      fontID5 = QPL.AddStandardFont(4)
      QPL.SelectFont(fontID5)
      QPL.DrawText(100, 500, 'HelveticaBold')
      
      ! Save the document with the text you!ve just written to disk
      If QPL.SaveToFile('different-fonts.pdf') = 1 Then
        Message('File different-fonts.pdf written successfully')
        QPL.OpenInAdobe('different-fonts.pdf')
      Else
       Message('Error, file could not be written')
      End
      
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue

!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
MergePDFs PROCEDURE 

RegKey               CSTRING('j54n78w65pg5f799n6wc4o36y<0>{38}') !
PDFFileName          CSTRING('PdfControl.pdf<0>{113}')     !
PDFFileName2         CSTRING('PdfControl.pdf<0>{113}')     !
NewValue             CSTRING(256)                          !
TotalFields          LONG                                  !
sTopic               CSTRING(20)                           !
NullString           CSTRING(2)                            !
OutputFormat         STRING('BMP')                         !
OutPDFFileName       CSTRING('combined.pdf<0>{115}')       !
ImageFileName        CSTRING('MultiPage.tif<0>{114}')      !
TotalPages           LONG(72)                              !
KS_Op                CSTRING('open')                       !
KS_param             CSTRING(2)                            !
KS_path              CSTRING(128)                          !
InstanceID           LONG                                  !
PrimaryDoc           LONG                                  !
SecondaryDoc         LONG                                  !
fontID3              LONG                                  !
fontID4              LONG                                  !
fontID5              LONG                                  !
PrimaryDocName       CSTRING(200)                          !
SecondaryDocName     CSTRING(200)                          !
QPL             QuickPDFLite

CertificatesQ           Queue,Pre(CertQ)
CertificateName             CSTRING(600)                    !                    
                        End!Queue
window               WINDOW('Merge Files'),AT(,,215,102),FONT('MS Sans Serif',8),DOUBLE,CENTER,GRAY,MDI,MODAL,SYSTEM
                       OLE,AT(5,1,11,8),USE(?Ole1),HIDE
                       END
                       BUTTON('Create'),AT(99,80,45,14),USE(?Create),FONT('MS Sans Serif',8)
                       BUTTON('Close'),AT(160,80,45,14),USE(?Close),FONT('MS Sans Serif',8)
                       PROMPT('PDF 1'),AT(3,15),USE(?PDFFileName:Prompt)
                       ENTRY(@s127),AT(37,15,139,10),USE(PDFFileName)
                       PROMPT('PDF 2'),AT(3,28),USE(?PDFFileName2:Prompt)
                       ENTRY(@s127),AT(37,30,139,10),USE(PDFFileName2)
                       ENTRY(@s127),AT(37,45),USE(OutPDFFileName)
                       PROMPT('Combined'),AT(3,44),USE(?PDFFileName2:Prompt:2)
                       BUTTON('...'),AT(179,16,12,12),USE(?LookupFile)
                       BUTTON('...'),AT(179,30,12,12),USE(?LookupFile:2)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
FileLookup2          SelectFileClass
FileLookup3          SelectFileClass

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
  GlobalErrors.SetProcedureName('MergePDFs')
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
  INIMgr.Fetch('MergePDFs',window)                         ! Restore window settings from non-volatile store
  FileLookup2.Init
  FileLookup2.ClearOnCancel = True
  FileLookup2.Flags=BOR(FileLookup2.Flags,FILE:LongName)   ! Allow long filenames
  FileLookup2.SetMask('PDFl Files','*.pdf')                ! Set the file mask
  FileLookup2.WindowTitle='Select PDF'
  FileLookup3.Init
  FileLookup3.ClearOnCancel = True
  FileLookup3.Flags=BOR(FileLookup3.Flags,FILE:LongName)   ! Allow long filenames
  FileLookup3.SetMask('PDF Files','*.pdf')                 ! Set the file mask
  FileLookup3.WindowTitle='Select PDF2'
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.Opened
    INIMgr.Update('MergePDFs',window)                      ! Save window data to non-volatile store
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
            Clear(CertificatesQ)  
            Free(CertificatesQ) 
            remove(OutPDFFileName)
            Loop Idx# = 1 to 4
              Case Idx#
              Of 1
                      CertQ:CertificateName = 'drawtext.pdf'
              Of 2
                      CertQ:CertificateName = 'label1.pdf'
              Of 3
                      CertQ:CertificateName = 'label2.pdf'
              Of 4
                      CertQ:CertificateName = 'label3.pdf'
              End!Case
              Add(CertificatesQ,CertQ:CertificateName)
            End!Loop
      
            Get(CertificatesQ,1) !get the first file from your queue
            PrimaryDocName = CertQ:CertificateName
            Loop Idx2# = 1 To Records(CertificatesQ)-1
               QPL.LoadFromFile(PrimaryDocName, '');
               PrimaryDoc = QPL.SelectedDocument(); 
               !stop(PrimaryDoc)
                !get the secondary file
               Get(CertificatesQ,IDX2#+1)
               SecondaryDocName = CertQ:CertificateName
               ! Load the second document .
               QPL.LoadFromFile(SecondaryDocName, '');
               SecondaryDoc = QPL.SelectedDocument();
               ! Select the first document
               QPL.SelectDocument(PrimaryDoc);
               ! Merge the second document with the previously selected document.
               QPL.MergeDocument(SecondaryDoc);
               ! Save the merged document to disk
               QPL.SaveToFile('merged_docs' & Idx2# & '.pdf');
               PrimaryDocName = 'merged_docs' & Idx2# & '.pdf'
            End
            copy(PrimaryDocName,OutPDFFileName)
            QPL.OpenInAdobe(OutPDFFileName)     
            
    OF ?LookupFile
      ThisWindow.Update()
      PDFFileName = FileLookup2.Ask(1)
      DISPLAY
    OF ?LookupFile:2
      ThisWindow.Update()
      PDFFileName2 = FileLookup3.Ask(1)
      DISPLAY
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


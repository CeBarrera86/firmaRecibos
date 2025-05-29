

   MEMBER('QPLLiteDemoC10.clw')                            ! This is a MEMBER module


   INCLUDE('ABTOOLBA.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ABWINDOW.INC'),ONCE

                     MAP
                       INCLUDE('QPLLITEDEMOC10009.INC'),ONCE        !Local module procedure declarations
                     END


!!! <summary>
!!! Generated from procedure template - Window
!!! </summary>
FirmaRecibos PROCEDURE 

RegKey               CSTRING('j54n78w65pg5f799n6wc4o36y<0>{38}') !
Loc:Path1            CSTRING(201)                          !
Loc:Path2            CSTRING(201)                          !
Loc:errorControl     BYTE                                  !
Loc:namePDF          CSTRING(101)                          !
Loc:indice           SHORT                                 !
Loc:nroleg           SHORT                                 !
Loc:nroliq           LONG                                  !
Loc:tr               CSTRING(3)                            !
Loc:ta               CSTRING(3)                            !
queueRecibo         QUEUE(File:queue),PRE(FIL) !Inherit exact declaration of File:queue
                END
Recibo              LONG
Recibos             LONG
QPL                 QuickPDFLite
window               WINDOW('Firma Recibo Sueldos'),AT(,,315,60),FONT('Microsoft Sans Serif',10),DOUBLE,CENTER, |
  GRAY,MDI,MODAL,SYSTEM
                       BUTTON('&Origen'),AT(5,5,55,14),USE(?LookupFile),FONT(,12,,FONT:bold),LEFT,ICON(ICON:Open)
                       ENTRY(@s200),AT(65,6,245,13),USE(Loc:Path1),FONT(,10,,FONT:regular)
                       BUTTON('&Destino'),AT(5,23,55,14),USE(?LookupFile:2),FONT(,12,,FONT:bold),LEFT,ICON(ICON:Save)
                       ENTRY(@s200),AT(65,24,245,13),USE(Loc:Path2)
                       OLE,AT(5,41,14,14),USE(?Ole1),HIDE
                       END
                       PROMPT('Progreso:'),AT(64,41,45,14),USE(?ProgressBar:Prompt),FONT(,14,,FONT:bold)
                       PROGRESS,AT(112,41,80,14),USE(?ProgressBar),RANGE(0,100)
                       BUTTON('&Firmar'),AT(218,41,45,14),USE(?Create),FONT('Microsoft Sans Serif',10,COLOR:Green, |
  FONT:bold)
                       BUTTON('&Cerrar'),AT(266,41,45,14),USE(?Close),FONT('Microsoft Sans Serif',10,COLOR:Red,FONT:bold)
                     END

ThisWindow           CLASS(WindowManager)
Init                   PROCEDURE(),BYTE,PROC,DERIVED
Kill                   PROCEDURE(),BYTE,PROC,DERIVED
TakeAccepted           PROCEDURE(),BYTE,PROC,DERIVED
                     END

Toolbar              ToolbarClass
FileLookup1          SelectFileClass
FileLookup2          SelectFileClass

  CODE
  GlobalResponse = ThisWindow.Run()                        ! Opens the window and starts an Accept Loop

!---------------------------------------------------------------------------
DefineListboxStyle ROUTINE
!|
!| This routine create all the styles to be shared in this window
!| It`s called after the window open
!|
!---------------------------------------------------------------------------
ControlRestricciones        ROUTINE
    num1# = INSTRING('\', Loc:Path1, -1, LEN(Loc:Path1))
    num2# = INSTRING('\', Loc:Path2, -1, LEN(Loc:Path2))
    p1" = Loc:Path1[num1# + 1:LEN(Loc:Path1)]
    p2" = Loc:Path2[num2# + 1:LEN(Loc:Path2)]
    IF Loc:Path1 = '' OR Loc:Path2 = '' THEN !Control de directorios vacíos
        BEEP
        MESSAGE('Debe seleccionar los directorios de Origen y Destino!', 'Directorios', ICON:Exclamation, BUTTON:OK, 1)
        IF Loc:Path1 = '' THEN
            SELECT(?Loc:Path1)
        ELSE
            SELECT(?Loc:Path2)
        END
        Loc:errorControl = 1
    ELSIF Loc:Path1 = Loc:Path2 THEN !Control de directorios iguales
        BEEP
        MESSAGE('Los directorios de Origen y Destino, no pueden ser los mismos!', 'Directorios', ICON:Exclamation, BUTTON:OK, 1)
        Loc:errorControl = 1
    ELSIF p1" <> p2" THEN !Control de carpetas distintas
        BEEP
        MESSAGE('Las carpetas tiene distintos nombres! - Origen: ' & CLIP(p1") & ' <> Destino: ' & CLIP(p2"), 'Directorios', ICON:Exclamation, BUTTON:OK, 1)
        Loc:errorControl = 1
    END
PARAMETROS          ROUTINE
    ! Guardo el nombre del PDF
    Loc:namePDF = CLIP(queueRecibo.Name)
    ! Obtengo algunos valores del nombre del PDF
    Loc:indice = INSTRING('_', Loc:namePDF, -1, LEN(Loc:namePDF))
    Loc:nroleg = Loc:namePDF[Loc:indice + 1 : Loc:indice + 4] ! Obtengo el número de legajo
    Loc:nroliq = Loc:namePDF[1 : Loc:indice - 1] ! Obtengo el número de liquidación
    Loc:tr = Loc:namePDF[1] ! Tipo Recibo
    Loc:ta = Loc:namePDF[2] ! Tipo Anticipo
FirmaFileppo        ROUTINE
    ! Abro imagen de firma PNG
    QPL.AddImageFromFile('\\Adm_pico\docu.net\PERSONAL\FIRMA\firmaAle.png', 0)
    ! Redimensiono la firma
    lWidth# = QPL.ImageWidth() * 0.1
    lHeight# = QPL.ImageHeight() * 0.1
    ! Dibujo la firma en el recibo
    QPL.DrawImage(90, 120, lWidth#, lHeight#)
FirmaPaez           ROUTINE
    ! Abro imagen de firma PNG
    QPL.AddImageFromFile('\\Adm_pico\docu.net\PERSONAL\FIRMA\firmaLeo.png', 0)
    ! Redimensiono la firma
    lWidth# = QPL.ImageWidth() * 0.14
    lHeight# = QPL.ImageHeight() * 0.14
    ! Dibujo la firma en el recibo
    QPL.DrawImage(90, 120, lWidth#, lHeight#)
tipoAnticipo        ROUTINE
    CASE Loc:ta
        OF '1'
            QPL.DrawText(10, 100, 'Distribución de Facturas')
        OF '2'
            QPL.DrawText(10, 100, 'Plus Vacacional')
        OF '3'
            QPL.DrawText(10, 100, 'Adelanto de Sueldo')
        OF '4'
            QPL.DrawText(10, 100, 'Ajuste Liquidación')
        OF '5'
            QPL.DrawText(10, 100, 'Suma Sindical')
        OF '6'
            QPL.DrawText(10, 100, 'Suma No Remunerativa')
        OF '7'
            QPL.DrawText(10, 100, 'Anticipo S.A.C.')
        ELSE
            QPL.DrawText(10, 100, 'Anticipo al Personal')
    END
creaFirma           ROUTINE
    LOOP hoja# = 1 TO QPL.PageCount()
        QPL.SelectPage(hoja#)
        QPL.SetPageSize('A4')
        IF Loc:tr = '3' AND Loc:nroleg = '9191' THEN
            DO FirmaFileppo
        ELSE
            DO FirmaPaez
        END
        ! Se verifica si se trata de una liquidación (4) o un anticipo (6)
        IF Loc:tr = '4' THEN
            ! Establezco los parametros de la fuente
            QPL.SetTextColor(1.0, 0.0, 0.0)
            QPL.SetTextSize(10)
            ! Dibujo el texto
            QPL.DrawText(10, 100, 'Liquidación Final')
        ELSIF Loc:tr = '6' THEN
            ! Establezco los parametros de la fuente
            QPL.SetTextColor(0.0, 0.0, 1.0)
            QPL.SetTextSize(10)
            ! Dibujo el texto
            DO tipoAnticipo
        END
        ! Guardo el recibo firmado
        QPL.SaveToFile(Loc:Path2 & '\' & Loc:namePDF)
    END !Loop 2
preparaRecibo       ROUTINE
    LOOP Recibo = 1 TO Recibos
        GET(queueRecibo, Recibo)
        DO PARAMETROS
        ! Genero liquidación y legajo en la tabla LIQUIDALEG
        CLEAR(LIQ:Record)
        LIQ:LIQ_LEGAJO = Loc:nroleg
        LIQ:LIQ_NROLIQ = Loc:nroliq
        GET(LIQUIDALEG, LIQ:PK_LIQUIDALEG)
        IF ERRORCODE() THEN !NO Existe liquidación en tabla, la agrego
            Access:LIQUIDALEG.Insert()
        END
        QPL.LoadFromFile(Loc:Path1 & '\' & Loc:namePDF, '') ! Cargo el recibo
        QPL.SetMeasurementUnits(1) ! Setea unidades a mm
        DO creaFirma
        ?ProgressBar{PROP:progress} = ?ProgressBar{PROP:progress} + 1
        DISPLAY(?ProgressBar)
    END !Loop 1

ThisWindow.Init PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  GlobalErrors.SetProcedureName('FirmaRecibos')
  SELF.Request = GlobalRequest                             ! Store the incoming request
  ReturnValue = PARENT.Init()
  IF ReturnValue THEN RETURN ReturnValue.
  SELF.FirstField = ?LookupFile
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
  Relate:LIQUIDALEG.Open                                   ! File LIQUIDALEG used by this procedure, so make sure it's RelationManager is open
  SELF.FilesOpened = True
  SELF.Open(window)                                        ! Open window
  QPL.Init(Window,?OLE1)
  Do DefineListboxStyle
  INIMgr.Fetch('FirmaRecibos',window)                      ! Restore window settings from non-volatile store
  FileLookup1.Init
  FileLookup1.ClearOnCancel = True
  FileLookup1.Flags=BOR(FileLookup1.Flags,FILE:LongName)   ! Allow long filenames
  FileLookup1.Flags=BOR(FileLookup1.Flags,FILE:Directory)  ! Allow Directory Dialog
  FileLookup1.SetMask('PDFl Files','*.pdf')                ! Set the file mask
  FileLookup1.DefaultDirectory='\\Adm_pico\docu.net\PERSONAL\Recibos_Digitales'
  FileLookup1.WindowTitle='Selecionar Origen'
  FileLookup2.Init
  FileLookup2.ClearOnCancel = True
  FileLookup2.Flags=BOR(FileLookup2.Flags,FILE:LongName)   ! Allow long filenames
  FileLookup2.Flags=BOR(FileLookup2.Flags,FILE:Directory)  ! Allow Directory Dialog
  FileLookup2.SetMask('PDFI Files','*.pdf')                ! Set the file mask
  FileLookup2.DefaultDirectory='\\Adm_pico\docu.net\PERSONAL\Recibos_Firmados'
  FileLookup2.WindowTitle='Selecionar Destino'
  SELF.SetAlerts()
  RETURN ReturnValue


ThisWindow.Kill PROCEDURE

ReturnValue          BYTE,AUTO

  CODE
  ReturnValue = PARENT.Kill()
  IF ReturnValue THEN RETURN ReturnValue.
  IF SELF.FilesOpened
    Relate:LIQUIDALEG.Close
  END
  IF SELF.Opened
    INIMgr.Update('FirmaRecibos',window)                   ! Save window data to non-volatile store
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
    OF ?Create
      !Control de Directorios
      DO ControlRestricciones
      IF Loc:errorControl THEN
          Loc:errorControl = 0
          CYCLE
      END
    OF ?Close
       POST(EVENT:CloseWindow)
    END
  ReturnValue = PARENT.TakeAccepted()
    CASE ACCEPTED()
    OF ?LookupFile
      ThisWindow.Update()
      Loc:Path1 = FileLookup1.Ask(1)
      DISPLAY
    OF ?LookupFile:2
      ThisWindow.Update()
      Loc:Path2 = FileLookup2.Ask(1)
      DISPLAY
    OF ?Create
      ThisWindow.Update()
      ! Códigos de prueba utilizados
      
      !!CODIGO ORIGINAL
      
      !! Load the image that you'd like to convert to PDF
      !QPL.AddImageFromFile('image.png', 0)
      !
      !! Get the width and height of the image
      !lWidth# = QPL.ImageWidth()
      !lHeight# = QPL.ImageHeight()
      !
      !! Reformat the size of the page in the selected document
      !QPL.SetPageDimensions(lWidth#, lHeight#)
      !
      !! Draw the image onto the page using the specified width/height
      !QPL.DrawImage(0, lHeight#, lWidth#, lHeight#)
      !! Save the document with the text you!ve just written to disk
      !If QPL.SaveToFile('image.pdf') = 1 Then
      !  Message('File image.pdf written successfully')
      !  QPL.OpenInAdobe('image.pdf')
      !Else
      ! Message('Error, file could not be written')
      !End
      
      !!FUNCIÓN PARA RECIBOS DE DOS O MAS HOJAS
      !
      !! Cargo el recibo
      !QPL.LoadFromFile('C:\Clarion10\Examples\QuickPDFLibraryLiteDemoC10\recibo2.pdf', '')
      !QPL.SetMeasurementUnits(1)
      !LOOP hoja# = 1 TO QPL.PageCount()
      !    QPL.SelectPage(hoja#)
      !!    QPL.SetPageDimensions(210,297)
      !    QPL.SetPageSize('A4')
      !    ! Abro imagen de firma PNG
      !    QPL.AddImageFromFile('C:\Clarion10\Examples\QuickPDFLibraryLiteDemoC10\firmaLeo.png', 0)
      !    ! Redimensiono la firma
      !!    lWidth# = QPL.ImageWidth() * 0.4
      !!    lHeight# = QPL.ImageHeight() * 0.4
      !    lWidth# = QPL.ImageWidth() * 0.14
      !    lHeight# = QPL.ImageHeight() * 0.14
      !    ! Dibujo la firma en el recibo
      !!    QPL.DrawImage(280, 340, lWidth#, lHeight#)
      !    QPL.DrawImage(90, 120, lWidth#, lHeight#)
      !    ! Guardo el recibo firmado
      !    QPL.SaveToFile('C:\Clarion10\Examples\QuickPDFLibraryLiteDemoC10\reciboFirmado.pdf')
      !END !Loop
      !MESSAGE(ERRORCODE())
      !! Abro el recibo firmado
      !QPL.OpenInAdobe('C:\Clarion10\Examples\QuickPDFLibraryLiteDemo\reciboFirmado.pdf')
      
      
      !!FUNCIÓN PARA TRABAJAR CON DIRECTORIOS
      !
      !CLEAR(queueRecibo)
      !FREE(queueRecibo)
      !DIRECTORY(queueRecibo, Loc:Path1 & '\*.pdf',ff_:DIRECTORY) !Get all files and directories
      !Recibos = RECORDS(queueRecibo)
      !?ProgressBar{PROP:RangeHigh} = Recibos
      !LOOP Recibo = 1 TO Recibos
      !    GET(queueRecibo, Recibo)
      !    ! Guardo el nombre del PDF
      !    namePDF" = CLIP(queueRecibo.Name)
      !    ! Obtengo algunos valores del nombre del PDF
      !    num# = INSTRING('_', namePDF", -1, LEN(namePDF"))
      !    nroleg" = namePDF"[num# + 1:num# + 4] ! Obtengo el número de legajo
      !    nroliq" = namePDF"[1 : num# - 1] ! Obtengo el número de liquidación
      !    tr" = namePDF"[1] ! Tipo Recibo
      !    ta" = namePDF"[2] ! Tipo Anticipo
      !    ! Genero liquidación y legajo en la tabla LIQUIDALEG
      !    CLEAR(LIQ:Record)
      !    LIQ:LIQ_LEGAJO = nroleg"
      !    LIQ:LIQ_NROLIQ = nroliq"
      !    GET(LIQUIDALEG, LIQ:PK_LIQUIDALEG)
      !    IF ERRORCODE() THEN !NO Existe liquidación en tabla, la agrego
      !        Access:LIQUIDALEG.Insert()
      !    END
      !    ! Cargo el recibo
      !    QPL.LoadFromFile(Loc:Path1 & '\' & namePDF", '')
      !!    QPL.LoadFromFile('C:\Clarion10\Examples\QuickPDFLibraryLiteDemo\recibo2.pdf', '')
      !!    QPL.LoadFromFile('C:\Users\sistemas\Desktop\3082021_1178.pdf','')
      !    MESSAGE(QPL.SelectedDocument())
      !    ! Setea unidades a mm
      !    QPL.SetMeasurementUnits(1)
      !    LOOP hoja# = 1 TO QPL.PageCount()
      !        MESSAGE('Loop 2')
      !        QPL.SelectPage(hoja#)
      !        QPL.SetPageSize('A4')
      !        IF tr" = '3' AND nroleg" = '9191' THEN
      !            ! Abro imagen de firma PNG
      !            QPL.AddImageFromFile('\\Adm_pico\docu.net\PERSONAL\FIRMA\firmaAle.png', 0)
      !            ! Redimensiono la firma
      !            lWidth# = QPL.ImageWidth() * 0.1
      !            lHeight# = QPL.ImageHeight() * 0.1
      !            ! Dibujo la firma en el recibo
      !            QPL.DrawImage(90, 120, lWidth#, lHeight#)
      !            MESSAGE('Firma Fileppo')
      !        ELSE
      !            ! Abro imagen de firma PNG
      !            QPL.AddImageFromFile('\\Adm_pico\docu.net\PERSONAL\FIRMA\firmaLeo.png', 0)
      !            ! Redimensiono la firma
      !            lWidth# = QPL.ImageWidth() * 0.14
      !            lHeight# = QPL.ImageHeight() * 0.14
      !            ! Dibujo la firma en el recibo
      !            QPL.DrawImage(90, 120, lWidth#, lHeight#)
      !            MESSAGE('Firma Paez')
      !        END
      !        ! Se verifica si se trata de una liquidación o un anticipo
      !        IF tr" = '4' THEN
      !            ! Establezco los parametros de la fuente
      !            QPL.SetTextColor(1.0, 0.0, 0.0)
      !            QPL.SetTextSize(10)
      !            ! Dibujo el texto
      !            QPL.DrawText(10, 100, 'Liquidación Final')
      !        ELSIF tr" = '6' THEN
      !            ! Establezco los parametros de la fuente
      !            QPL.SetTextColor(0.0, 0.0, 1.0)
      !            QPL.SetTextSize(10)
      !            ! Dibujo el texto
      !            CASE ta"
      !                OF '1'
      !                    QPL.DrawText(10, 100, 'Distribución de Facturas')
      !                OF '2'
      !                    QPL.DrawText(10, 100, 'Plus Vacacional')
      !                OF '3'
      !                    QPL.DrawText(10, 100, 'Adelanto de Sueldo')
      !                OF '4'
      !                    QPL.DrawText(10, 100, 'Ajuste Liquidación')
      !                OF '5'
      !                    QPL.DrawText(10, 100, 'Suma Sindical')
      !                ELSE
      !                    QPL.DrawText(10, 100, 'Anticipo al Personal')
      !            END
      !        END
      !        ! Guardo el recibo firmado
      !        QPL.SaveToFile(Loc:Path2 & '\' & namePDF")
      !!        QPL.SaveToFile('C:\Clarion10\Examples\QuickPDFLibraryLiteDemo\reciboFirmado.pdf')
      !    END !Loop 2
      !    ?ProgressBar{PROP:progress} = ?ProgressBar{PROP:progress} + 1
      !    DISPLAY(?ProgressBar)
      !END !Loop 1
      !IF NOT QPL.LastErrorCode() THEN
      !    MESSAGE('La firma de recibos de sueldo ha finalizado con éxito!', 'Firmas', ICON:Exclamation, BUTTON:OK, 1)
      !    ?ProgressBar{PROP:progress} = 0
      !    DISPLAY(?ProgressBar)
      !END
      CLEAR(queueRecibo)
      FREE(queueRecibo)
      DIRECTORY(queueRecibo, Loc:Path1 & '\*.pdf',ff_:DIRECTORY) ! FUNCIÓN PARA TRABAJAR CON DIRECTORIOS
      Recibos = RECORDS(queueRecibo)
      ?ProgressBar{PROP:RangeHigh} = Recibos
      DO preparaRecibo
      IF NOT QPL.LastErrorCode() THEN
          MESSAGE('La firma de recibos de sueldo ha finalizado con éxito!', 'Firmas', ICON:Exclamation, BUTTON:OK, 1)
          ?ProgressBar{PROP:progress} = 0
          DISPLAY(?ProgressBar)
      END
    END
    RETURN ReturnValue
  END
  ReturnValue = Level:Fatal
  RETURN ReturnValue


   PROGRAM


     include('QuickPDFLite.inc'),once

   INCLUDE('ABERROR.INC'),ONCE
   INCLUDE('ABFILE.INC'),ONCE
   INCLUDE('ABUTIL.INC'),ONCE
   INCLUDE('ERRORS.CLW'),ONCE
   INCLUDE('KEYCODES.CLW'),ONCE
   INCLUDE('ABFUZZY.INC'),ONCE

   MAP
     MODULE('QPLLITEDEMOC10_BC.CLW')
DctInit     PROCEDURE                                      ! Initializes the dictionary definition module
DctKill     PROCEDURE                                      ! Kills the dictionary definition module
     END
!--- Application Global and Exported Procedure Definitions --------------------------------------------
     MODULE('QPLLITEDEMOC10001.CLW')
Main                   PROCEDURE   !
     END
        MODULE('API')
          _hwrite(LONG,LONG,long),long,PASCAL,RAW
          _lcreat(*CSTRING,SIGNED),LONG,PASCAL,RAW
          _lclose(LONG),LONG,PASCAL
          _lopen(*CSTRING,SIGNED),LONG,PASCAL,RAW
          _lwrite(LONG,*GROUP,UNSIGNED),UNSIGNED,PASCAL,RAW
          _llseek(LONG, LONG, SIGNED),LONG,PASCAL
          ShellExecute(Long,*CSTRING,*CSTRING,*CSTRING,*CSTRING,Long),Long, |
          PASCAL,RAW,NAME('ShellExecuteA')
        END
   END

GLO:GEA_PICO_PERSONAL_CNX CSTRING('GEA_PICO,Personal,sa,bmast24<0>{22}')
SilentRunning        BYTE(0)                               ! Set true when application is running in 'silent mode'

!region File Declaration
LIQUIDALEG           FILE,DRIVER('MSSQL','/LOGONSCREEN=False /TRUSTEDCONNECTION=True'),OWNER(GLO:GEA_PICO_PERSONAL_CNX),NAME('dbo.LIQUIDALEG'),PRE(LIQ),BINDABLE,THREAD !                    
PK_LIQUIDALEG            KEY(LIQ:LIQ_LEGAJO,LIQ:LIQ_NROLIQ),PRIMARY !                    
Record                   RECORD,PRE()
LIQ_LEGAJO                  SHORT,NAME('"LIQ_LEGAJO"')     !                    
LIQ_NROLIQ                  LONG,NAME('"LIQ_NROLIQ"')      !                    
                         END
                     END                       

!endregion

Access:LIQUIDALEG    &FileManager,THREAD                   ! FileManager for LIQUIDALEG
Relate:LIQUIDALEG    &RelationManager,THREAD               ! RelationManager for LIQUIDALEG

FuzzyMatcher         FuzzyClass                            ! Global fuzzy matcher
GlobalErrorStatus    ErrorStatusClass,THREAD
GlobalErrors         ErrorClass                            ! Global error manager
INIMgr               INIClass                              ! Global non-volatile storage manager
GlobalRequest        BYTE(0),THREAD                        ! Set when a browse calls a form, to let it know action to perform
GlobalResponse       BYTE(0),THREAD                        ! Set to the response from the form
VCRRequest           LONG(0),THREAD                        ! Set to the request from the VCR buttons

Dictionary           CLASS,THREAD
Construct              PROCEDURE
Destruct               PROCEDURE
                     END


  CODE
  GlobalErrors.Init(GlobalErrorStatus)
  FuzzyMatcher.Init                                        ! Initilaize the browse 'fuzzy matcher'
  FuzzyMatcher.SetOption(MatchOption:NoCase, 1)            ! Configure case matching
  FuzzyMatcher.SetOption(MatchOption:WordOnly, 0)          ! Configure 'word only' matching
  INIMgr.Init('.\QPLLiteDemoC10.INI', NVD_INI)             ! Configure INIManager to use INI file
  DctInit
  Main
  INIMgr.Update
  INIMgr.Kill                                              ! Destroy INI manager
  FuzzyMatcher.Kill                                        ! Destroy fuzzy matcher


Dictionary.Construct PROCEDURE

  CODE
  IF THREAD()<>1
     DctInit()
  END


Dictionary.Destruct PROCEDURE

  CODE
  DctKill()


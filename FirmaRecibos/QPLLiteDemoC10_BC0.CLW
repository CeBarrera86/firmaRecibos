  MEMBER('QPLLiteDemoC10.clw')

  INCLUDE('ABFILE.INC'),ONCE

  MAP
QPLLiteDemoC10_BC0:DctInit    PROCEDURE
QPLLiteDemoC10_BC0:DctKill    PROCEDURE
QPLLiteDemoC10_BC0:FilesInit  PROCEDURE
  END

Hide:Access:LIQUIDALEG CLASS(FileManager),TYPE             ! FileManager for LIQUIDALEG
Init                   PROCEDURE(),DERIVED
Kill                   PROCEDURE(),DERIVED
UseFile                PROCEDURE(BYTE UseType = UseType:Uses),BYTE,PROC,DERIVED
                     END


Hide:Relate:LIQUIDALEG CLASS(RelationManager),TYPE         ! RelationManager for LIQUIDALEG
Init                   PROCEDURE
Kill                   PROCEDURE(),DERIVED
                     END


_Hide:Access:LIQUIDALEG &Hide:Access:LIQUIDALEG,AUTO,THREAD
_Hide:Relate:LIQUIDALEG &Hide:Relate:LIQUIDALEG,AUTO,THREAD


QPLLiteDemoC10_BC0:DctInit PROCEDURE
  CODE
  _Hide:Access:LIQUIDALEG &= NEW(Hide:Access:LIQUIDALEG)
  _Hide:Relate:LIQUIDALEG &= NEW(Hide:Relate:LIQUIDALEG)
  Relate:LIQUIDALEG &= _Hide:Relate:LIQUIDALEG


QPLLiteDemoC10_BC0:FilesInit PROCEDURE
  CODE
  _Hide:Relate:LIQUIDALEG.Init


QPLLiteDemoC10_BC0:DctKill PROCEDURE
  CODE
  _Hide:Relate:LIQUIDALEG.Kill
  DISPOSE(_Hide:Relate:LIQUIDALEG)


Hide:Relate:LIQUIDALEG.Init PROCEDURE
  CODE
  _Hide:Access:LIQUIDALEG.Init
  SELF.Init(Access:LIQUIDALEG,1)


Hide:Access:LIQUIDALEG.Init PROCEDURE

  CODE
  SELF.Initialized = False
  SELF.Buffer &= LIQ:Record
  SELF.FileNameValue = 'LIQUIDALEG'
  SELF.SetErrors(GlobalErrors)
  SELF.File &= LIQUIDALEG
  PARENT.Init
  Access:LIQUIDALEG &= SELF


Hide:Access:LIQUIDALEG.Kill PROCEDURE

  CODE
  PARENT.Kill
  Access:LIQUIDALEG &= NULL                                ! File manager has been destroyed to assign null, it is an error to reference this after this point


Hide:Access:LIQUIDALEG.UseFile PROCEDURE(BYTE UseType = UseType:Uses)

ReturnValue          BYTE,AUTO

  CODE
  IF UseType ~= UseType:Initialize
    SELF.UseFile(UseType:Initialize)                       !Recursive call to ensure initialization takes place
  END
  IF UseType = UseType:Initialize AND ~SELF.Initialized
    SELF.InUseFile = True
    SELF.Init(LIQUIDALEG,GlobalErrors)
    SELF.Create = 0
    SELF.LockRecover = 10
    SELF.AddKey(LIQ:PK_LIQUIDALEG,'LIQ:PK_LIQUIDALEG',0)
  END
                                                           !SELF.InUseFile will be set to False in PARENT
  ReturnValue = PARENT.UseFile(UseType)
  RETURN ReturnValue


Hide:Relate:LIQUIDALEG.Kill PROCEDURE

  CODE
  _Hide:Access:LIQUIDALEG.Kill                             ! Kill the file manager
  PARENT.Kill
  Relate:LIQUIDALEG &= NULL                                ! Assign NULL to the RelationManager's FileManager reference, it is an error to reference this after this point
  DISPOSE(_Hide:Access:LIQUIDALEG)                         ! destroy the file manager


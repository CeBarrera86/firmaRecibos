  MEMBER('QPLLiteDemoC10.clw')

  PRAGMA('define(init_priority=>3)')

  MAP
    MODULE('QPLLiteDemoC10_BC0.CLW')
QPLLiteDemoC10_BC0:DctInit             PROCEDURE
QPLLiteDemoC10_BC0:DctKill             PROCEDURE
QPLLiteDemoC10_BC0:FilesInit           PROCEDURE
    END
  END

DctInit PROCEDURE
  CODE
  QPLLiteDemoC10_BC0:DctInit
  QPLLiteDemoC10_BC0:FilesInit


DctKill PROCEDURE
  CODE
  QPLLiteDemoC10_BC0:DctKill


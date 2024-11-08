SET TCF_ROOT=D:\Command_Line\Run_multiple_TCF_on_command_line
for %%i in (%TCF_ROOT%\*.tcf) do (
C:\LDRA_Toolsuite_C_CPP_10.2.1\Contbrun.exe %%i -regress -quit
)

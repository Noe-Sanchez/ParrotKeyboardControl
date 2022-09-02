# ------------------- Required for MSVC nmake ---------------------------------
# This file should be included at the top of a MAKEFILE as follows:


CPU = AMD64

MODEL  = parrot_keyboard_control
TARGET = cgxe
MODULE_SRCS 	= m_3YttJ5tzdpTPtVQkledOMC.c
MODEL_SRC	= parrot_keyboard_control_cgxe.c
MODEL_REG = parrot_keyboard_control_cgxe_registry.c
MAKEFILE    = parrot_keyboard_control_cgxe.mak
MATLAB_ROOT	= D:\tempoLAB\andereScheisse
BUILDARGS   =

#--------------------------- Tool Specifications ------------------------------
#
#
MSVC_ROOT1 = $(MSDEVDIR:SharedIDE=vc)
MSVC_ROOT2 = $(MSVC_ROOT1:SHAREDIDE=vc)
MSVC_ROOT  = $(MSVC_ROOT2:sharedide=vc)

# Compiler tool locations, CC, LD, LIBCMD:
CC     = cl.exe
LD     = link.exe
LIBCMD = lib.exe
#------------------------------ Include/Lib Path ------------------------------


USER_INCLUDES   =  /I "C:\Users\danfo\documents\MATLAB\Examples\R2022a\parrot\gettingstartedkeyboardcontrolofparrotexample\slprj\_cgxe\parrot_keyboard_control\src" /I "C:\Users\danfo\documents\MATLAB\Examples\R2022a\parrot\gettingstartedkeyboardcontrolofparrotexample" /I "C:\programdata\MATLAB\supportpackages\R2022a\toolbox\target\supportpackages\parrot\parrotexamples" /I "C:\Users\danfo\Documents\MATLAB\Examples\R2022a\parrot\GettingStartedKeyboardControlofParrotExample\slprj\_cprj"

MLSL_INCLUDES     = \
    /I "D:\tempoLAB\andereScheisse\extern\include" \
    /I "D:\tempoLAB\andereScheisse\simulink\include" \
    /I "D:\tempoLAB\andereScheisse\rtw\c\src"
COMPILER_INCLUDES = /I "$(MSVC_ROOT)\include"

THIRD_PARTY_INCLUDES   =  /I "C:\Users\danfo\Documents\MATLAB\Examples\R2022a\parrot\GettingStartedKeyboardControlofParrotExample\slprj\_cgxe\parrot_keyboard_control\src" /I "C:\Users\danfo\Documents\MATLAB\Examples\R2022a\parrot\GettingStartedKeyboardControlofParrotExample"
INCLUDE_PATH = $(MLSL_INCLUDES) $(USER_INCLUDES) $(THIRD_PARTY_INCLUDES)
LIB_PATH     = "$(MSVC_ROOT)\lib"
CFLAGS = /c /Zp8 /GR /w /EHs /D_CRT_SECURE_NO_DEPRECATE /D_SCL_SECURE_NO_DEPRECATE /D_SECURE_SCL=0 /DMX_COMPAT_64 /DMATLAB_MEXCMD_RELEASE=R2018a /DMATLAB_MEX_FILE /nologo /MD   
LDFLAGS = /nologo /dll /MANIFEST /OPT:NOREF /export:mexFunction /export:mexfilerequiredapiversion  
#----------------------------- Source Files -----------------------------------

USER_OBJS =

AUX_SRCS = D:\tempoLAB\andereScheisse\extern\version\c_mexapi_version.c  

REQ_SRCS  = $(MODEL_SRC) $(MODEL_REG) $(MODULE_SRCS) $(AUX_SRCS)
REQ_OBJS = $(REQ_SRCS:.cpp=.obj)
REQ_OBJS2 = $(REQ_OBJS:.c=.obj)
OBJS = $(REQ_OBJS2) $(USER_OBJS) $(AUX_ABS_OBJS)
OBJLIST_FILE = parrot_keyboard_control_cgxe.mol
TMWLIB = "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmx.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmex.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmat.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libfixedpoint.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libut.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwmathutil.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libemlrt.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwcgxert.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwcgxeooprt.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwslexec_simbridge.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwslccrt.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwstringutil.lib" "D:\tempoLAB\andereScheisse\lib\win64\libmwipp.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libcovrt.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwsl_sfcn_cov_bridge.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\libmwdsp_halidesim.lib" "D:\tempoLAB\andereScheisse\extern\lib\win64\microsoft\dspcgsim.lib" 
THIRD_PARTY_LIBS = 

#--------------------------------- Rules --------------------------------------

MEX_FILE_NAME_WO_EXT = $(MODEL)_$(TARGET)
MEX_FILE_NAME = $(MEX_FILE_NAME_WO_EXT).mexw64
all : $(MEX_FILE_NAME) 


$(MEX_FILE_NAME) : $(MAKEFILE) $(OBJS)
	@echo ### Linking ...
	$(LD) $(LDFLAGS) /OUT:$(MEX_FILE_NAME) /map:"$(MEX_FILE_NAME_WO_EXT).map" $(TMWLIB) $(THIRD_PARTY_LIBS) @$(OBJLIST_FILE)
     mt -outputresource:"$(MEX_FILE_NAME);2" -manifest "$(MEX_FILE_NAME).manifest"
	@echo ### Created $@

.c.obj :
	@echo ### Compiling "$<"
	$(CC) $(CFLAGS) $(INCLUDE_PATH) "$<"

.cpp.obj :
	@echo ### Compiling "$<"
	$(CC) $(CFLAGS) $(INCLUDE_PATH) "$<"

